# CMS-Material – lokale WordPress-Installation

Dieses Paket stellt nur die Laufzeit, Gestaltungsmittel und leere Protokollvorlagen
bereit. Website, Inhalte, Benutzer, Rollen und Berechtigungsmatrix erstellt ihr selbst.
Arbeitet im entpackten Ordner `material`, in dem `compose.yaml` liegt.

## Start unter Windows, Linux oder macOS

Docker Desktop mit Linux-Containern bzw. Docker Engine und Compose v2 benötigt.
Unter Windows muss die Hardwarevirtualisierung aktiv sein. Prüft zunächst
`docker version` und `docker compose version`. Docker muss einen Server anzeigen.

1. Kopiert `.env.example` nach `.env` (PowerShell: `Copy-Item .env.example .env`,
   Linux/macOS: `cp .env.example .env`). Aktiviert im Dateimanager die Anzeige
   versteckter Dateien und Dateiendungen, damit nicht versehentlich `.env.txt` entsteht.
2. Tragt in `.env` zwei verschiedene lokale Datenbankpasswörter ein, z.B. je
   24 zufällige Buchstaben/Ziffern. Legt einen eindeutigen Projektnamen fest.
   Die WordPress-Benutzer erhalten später eigene Passwörter im Installer.
3. Startet:

```sh
docker compose config --quiet
docker compose pull
docker compose up -d --wait
docker compose ps
```

4. Öffnet `http://127.0.0.1:8085` (bei geändertem `WP_PORT` euren Port).
   Installiert WordPress mit einem erfundenen Schulnamen und einem eigenen
   Administrator. Verwendet ausschließlich lokale Demokonten und z.B.
   `admin@example.test`; E-Mail-Versand wird in dieser Übung nicht eingerichtet.
5. Setzt Zeitzone `Europe/Vienna`, gewünschte Sprache und sprechende Permalinks.
   Bearbeitet die Website durchgehend unter derselben URL, nicht abwechselnd
   mit `localhost` und `127.0.0.1`. Registrierung bleibt deaktiviert.
6. Installiert über das Backend **Members** (Autor MemberPress) und aktiviert es.
   Geprüft wurde 3.2.26. Kostenpflichtiges MemberPress ist nicht nötig. Verwendet
   nur den Rollenmanager, keine private Gesamtwebsite oder Bezahlschranke.
7. Installiert/aktiviert ein Block-Theme. Getestete Basis: **Twenty Twenty-Five 1.5**.
   Die Themeauswahl und die gestalterische Anpassung sind eure Aufgaben.

Die Installation über das Backend bietet jeweils den aktuellen Stand an. Wenn
eine neuere Version erscheint, dokumentiert sie und wiederholt die Rollen-/Frontendtests.
Für genau den geprüften Stand gibt es alternativ folgende Befehle:

```sh
docker compose run --rm cli plugin install members --version=3.2.26 --activate
docker compose run --rm cli theme install twentytwentyfive --version=1.5 --activate
docker compose run --rm cli core version
docker compose exec wordpress php -v
docker compose run --rm cli db query "SELECT VERSION();"
docker compose run --rm cli plugin list
docker compose run --rm cli theme list
```

Bereits vorhandenes Theme: Version im Backend prüfen; ein erneuter Installationsbefehl
ist dann nicht nötig. Das Startpaket enthält keine kopierten Plugin-/Themequelltexte.

## Was läuft wo?

- `wordpress`: WordPress 7.1 (Docker-Tag `7.1.0-php8.5-apache`) und Apache/PHP.
- `db`: MariaDB 12.3.3; Datenbankport nur im internen Compose-Netzwerk.
- `cli`: WP-CLI 2.12.0 mit PHP 8.5; startet nur bei `run` und endet danach.
- `archive`: Hilfswerkzeug für Sicherung und Wiederherstellung; startet nur bei `run`.
- `wordpress_data`: WordPress-Dateien, Uploads, Themes und Plugins.
- `db_data`: Datenbank, einschließlich Inhalte, Benutzer, Rollen und Einstellungen.

Der Webport ist an `127.0.0.1` gebunden. HTTP ist hier auf die lokale
Demonstration beschränkt; ein echter Schulserver benötigt HTTPS und eine eigene
Betriebsplanung. Es werden keine öffentlichen Hostingkonten benötigt.
Exakte PHP-Patchversionen und Image-Digests im eigenen Protokoll festhalten:

```sh
docker image inspect wordpress:7.1.0-php8.5-apache --format '{{json .RepoDigests}}'
docker image inspect mariadb:12.3.3 --format '{{json .RepoDigests}}'
```

Versions-Tags können für Wartungsupdates neu gebaut werden. `docker compose pull`
ersetzt die Dateien in einem bereits initialisierten WordPress-Volume nicht
automatisch. WordPress-Updates im Backend separat durchführen und testen.

## Logo und Schriften

`assets/TGMLogo.png` kann regulär als Website-Logo hochgeladen werden. Es ist nur
103 × 53 Pixel groß. Kein SVG-Upload-Plugin installieren und nicht großziehen.
Ladet TGM-Regular, TGM-Bold und TGM-Italic über die WordPress-Schriftbibliothek
hoch, nicht über den normalen Medien-Upload. Je nach Oberfläche findet ihr diese
unter Design/Schriften oder im Site Editor unter Stile/Typografie/Schriften verwalten.
Weist die Schrift einer passenden Textgruppe zu; prüft Lesbarkeit und Fallbacks.
Die genaue Benennung der Familie ergibt sich aus den Font-Metadaten.
In den gelieferten Dateien heißt Regular intern `TGM Normal`, Bold/Italic dagegen
`TGM`. Die Oberfläche kann sie daher als zwei Familien anzeigen. Prüft die
Zuordnung bewusst; eine einheitliche Familienanzeige wird nicht vorausgesetzt.
Herkunftshinweise stehen in `assets/HERKUNFT.md`.

