#!/usr/bin/env bash
# Prüft die öffentliche Website ohne Anmeldung auf die automatisch prüfbaren Abnahmepunkte.
# Aufruf (Linux/macOS, Git Bash unter Windows), Beispiel:
#   BASE_URL=http://127.0.0.1:8085 DRAFT_TITLE="Interner Entwurf" PAGE_SLUGS="abteilung-a abteilung-b" BACK_ANCHOR=ausbildung bash scripts/abnahme-check.sh
# Benötigt: curl, grep, sed, sort.
set -u

BASE_URL=${BASE_URL:-http://127.0.0.1:8085}
BASE_URL=${BASE_URL%/}
DRAFT_TITLE=${DRAFT_TITLE:-}
PAGE_SLUGS=${PAGE_SLUGS:-}
BACK_ANCHOR=${BACK_ANCHOR:-}
MIN_POSTS=${MIN_POSTS:-3}
ORIGIN=$(printf '%s' "$BASE_URL" | sed -E 's#^(https?://[^/]+).*#\1#')
ORIGIN_RE=$(printf '%s' "$ORIGIN" | sed 's/\./\\./g')

fails=0
warns=0
ok() { printf '[OK]      %s\n' "$1"; }
fail() { printf '[FEHLT]  %s\n' "$1"; fails=$((fails + 1)); }
warn() { printf '[PRÜFEN] %s\n' "$1"; warns=$((warns + 1)); }
get() { curl -sSL --max-time 15 "$1" 2>/dev/null; }
code() { curl -s -o /dev/null -w '%{http_code}' --max-time 15 "$1"; }

echo "Prüfung: $BASE_URL"
echo

home_code=$(code "$BASE_URL/")
if [ "$home_code" != "200" ]; then
  echo "Startseite nicht erreichbar ($BASE_URL/, HTTP $home_code). Prüfe: docker compose ps"
  exit 1
fi
home=$(get "$BASE_URL/")
ok "Startseite erreichbar"

if grep -q 'Lokaler Unterrichtsentwurf' <<<"$home" && grep -q 'keine offizielle TGM-Website' <<<"$home"; then
  ok "Kennzeichnung als lokaler Unterrichtsentwurf vorhanden"
else
  fail "Kennzeichnung „Lokaler Unterrichtsentwurf – keine offizielle TGM-Website“ fehlt"
fi

if grep -q 'name="viewport"' <<<"$home"; then
  ok "Viewport-Angabe für mobile Darstellung vorhanden"
else
  fail "Viewport-Angabe fehlt (mobile Darstellung bei 390 px nicht möglich)"
fi

if grep -qE '<html[^>]*lang="' <<<"$home"; then
  ok "Sprachangabe im html-Element vorhanden"
else
  fail "Sprachangabe im html-Element fehlt"
fi

h1_count=$(grep -oiE '<h1[ >]' <<<"$home" | wc -l | tr -d ' ')
if [ "$h1_count" = "1" ]; then
  ok "Genau eine Hauptüberschrift (h1) auf der Startseite"
else
  warn "$h1_count h1-Überschriften auf der Startseite – Überschriftenstruktur prüfen"
fi

anchors=$(grep -oE 'href="[^"]*#[A-Za-z0-9_-]+"' <<<"$home" | sed -E 's/.*#//; s/"$//' | sort -u)
if [ -z "$anchors" ]; then
  fail "Keine Ankerlinks auf der Startseite gefunden"
else
  broken=""
  for a in $anchors; do
    grep -q "id=\"$a\"" <<<"$home" || broken="$broken $a"
  done
  n_anchor=$(printf '%s\n' "$anchors" | grep -c .)
  if [ -z "$broken" ]; then
    ok "$n_anchor Ankerlinks zeigen auf vorhandene Abschnitte"
  else
    fail "Ankerlinks ohne Ziel:$broken"
  fi
  if [ "$n_anchor" -lt 5 ]; then
    warn "Nur $n_anchor Ankerziele – Hauptabschnitte aus TASK.md prüfen (Einstieg, Angebot, Neuigkeiten, Projekte, Kontakt)"
  fi
fi

if grep -q 'wp-block-post-template' <<<"$home"; then
  ok "Query-Loop-Block zeigt Beiträge dynamisch an"
else
  fail "Kein Query-Loop-Block auf der Startseite gefunden"
fi

if grep -qE '<img[^>]*logo' <<<"$home" || grep -qi 'TGMLogo' <<<"$home"; then
  logo=$(grep -oiE '<img[^>]*>' <<<"$home" | grep -i 'logo' | head -n 1)
  if grep -q 'alt=""' <<<"$logo"; then
    warn "Logo hat leeren Alternativtext (nur bei rein dekorativem Logo vertretbar)"
  else
    ok "Logo als Bild mit Alternativtext eingebunden"
  fi
else
  fail "Logo ist auf der Startseite nicht als Bild eingebunden"
fi

if grep -qE 'font-family:[^;}]*TGM' <<<"$home"; then
  ok "TGM-Schrift wird im Frontend verwendet"
else
  warn "Keine TGM-Schrift im Frontend-CSS erkannt – Schriftbibliothek und Stile prüfen"
fi

all="$home"
page_pass=0
for slug in $PAGE_SLUGS; do
  url="$BASE_URL/$slug/"
  c=$(code "$url")
  if [ "$c" != "200" ]; then
    fail "Seite „$slug“ nicht erreichbar (HTTP $c)"
    continue
  fi
  page=$(get "$url")
  all="$all
$page"
  page_pass=$((page_pass + 1))

  if grep -qiE '<h[12][ >]' <<<"$page"; then
    ok "$slug: Überschrift vorhanden"
  else
    fail "$slug: keine Überschrift (h1/h2) gefunden"
  fi

  backs=$(grep -oE "href=\"($ORIGIN_RE)?/#[A-Za-z0-9_-]+\"" <<<"$page" | sed -E 's/.*#//; s/"$//' | sort -u)
  if [ -z "$backs" ]; then
    fail "$slug: kein Rücklink mit Anker zur Startseite"
  else
    dangling=""
    for a in $backs; do
      grep -q "id=\"$a\"" <<<"$home" || dangling="$dangling $a"
    done
    if [ -n "$dangling" ]; then
      fail "$slug: Rücklink ins Leere:$dangling"
    else
      ok "$slug: Rücklink zur Startseite funktioniert"
    fi
    if [ -n "$BACK_ANCHOR" ] && ! grep -qx "$BACK_ANCHOR" <<<"$backs"; then
      fail "$slug: kein Rücklink auf den Abschnitt #$BACK_ANCHOR"
    fi
  fi
done

if [ -z "$PAGE_SLUGS" ]; then
  warn "PAGE_SLUGS nicht gesetzt – Abteilungsseiten nicht geprüft"
fi

api_code=$(code "$BASE_URL/wp-json/wp/v2/posts")
if [ "$api_code" = "200" ]; then
  posts=$(get "$BASE_URL/wp-json/wp/v2/posts?per_page=100&_fields=id,title,status")
  n_posts=$(grep -o '"id":' <<<"$posts" | wc -l | tr -d ' ')
  if [ "$n_posts" -ge "$MIN_POSTS" ]; then
    ok "$n_posts veröffentlichte Beiträge ohne Anmeldung sichtbar (mindestens $MIN_POSTS)"
  else
    fail "Nur $n_posts veröffentlichte Beiträge sichtbar (mindestens $MIN_POSTS nötig)"
  fi

  if grep -qE '"status":"(draft|pending|future|private)"' <<<"$posts"; then
    fail "Unveröffentlichte Beiträge sind in der öffentlichen Abfrage enthalten"
  else
    ok "Öffentliche Abfrage enthält nur veröffentlichte Beiträge"
  fi

  hidden=$(get "$BASE_URL/wp-json/wp/v2/posts?status=draft,pending&per_page=100&_fields=id")
  if grep -q '"id":' <<<"$hidden"; then
    fail "Entwürfe sind ohne Anmeldung direkt abrufbar"
  else
    ok "Direkte Abfrage von Entwürfen ohne Anmeldung liefert nichts"
  fi

  if [ -n "$DRAFT_TITLE" ]; then
    if grep -qF "$DRAFT_TITLE" <<<"$home$posts"; then
      fail "Entwurf „$DRAFT_TITLE“ erscheint öffentlich"
    else
      ok "Entwurf „$DRAFT_TITLE“ erscheint nicht öffentlich"
    fi
  else
    warn "DRAFT_TITLE nicht gesetzt – Entwurfsprüfung über den Titel übersprungen"
  fi
else
  fail "REST-API unter /wp-json nicht erreichbar (HTTP $api_code) – sprechende Permalinks prüfen"
fi

foreign=$(grep -oE 'https?://(127\.0\.0\.1|localhost):[0-9]+' <<<"$all" | sort -u | grep -vxF "$ORIGIN")
if [ -n "$foreign" ]; then
  fail "Links verweisen auf andere lokale Ports: $(echo $foreign)"
else
  ok "Keine Links auf fremde lokale Ports (z. B. 8085 nach Restore auf 8086)"
fi

echo
echo "Ergebnis: $fails Fehler, $warns zu prüfen."
echo
echo "Nicht automatisch prüfbar – im Testprotokoll dokumentieren:"
echo " - Layout bei etwa 390 px und 1280 px ohne horizontalen Überlauf"
echo " - Tastaturbedienung, sichtbarer Fokus, Kontraste"
echo " - Inhaltliche Alternativtexte, Schriftschnitte und Ersatzschrift"
echo " - Alle Rollenversuche mit den eingeloggten Testkonten"
echo " - Wiederherstellung: Anmeldung mit den gesicherten Konten"

if [ "$fails" -gt 0 ]; then
  exit 1
fi
exit 0
