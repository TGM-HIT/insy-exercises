# Content Management Systeme – Schulredaktion mit WordPress

## Ausgangslage und Ziele

Das TGM möchte Interessierten einen übersichtlichen Einstieg in die Schule bieten.
Eine kleine Schulredaktion pflegt Neuigkeiten und Abteilungsinformationen, ohne
dass jede Textänderung von einer technischen Administratorin erledigt werden muss.
Ihr entwickelt dafür eine **lokale Demonstrationswebsite**: einen One-Pager mit
zwei Abteilungsseiten und einem nachvollziehbaren redaktionellen Freigabeablauf.

Am Ende könnt ihr Inhalte, Darstellung und technische Administration unterscheiden,
ein CMS betreiben, Rollen begründen und ihre tatsächlichen Rechte nachweisen.
Das vorhandene Thema **TGM-Website**, die sechs Schulrollen, Gruppen von maximal
zwei Personen und die Zuordnung **grundlegende Kompetenz** bleiben erhalten.
Die Website ist ein Unterrichtsprototyp; sie ersetzt nicht den offiziellen Schulauftritt.

**Arbeitsumfang:** Konzeption, Einrichtung, Redaktion, Gestaltung und Abnahme.
Als Planungsvorschlag sind 8–12 Unterrichtseinheiten einschließlich Tests sinnvoll;
der tatsächliche Umfang hängt von euren Docker- und WordPress-Vorkenntnissen ab.
Abgabetermin laut Lernplattform. Die alten Termine aus 2025/2026 gelten nicht weiter.

## Material und geprüfter Technologiestand

Ladet [material.zip](material.zip) herunter und arbeitet im entpackten Ordner
`material`. Es enthält Docker Compose, Logo/Schriften, eine leere Rollenmatrix,
ein Testprotokoll und Hilfen zur Sicherung. Es enthält **keine fertige Website,
Benutzerkonfiguration oder ausgefüllte Berechtigungsmatrix**.

| Bestandteil | Geprüfte Basis | Entscheidung |
| --- | --- | --- |
| WordPress | 7.1, offizielles Image `wordpress:7.1.0-php8.5-apache` | Aktuelle stabile WordPress-Version mit Apache und PHP 8.5. |
| Datenbank | MariaDB 12.3.3 | Aktuelle LTS-Linie; kein unversionierter Datenbanktag. |
| Hilfswerkzeug | WP-CLI 2.12.0 mit PHP 8.5 | Reproduzierbare Versionsabfrage und Sicherung. |
| Rollenverwaltung | Members 3.2.26, kostenlose Version | Eigene Rollen über eine Oberfläche erstellen und vergleichen. |
| Block-Theme | Twenty Twenty-Five 1.5 als getestete Basis | Site Editor, lokale Schriften und Gestaltung ohne zusätzlichen Page Builder. |

Stand und [offizielle Quellen](SOURCES.md): **13.09.2026**. Die genauen Image-Digests
und PHP-Patchversionen dokumentiert ihr aus eurer Installation. Ein neuerer
kompatibler Wartungsstand ist sinnvoll, wenn ihr ihn überprüft und die Abnahmetests
wiederholt. Installiert keine Beta-/RC-Versionen. Für ein anderes Theme dokumentiert
ihr Aktualität, Block-Editor-Unterstützung und den eigenen Funktionstest.

## 1. Konzeption: Aufgaben, Rollen und Grenzen