## Stoppen und Fortsetzen

```sh
docker compose stop
docker compose start
```

`docker compose down` entfernt Container und Netzwerk, erhält aber die benannten
Volumes. `docker compose down -v` löscht auch Datenbank und Website-Dateien.
Für die Übung ist die Löschung der Quellinstallation nicht erforderlich.
Passwörter in `.env` initialisieren die Datenbank nur beim ersten Start. Eine
spätere Änderung in `.env` ändert nicht automatisch den bestehenden Datenbankbenutzer.

## Sichern und in ein zweites Projekt wiederherstellen

Die Hilfsskripte sind für dieses lokale Paket und selbst erstellte Sicherungen
gedacht. Sie sichern Datenbank und `wp-content`, nicht Docker-Images oder `.env`.
Behaltet deshalb Compose-Datei, Versionen und eure lokale `.env` ebenfalls sicher.
Sicherungen enthalten Konten und Passwort-Hashes; nicht ins öffentliche Repository
oder in das normale Abgabeprotokoll aufnehmen.

1. Alle Bearbeitungen beenden. WordPress stoppen, damit Dateien und Datenbank
   während der gemeinsamen Sicherung unverändert bleiben; MariaDB läuft weiter.

```sh
docker compose stop wordpress
docker compose run --rm archive backup abnahme01
docker compose start wordpress
```

Der Sicherungsname darf nur Buchstaben, Ziffern, `_` und `-` enthalten. Ein
vorhandener Name wird nicht überschrieben. `backups/abnahme01` enthält SQL,
Dateiarchiv, URL, Versionen und Prüfsummen. Nur eine Erfolgsmeldung am Ende
kennzeichnet eine abgeschlossene Sicherung. Nach einem Fehler ebenfalls
`docker compose start wordpress` ausführen; für den nächsten Versuch neuen Namen wählen.

2. Legt `.env.restore` als Kopie von `.env` an. Ändert darin **beide** Werte:
   `COMPOSE_PROJECT_NAME=insy-cms-team01-restore` und `WP_PORT=8086`.
   Quell- und Zielprojekt müssen unterschiedlich heißen. Startet aus demselben
   Materialordner; so bleibt der Sicherungsordner erreichbar:

```sh
docker compose --env-file .env.restore up -d --wait
docker compose --env-file .env.restore stop wordpress
docker compose --env-file .env.restore run --rm archive restore abnahme01 http://127.0.0.1:8086
docker compose --env-file .env.restore start wordpress
```

Im Ziel **nicht** den Browser-Installer ausfüllen. Das Skript akzeptiert nur ein
frisches, nicht installiertes Ziel mit derselben WordPress-Version. Es importiert
die Datenbank, entpackt `wp-content` und ersetzt die Quell-URL unter Beachtung
serialisierter Daten. Die Anmeldung erfolgt mit den gesicherten Demokonten.
Bei einem abgebrochenen Restore einen neuen Zielprojektnamen wählen, statt
unbemerkt eine teilweise wiederhergestellte Installation weiterzuverwenden.

3. Prüft auf Port 8086 einen Beitrag, ein hochgeladenes Bild, Navigation, Design,
   Pluginstatus und mindestens einen erlaubten/verbotenen Rollenzugriff.
   Kontrolliert, dass Bild- und Navigationslinks nicht zurück auf Port 8085 führen.
4. Beendet die nicht mehr benötigte Kopie mit
   `docker compose --env-file .env.restore down` (Volumes bleiben erhalten).

## Abnahmeprüfung ohne Anmeldung

`scripts/abnahme-check.sh` prüft die öffentliche Website auf die automatisch prüfbaren
Punkte aus TASK.md. Benötigt werden `curl`, `grep`, `sed` und `sort`.

```sh
BASE_URL=http://127.0.0.1:8085 DRAFT_TITLE="Interner Entwurf" PAGE_SLUGS="abteilung-a abteilung-b" BACK_ANCHOR=ausbildung bash scripts/abnahme-check.sh
```

Die Variablen `DRAFT_TITLE`, `PAGE_SLUGS` und `BACK_ANCHOR` sind optional; ohne sie
werden die zugehörigen Prüfungen als „PRÜFEN“ ausgegeben. Rollen, Layout, Tastatur
und Kontraste prüft das Skript nicht.

## Häufige Fehler

- Port belegt: Vor der Erstinstallation `WP_PORT` in `.env` ändern. Bei einer
  bestehenden Website müssen zusätzlich die gespeicherten URLs angepasst werden.
- `DB_PASSWORD` fehlt: `.env` und Dateiendung prüfen; Leerwerte werden absichtlich abgewiesen.
- Datenbank startet noch: `docker compose ps` und `docker compose logs --tail 60 db`
  prüfen. Keine fremden Volumes löschen.
- Linux: Bind-Mount-Ordner `backups` muss existieren. Das Archivwerkzeug läuft nur
  im lokalen Container als root, damit es die Sicherungsdateien schreiben kann.
  Nach Restore setzt es die Website-Dateien auf den Apache-Benutzer 33 zurück.
- Theme-Editor fehlt: Block-Theme aktivieren und mit Administrator anmelden.
- Schüler können keine Bilder hochladen: Rechteplan prüfen; WordPress-Mitarbeiter
  (`contributor`) dürfen standardmäßig keine Medien hochladen.
- Menüpunkt unsichtbar: Das ist noch kein Berechtigungsnachweis. Direkten Bearbeitungslink
  mit dem betreffenden Testkonto öffnen.

Technischer Stand: 13.09.2026. Details und Aufgaben stehen in TASK.md des Kursmoduls.