Erstellt vor dem Aufbau eine kurze Sitemap, eine Skizze des One-Pagers und ein
UML-Akteur-/Anwendungsfalldiagramm. Überlegt, welche Informationen Interessierte
schnell finden müssen und welche Inhalte die Redaktion häufig ändert.
Sichtet dazu die [offizielle TGM-Website](https://www.tgm.ac.at/) und nennt drei
Informationen, die ihr in eurem kleineren Demonstrationsauftritt anders anordnet.
Keine vollständige Kopie der Schulwebsite erstellen.

Plant diese **sechs organisatorischen Rollen**:

- Schüler
- Klassenadministrator: redaktionell für eine Klasse zuständig
- Lehrer
- Redakteur
- Abteilungsadministrator: inhaltlich für eine Abteilung zuständig
- Administrator: technische Verwaltung des CMS

Füllt `roles-matrix.md` aus. Trennt pro Aktion **was**, **wessen Inhalte** und
**wo**: beispielsweise eigene Entwürfe schreiben, fremde Beiträge überarbeiten,
veröffentlichen, Seiten bearbeiten, Medien hochladen, Benutzer oder Plugins verwalten.
Ein Schulrollenname allein ist keine Begründung für technische Administratorrechte.

Bei UML bedeutet Generalisierung die Übernahme der Anwendungsfälle des allgemeineren
Akteurs. Eine schulische Weisungskette ist nicht automatisch eine passende
Akteurvererbung; WordPress vererbt Rollen auch nicht entlang eures UML-Diagramms.
Zeichnet nur fachlich begründete Generalisierungen.

!!! important "Schulweites Zielmodell und umgesetzter Pilot"
    Beschreibt zunächst das gewünschte Modell für mehrere Klassen und Abteilungen.
    Die praktische Grundaufgabe verwendet **eine gemeinsame Pilotredaktion** auf
    einer WordPress-Website. Alle sechs Rollen werden eingerichtet; die Testkonten
    gehören zu diesem einen Team. Klassen- und Abteilungskategorien ordnen Inhalte,
    bilden aber **keine technische Zugriffsschranke**. Kennzeichnet im Konzept
    ausdrücklich, welche geplante Bereichsgrenze der Pilot noch nicht durchsetzt.
    Eine schulweite, getrennte Mandanten- oder Klassenverwaltung ist kein
    versteckter Pflichtteil dieser Grundaufgabe.

Für den Pilot gelten diese überprüfbaren Anforderungen. Die passende Kombination
von WordPress-Capabilities erarbeitet ihr selbst:

1. Schüler können eigene Beiträge als Entwurf/„Ausstehende Überprüfung“ speichern,
   aber weder veröffentlichen noch fremde Beiträge verändern.
2. Klassenadministratoren können fremde Entwürfe im Pilotteam redaktionell bearbeiten
   und zur Freigabe vorbereiten, aber nicht selbst veröffentlichen.
3. Lehrer können eigene Beiträge einschließlich eines Bildes veröffentlichen,
   aber keine fremden Beiträge verändern.
4. Redakteure können die Beiträge des Pilotteams prüfen und veröffentlichen sowie
   die Informationsseiten pflegen.
5. Abteilungsadministratoren übernehmen im Pilot ebenfalls redaktionelle Freigabe
   und Seitenpflege. Die gewünschte Beschränkung auf ihre Abteilung wird im
   schulweiten Modell geplant, ist im Pilot aber noch nicht umgesetzt.
6. Nur technische Administratoren verwalten Benutzer/Rollen, Plugins und Themes.

Zwei organisatorische Rollen dürfen im Pilot dieselben technischen Rechte haben,
wenn ihr das begründet. Vergebt für jedes Testkonto genau eine Rolle, damit eure
Tests nicht durch zusätzlich zugewiesene Rollen verfälscht werden.

## 2. Arbeitsumgebung aufbauen und erklären

Folgt der README im Material. Der reguläre Weg ist eine isolierte Docker-Compose-
Installation. Eine gleichwertige eigene Linux-VM ist zulässig, wenn Versionen,
Persistenz, Rollen und Wiederherstellung ebenso nachgewiesen werden; eine zweite
Installationsvariante wird nicht verlangt.

```powershell
Copy-Item .env.example .env
# Jetzt .env öffnen: Projektname und zwei eigene Datenbankpasswörter eintragen.
docker compose config --quiet
docker compose pull
docker compose up -d --wait
docker compose ps
```

Öffnet `http://127.0.0.1:8085` und führt den Installer durch. Stellt Sprache,
Zeitzone, Permalinks und eine statische Startseite ein. Verwendet eigene
Demopasswörter und erfundene Konten; keine echten Schülerdaten oder echten
Kontaktformulare. Das lokale System benötigt keinen E-Mail-Dienst.

Erklärt anhand einer kleinen Architekturskizze Browser → Apache/PHP → Datenbank.
Ordnet Beiträge, Benutzerrechte, Uploads, Themes und Navigation dem passenden
Speicherort zu. Prüft, dass ein Stoppen und erneutes Starten eure Inhalte erhält.
Warum ist ein Container nicht dasselbe wie das persistente Volume?

!!! tip "Versionskontrolle und Betrieb"
    `.env` und Sicherungen bleiben lokal. Der Webport ist nur an Loopback gebunden;
    Datenbankports werden nicht nach außen veröffentlicht. Erklärt, welche
    Änderungen für einen tatsächlichen Schulserver nötig wären, insbesondere HTTPS,
    Updates, Backups und Verantwortlichkeiten. Eine öffentliche Bereitstellung ist
    nicht Teil der Aufgabe.

## 3. Rollen einrichten und Redaktion durchführen

Installiert **Members** aus dem offiziellen Pluginverzeichnis und verwendet dessen
Rollenverwaltung. Legt fünf eigene Schulrollen und den vorhandenen technischen
Administrator an; eigene Slugs können z.B. mit `schule_` beginnen. Klont eine
geeignete Standardrolle und passt deren Rechte an. Verändert die eingebauten
Standardrollen nicht, damit ihr jederzeit einen Vergleich habt.

Erstellt je ein Demokonto für die sechs Rollen. Dokumentiert die gewählte
Ausgangsrolle und mindestens eine begründete Anpassung. Prüft insbesondere den
Unterschied zwischen Beiträgen und Seiten sowie eigenen und fremden Inhalten.
Members-Bezahlschranken, private Gesamtwebsite und kostenpflichtige Erweiterungen
werden nicht benötigt. Unbenutzte Plugins deaktivieren/entfernen; jede aktive
Erweiterung muss einen nachvollziehbaren Zweck erfüllen.

Führt einen echten Arbeitsablauf mit verschiedenen Konten durch:

1. Ein Schüler verfasst einen kurzen Bericht und reicht ihn zur Prüfung ein.
2. Ein Klassenadministrator verbessert einen Inhalt dieses Berichts und hält den
   Bearbeitungsgrund im Protokoll fest.
3. Ein Redakteur kontrolliert und veröffentlicht den Bericht.
4. Ruft die veröffentlichte Fassung ohne Anmeldung auf und weist Autor sowie
   mindestens eine erkennbare Änderung nach. Nutzt Revisionen, sofern für den
   Inhalt vorhanden, oder einen Vorher-/Nachher-Vergleich im Protokoll.

### Pflichtversuche zu Berechtigungen

Führt diese Versuche mit den jeweiligen Konten aus, nicht mit dem Administrator.
Notiert Testdaten, Soll, Ist und Nachweis in `testprotokoll.md`:

| Test | Erwartung |
| --- | --- |
| Schüler speichert eigenen Entwurf. | Erlaubt. |
| Schüler veröffentlicht oder bearbeitet einen fremden Beitrag direkt. | Verboten; keine unerlaubte Inhaltsänderung. |
| Klassenadministrator bearbeitet einen fremden Entwurf. | Erlaubt. |
| Klassenadministrator versucht ihn zu veröffentlichen. | Verboten. |
| Lehrer lädt ein Bild hoch und veröffentlicht einen eigenen Beitrag. | Erlaubt. |
| Lehrer versucht einen fremden Beitrag zu ändern. | Verboten. |
| Redakteur veröffentlicht den Schülerbeitrag und bearbeitet eine Seite. | Erlaubt. |
| Abteilungsadministrator pflegt eine Seite. | Erlaubt. |
| Jede der fünf Schulrollen versucht Benutzer/Rollen bzw. Plugins/Themes zu verwalten. | Verboten. |
| Administrator verwaltet ein Demokonto und das gewählte Theme. | Erlaubt. |

Öffnet bei mindestens zwei Negativtests einen bekannten direkten Bearbeitungslink.
Ein ausgeblendeter Menüpunkt allein belegt keine Zugriffskontrolle. Eigene
Penetrationstests oder Angriffe sind nicht erforderlich.

**Grenzversuch:** Legt zwei Demobeiträge mit Kategorien „Klasse A“ und „Klasse B“
an. Prüft mit dem Klassenadministrator den fremden Beitrag aus Klasse B. Im hier
vorgesehenen Pilot kann das erlaubt sein, weil `edit_others_posts` global wirkt.
Erklärt den Unterschied zwischen erfolgreich umgesetzter Pilotanforderung und
fehlender Bereichstrennung. Nennt eine geeignete technische Erweiterungsstrategie
für den schulweiten Einsatz (z.B. eine geprüfte Rechte-Erweiterung oder getrennte
Sites) und welche Gegenprobe sie bestehen müsste. Die Umsetzung dieser Erweiterung
ist nicht Voraussetzung für die Grundkompetenz.

## 4. Website und Theme gestalten

Wählt begründet ein gepflegtes Block-Theme. Vergleicht eure Wahl kurz mit einer
Alternative nach drei Kriterien, etwa Lesbarkeit, Anpassbarkeit und Abhängigkeiten.
Eine Installation beider Themes ist nicht nötig. Die getestete Basis ist
Twenty Twenty-Five; ein zusätzlicher Page Builder ist nicht erforderlich.

Setzt diese überschaubare Informationsstruktur um:

- One-Pager als Startseite: Einstieg, Ausbildungsangebot, Neuigkeiten, Einblick
  in Schulprojekte und Kontakt/Orientierung. Jeder Hauptabschnitt besitzt einen
  verständlichen Ankerlink in der Navigation.
- Zwei Abteilungs-Unterseiten mit eigener Überschrift, einem nachvollziehbaren
  Ausbildungsprofil und einem Link zurück zum Ausbildungsabschnitt der Startseite.
- Mindestens drei kurze, selbst formulierte Demobeiträge, davon einer aus dem
  Freigabeablauf. Zeigt diese dynamisch über einen Abfrage-/Query-Loop-Block an.
- Ein weiterer unveröffentlichter Entwurf darf im öffentlichen Neuigkeitenbereich
  nicht erscheinen. Prüft das ohne Anmeldung.

Stimmt Farben und Typografie auf das bereitgestellte TGM-Material ab und notiert
eure verwendeten Farbwerte. Nutzt `TGMLogo.png` ungefähr in Originalgröße.
Importiert die bereitgestellten Schriften **lokal über die Schriftbibliothek** und
weist sie passend zu; prüft dabei Lesbarkeit, Schriftschnitte und Ersatzschrift.
Bearbeitet keine Dateien des heruntergeladenen Parent-Themes. Verwendet Site-Editor-
Stile; begrenztes eigenes CSS ist bei begründetem Bedarf möglich.

Kontrolliert die Website bei etwa **390 px und 1280 px Breite**, mit der Tastatur
und ohne Anmeldung: Navigation, sichtbarer Fokus, lesbare Kontraste, Überschriften-
struktur, Alternativtexte und kein horizontaler Überlauf. Ein funktionierender
CMS-Auftritt zählt stärker als aufwendige Grafikeffekte.

Kennzeichnet die Website sichtbar als **„Lokaler Unterrichtsentwurf – keine
offizielle TGM-Website“**. Schreibt Demotexte selbst; verwendet ausschließlich
bereitgestellte oder selbst erstellte Medien. Keine erfundenen offiziellen Termine,
Anmeldemöglichkeiten oder Funktionsversprechen der Schule veröffentlichen.

## 5. Sicherung und Wiederherstellung nachweisen

Sichert nach der Redaktion Datenbank und `wp-content` gemeinsam. Eine WordPress-
XML-Exportdatei allein ersetzt keine vollständige Sicherung mit Rollen,
Einstellungen, Plugins, Themes und hochgeladenen Dateien. Das Material enthält
ein Hilfsskript; erklärt trotzdem, welchen Bestandteil die beiden Archive sichern.

```sh
docker compose stop wordpress
docker compose run --rm archive backup abnahme01
docker compose start wordpress
```

Stellt die Sicherung nach der README in einem **zweiten Compose-Projekt auf Port
8086** wieder her. Verwendet einen neuen Projektnamen und füllt im Ziel nicht
noch einmal den Installer aus. Die ursprüngliche Installation bleibt erhalten.
Prüft in der Kopie mindestens Beitrag, Logo/Medium, Navigation, Theme-Anpassung,
aktive Plugins und einen erlaubten sowie einen verbotenen Rollenzugriff.
Kontrolliert Links auf den neuen Port. Erklärt, warum Dateien und Datenbank beide
nötig sind und warum eine geänderte URL auch gespeicherte Inhalte betreffen kann.

## Abgabe und Abnahme

Arbeitet allein oder zu zweit. Abzugeben sind ein knappes Protokoll mit Sitemap,
UML-Diagramm, ausgefüllter Rechte-/Testmatrix, Versionsstand, Themeentscheidung,
Quellen und Wiederherstellungsnachweis sowie die für eure Umgebung nötigen
Konfigurationsdateien **ohne Passwörter**. Jede Person nennt ihren Anteil und
erklärt einen Rollenversuch und einen Teil des Betriebs.

Zeigt das laufende lokale System und die wiederhergestellte Kopie. Eine reine
Screenshotsammlung ersetzt die Vorführung nicht. Die private Sicherung hält ihr
für die Abnahme bereit; sie gehört nicht ins öffentliche Repository. Kennzeichnet
KI-Unterstützung und erklärt eigene Entscheidungen. Als kleine Änderung im Gespräch
kann z.B. ein neuer Beitrag oder eine Anpassung eines Rollenrechts verlangt werden.

### Reflexionsfragen

1. Warum löst eine UML-Hierarchie noch kein WordPress-Berechtigungsproblem?
2. Welche Wirkung haben eigene/fremde Beiträge, Seiten und Kategorien auf eure Rollen?
3. Wo liegen Theme-Dateien, globale Stile, Inhalte und Benutzerrechte tatsächlich?
4. Welche Vorteile hat ein CMS gegenüber einer statischen Website für diesen Fall,
   und welche zusätzlichen Betriebspflichten entstehen?
5. Was fehlt eurem Pilot für einen echten schulweiten Redaktionsbetrieb?

## Bewertung – grundlegende Kompetenz

Die Vorlage war insgesamt als **grundlegende Kompetenz** ausgewiesen. Diese
Zuordnung bleibt erhalten; es werden keine Aufgaben in EK verschoben und keine
neuen EK-Pflichten eingeführt. Da die Vorlage keine feinere Bewertungsmatrix enthielt,
ist die folgende Konkretisierung in [CHECK.md](CHECK.md) ein **Bewertungsvorschlag**.

**Grundlegend überwiegend:** CMS läuft persistent; die sechs Rollen sind geplant
und eingerichtet; eigener Entwurf/Freigabe und zentrale Verbote sind nachgewiesen;
One-Pager, zwei Unterseiten und TGM-Gestaltung sind erkennbar umgesetzt; nachvollziehbare
Dokumentation und Vorführung vorhanden.

**Grundlegend vollständig:** Alle Pilotanforderungen und Pflichtversuche einschließlich
Bereichsgrenze erfüllt; dynamische Inhalte, Entwurfsfilter und responsive Bedienung
geprüft; Wiederherstellung in einer zweiten Installation erfolgreich; Entscheidungen,
Grenzen und Reflexionsfragen im Gespräch erklärt.

Optionale Weiterarbeit nach abgeschlossener Grundaufgabe: tatsächliche Klassen-/
Abteilungstrennung oder ein eigener kleiner Block. Das sind Lernangebote ohne hier
festgelegte zusätzliche Bewertung. Umfang vor einer Erweiterung mit der Lehrkraft abstimmen.

*Mit KI-Unterstützung überarbeitet. Version 20260913v1 – lokaler Unterrichtsentwurf.*
