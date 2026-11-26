---
hide:
  - navigation
---

# "*Content Management Systeme*" - Taskdescription

## Einführung
Das TGM möchte Interessierten einen übersichtlichen Einstieg in die Schule bieten. Eine kleine Schulredaktion pflegt Neuigkeiten und Abteilungsinformationen, ohne dass jede Textänderung von einer technischen Administratorin erledigt werden muss. Du entwickelst dafür eine **lokale Demonstrationswebsite**: einen One-Pager mit zwei Abteilungsseiten und einem nachvollziehbaren redaktionellen Freigabeablauf.

Am Ende kannst du Inhalte, Darstellung und technische Administration unterscheiden, ein CMS betreiben, Rollen begründen und ihre tatsächlichen Rechte nachweisen. Das vorhandene Thema **TGM-Website**, die sechs Schulrollen, Gruppen von maximal zwei Personen und die Zuordnung **grundlegende Kompetenz** bleiben erhalten. Die Website ist ein Unterrichtsprototyp; sie ersetzt nicht den offiziellen Schulauftritt.

**Arbeitsumfang:** Konzeption, Einrichtung, Redaktion, Gestaltung und Abnahme. Als Planungsvorschlag sind 8–12 Unterrichtseinheiten einschließlich Tests sinnvoll; der tatsächliche Umfang hängt von deinen Docker- und WordPress-Vorkenntnissen ab.

## Ziele
Du kannst Inhalte, Darstellung und technische Administration eines CMS unterscheiden, eine WordPress-Website lokal betreiben, Benutzerrollen begründen und deren tatsächliche Rechte mit Testkonten nachweisen. Außerdem kannst du eine Website sichern und in einer zweiten Installation wiederherstellen.

## Kompetenzzuordnung

#### Grundlegende Kompetenz
* "ein Content Management System einrichten und betreiben"
* "Rollen und Berechtigungen begründen und ihre Wirkung überprüfen"
* "Inhalte, Gestaltung und technische Administration unterscheiden"
* "eine Website sichern und in einer zweiten Installation wiederherstellen"

## Voraussetzungen
* Grundverständnis von Datenmodellierung und Berechtigungen
* Grundkenntnisse im Umgang mit Browser, URLs und Dateien
* Lesen und Umsetzen von Arbeitsanweisungen
* Grundkenntnisse in Terminal und Docker sind hilfreich

## Detaillierte Aufgabenbeschreibung
Bearbeite die Aufgaben in der angegebenen Reihenfolge. Dokumentiere jeden Schritt knapp und nachvollziehbar in deinem Protokoll.

### Material und geprüfter Technologiestand
Lade das [Materialpaket](https://download-directory.github.io/?url=https%3A%2F%2Fgithub.com%2FTGM-HIT%2Finsy-exercises%2Ftree%2Fmain%2Fdocs%2Fsem07%2F75_CMS%2Fproject) herunter und arbeite im entpackten Ordner `project`. Er enthält Docker Compose, Logo/Schriften, eine leere Rollenmatrix, ein Testprotokoll und Hilfen zur Sicherung. Er enthält **keine fertige Website, Benutzerkonfiguration oder ausgefüllte Berechtigungsmatrix**.

| Bestandteil | Geprüfte Basis | Entscheidung |
| --- | --- | --- |
| WordPress | 7.1, offizielles Image `wordpress:7.1.0-php8.5-apache` | Aktuelle stabile WordPress-Version mit Apache und PHP 8.5. |
| Datenbank | MariaDB 12.3.3 | Aktuelle LTS-Linie; kein unversionierter Datenbanktag. |
| Hilfswerkzeug | WP-CLI 2.12.0 mit PHP 8.5 | Reproduzierbare Versionsabfrage und Sicherung. |
| Rollenverwaltung | Members 3.2.26, kostenlose Version | Eigene Rollen über eine Oberfläche erstellen und vergleichen. |
| Block-Theme | Twenty Twenty-Five 1.5 als getestete Basis | Site Editor, lokale Schriften und Gestaltung ohne zusätzlichen Page Builder. |

Stand und [offizielle Quellen](SOURCES.md): **13.09.2026**. Die genauen Image-Digests und PHP-Patchversionen dokumentierst du aus deiner Installation. Ein neuerer kompatibler Wartungsstand ist sinnvoll, wenn du ihn überprüfst und die Abnahmetests wiederholst. Installiere keine Beta- oder RC-Versionen. Für ein anderes Theme dokumentierst du Aktualität, Block-Editor-Unterstützung und deinen eigenen Funktionstest.

### Aufgabe 1 - Konzeption: Aufgaben, Rollen und Grenzen
Erstelle vor dem Aufbau eine kurze Sitemap, eine Skizze des One-Pagers und ein UML-Akteur-/Anwendungsfalldiagramm. Überlege, welche Informationen Interessierte schnell finden müssen und welche Inhalte die Redaktion häufig ändert. Sichte dazu die [offizielle TGM-Website](https://www.tgm.ac.at/) und nenne drei Informationen, die du in deinem kleineren Demonstrationsauftritt anders anordnest. Erstelle keine vollständige Kopie der Schulwebsite.

Plane diese **sechs organisatorischen Rollen**:

- Schüler
- Klassenadministrator: redaktionell für eine Klasse zuständig
- Lehrer
- Redakteur
- Abteilungsadministrator: inhaltlich für eine Abteilung zuständig
- Administrator: technische Verwaltung des CMS

Fülle `roles-matrix.md` aus. Trenne pro Aktion **was**, **wessen Inhalte** und **wo**: beispielsweise eigene Entwürfe schreiben, fremde Beiträge überarbeiten, veröffentlichen, Seiten bearbeiten, Medien hochladen, Benutzer oder Plugins verwalten. Ein Schulrollenname allein ist keine Begründung für technische Administratorrechte.

Bei UML bedeutet Generalisierung die Übernahme der Anwendungsfälle des allgemeineren Akteurs. Eine schulische Weisungskette ist nicht automatisch eine passende Akteurvererbung; WordPress vererbt Rollen auch nicht entlang deines UML-Diagramms. Zeichne nur fachlich begründete Generalisierungen.

!!! important "Schulweites Zielmodell und umgesetzter Pilot"
    Beschreibe zunächst das gewünschte Modell für mehrere Klassen und Abteilungen.
    Die praktische Grundaufgabe verwendet **eine gemeinsame Pilotredaktion** auf
    einer WordPress-Website. Alle sechs Rollen werden eingerichtet; die Testkonten
    gehören zu diesem einen Team. Klassen- und Abteilungskategorien ordnen Inhalte,
    bilden aber **keine technische Zugriffsschranke**. Kennzeichne im Konzept
    ausdrücklich, welche geplante Bereichsgrenze der Pilot noch nicht durchsetzt.
    Eine schulweite, getrennte Mandanten- oder Klassenverwaltung ist kein
    versteckter Pflichtteil dieser Grundaufgabe.

Für den Pilot gelten diese überprüfbaren Anforderungen. Die passende Kombination von WordPress-Capabilities erarbeitest du selbst:

1. Schüler können eigene Beiträge als Entwurf bzw. „Ausstehende Überprüfung“ speichern, aber weder veröffentlichen noch fremde Beiträge verändern.
2. Klassenadministratoren können fremde Entwürfe im Pilotteam redaktionell bearbeiten und zur Freigabe vorbereiten, aber nicht selbst veröffentlichen.
3. Lehrer können eigene Beiträge einschließlich eines Bildes veröffentlichen, aber keine fremden Beiträge verändern.
4. Redakteure können die Beiträge des Pilotteams prüfen und veröffentlichen sowie die Informationsseiten pflegen.
5. Abteilungsadministratoren übernehmen im Pilot ebenfalls redaktionelle Freigabe und Seitenpflege. Die gewünschte Beschränkung auf ihre Abteilung wird im schulweiten Modell geplant, ist im Pilot aber noch nicht umgesetzt.
6. Nur technische Administratoren verwalten Benutzer/Rollen, Plugins und Themes.

Zwei organisatorische Rollen dürfen im Pilot dieselben technischen Rechte haben, wenn du das begründest. Vergib für jedes Testkonto genau eine Rolle, damit deine Tests nicht durch zusätzlich zugewiesene Rollen verfälscht werden.

### Aufgabe 2 - Arbeitsumgebung aufbauen und erklären
Folge der README im Material. Der reguläre Weg ist eine isolierte Docker-Compose-Installation. Eine gleichwertige eigene Linux-VM ist zulässig, wenn du Versionen, Persistenz, Rollen und Wiederherstellung ebenso nachweist; eine zweite Installationsvariante wird nicht verlangt.

```powershell
Copy-Item .env.example .env
# Jetzt .env öffnen: Projektname und zwei eigene Datenbankpasswörter eintragen.
docker compose config --quiet
docker compose pull
docker compose up -d --wait
docker compose ps
```

Öffne `http://127.0.0.1:8085` und führe den Installer durch. Stelle Sprache, Zeitzone, Permalinks und eine statische Startseite ein. Verwende eigene Demopasswörter und erfundene Konten; keine echten Schülerdaten oder echten Kontaktformulare. Das lokale System benötigt keinen E-Mail-Dienst.

Erkläre anhand einer kleinen Architekturskizze Browser → Apache/PHP → Datenbank. Ordne Beiträge, Benutzerrechte, Uploads, Themes und Navigation dem passenden Speicherort zu. Prüfe, dass ein Stoppen und erneutes Starten deine Inhalte erhält. Warum ist ein Container nicht dasselbe wie das persistente Volume?

!!! tip "Versionskontrolle und Betrieb"
    `.env` und Sicherungen bleiben lokal. Der Webport ist nur an Loopback gebunden;
    Datenbankports werden nicht nach außen veröffentlicht. Erkläre, welche
    Änderungen für einen tatsächlichen Schulserver nötig wären, insbesondere HTTPS,
    Updates, Backups und Verantwortlichkeiten. Eine öffentliche Bereitstellung ist
    nicht Teil der Aufgabe.

### Aufgabe 3 - Rollen einrichten und Redaktion durchführen
Installiere **Members** aus dem offiziellen Pluginverzeichnis und verwende dessen Rollenverwaltung. Lege fünf eigene Schulrollen und den vorhandenen technischen Administrator an; eigene Slugs können z.B. mit `schule_` beginnen. Klone eine geeignete Standardrolle und passe deren Rechte an. Verändere die eingebauten Standardrollen nicht, damit du jederzeit einen Vergleich hast.

Erstelle je ein Demokonto für die sechs Rollen. Dokumentiere die gewählte Ausgangsrolle und mindestens eine begründete Anpassung. Prüfe insbesondere den Unterschied zwischen Beiträgen und Seiten sowie eigenen und fremden Inhalten. Members-Bezahlschranken, private Gesamtwebsite und kostenpflichtige Erweiterungen werden nicht benötigt. Deaktiviere bzw. entferne unbenutzte Plugins; jede aktive Erweiterung muss einen nachvollziehbaren Zweck erfüllen.

Führe einen echten Arbeitsablauf mit verschiedenen Konten durch:

1. Ein Schüler verfasst einen kurzen Bericht und reicht ihn zur Prüfung ein.
2. Ein Klassenadministrator verbessert einen Inhalt dieses Berichts und hält den Bearbeitungsgrund im Protokoll fest.
3. Ein Redakteur kontrolliert und veröffentlicht den Bericht.
4. Rufe die veröffentlichte Fassung ohne Anmeldung auf und weise Autor sowie mindestens eine erkennbare Änderung nach. Nutze Revisionen, sofern für den Inhalt vorhanden, oder einen Vorher-/Nachher-Vergleich im Protokoll.

#### Pflichtversuche zu Berechtigungen
Führe diese Versuche mit den jeweiligen Konten aus, nicht mit dem Administrator. Notiere Testdaten, Soll, Ist und Nachweis in `testprotokoll.md`:

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

Öffne bei mindestens zwei Negativtests einen bekannten direkten Bearbeitungslink. Ein ausgeblendeter Menüpunkt allein belegt keine Zugriffskontrolle. Eigene Penetrationstests oder Angriffe sind nicht erforderlich.

**Grenzversuch:** Lege zwei Demobeiträge mit Kategorien „Klasse A“ und „Klasse B“ an. Prüfe mit dem Klassenadministrator den fremden Beitrag aus Klasse B. Im hier vorgesehenen Pilot kann das erlaubt sein, weil `edit_others_posts` global wirkt. Erkläre den Unterschied zwischen erfolgreich umgesetzter Pilotanforderung und fehlender Bereichstrennung. Nenne eine geeignete technische Erweiterungsstrategie für den schulweiten Einsatz (z.B. eine geprüfte Rechte-Erweiterung oder getrennte Sites) und welche Gegenprobe sie bestehen müsste. Die Umsetzung dieser Erweiterung ist nicht Voraussetzung für die Grundkompetenz.

### Aufgabe 4 - Website und Theme gestalten
Wähle begründet ein gepflegtes Block-Theme. Vergleiche deine Wahl kurz mit einer Alternative nach drei Kriterien, etwa Lesbarkeit, Anpassbarkeit und Abhängigkeiten. Eine Installation beider Themes ist nicht nötig. Die getestete Basis ist Twenty Twenty-Five; ein zusätzlicher Page Builder ist nicht erforderlich.

Setze diese überschaubare Informationsstruktur um:

- One-Pager als Startseite: Einstieg, Ausbildungsangebot, Neuigkeiten, Einblick in Schulprojekte und Kontakt/Orientierung. Jeder Hauptabschnitt besitzt einen verständlichen Ankerlink in der Navigation.
- Zwei Abteilungs-Unterseiten mit eigener Überschrift, einem nachvollziehbaren Ausbildungsprofil und einem Link zurück zum Ausbildungsabschnitt der Startseite.
- Mindestens drei kurze, selbst formulierte Demobeiträge, davon einer aus dem Freigabeablauf. Zeige diese dynamisch über einen Abfrage-/Query-Loop-Block an.
- Ein weiterer unveröffentlichter Entwurf darf im öffentlichen Neuigkeitenbereich nicht erscheinen. Prüfe das ohne Anmeldung.

Stimme Farben und Typografie auf das bereitgestellte TGM-Material ab und notiere deine verwendeten Farbwerte. Nutze `TGMLogo.png` ungefähr in Originalgröße. Importiere die bereitgestellten Schriften **lokal über die Schriftbibliothek** und weise sie passend zu; prüfe dabei Lesbarkeit, Schriftschnitte und Ersatzschrift. Bearbeite keine Dateien des heruntergeladenen Parent-Themes. Verwende Site-Editor-Stile; begrenztes eigenes CSS ist bei begründetem Bedarf möglich.

Kontrolliere die Website bei etwa **390 px und 1280 px Breite**, mit der Tastatur und ohne Anmeldung: Navigation, sichtbarer Fokus, lesbare Kontraste, Überschriftenstruktur, Alternativtexte und kein horizontaler Überlauf. Ein funktionierender CMS-Auftritt zählt stärker als aufwendige Grafikeffekte.

Kennzeichne die Website sichtbar als **„Lokaler Unterrichtsentwurf – keine offizielle TGM-Website“**. Schreibe Demotexte selbst; verwende ausschließlich bereitgestellte oder selbst erstellte Medien. Veröffentliche keine erfundenen offiziellen Termine, Anmeldemöglichkeiten oder Funktionsversprechen der Schule.

### Aufgabe 5 - Sicherung und Wiederherstellung nachweisen
Sichere nach der Redaktion Datenbank und `wp-content` gemeinsam. Eine WordPress-XML-Exportdatei allein ersetzt keine vollständige Sicherung mit Rollen, Einstellungen, Plugins, Themes und hochgeladenen Dateien. Das Material enthält ein Hilfsskript; erkläre trotzdem, welchen Bestandteil die beiden Archive sichern.

```sh
docker compose stop wordpress
docker compose run --rm archive backup abnahme01
docker compose start wordpress
```

Stelle die Sicherung nach der README in einem **zweiten Compose-Projekt auf Port 8086** wieder her. Verwende einen neuen Projektnamen und fülle im Ziel nicht noch einmal den Installer aus. Die ursprüngliche Installation bleibt erhalten. Prüfe in der Kopie mindestens Beitrag, Logo/Medium, Navigation, Theme-Anpassung, aktive Plugins und einen erlaubten sowie einen verbotenen Rollenzugriff. Kontrolliere Links auf den neuen Port. Erkläre, warum Dateien und Datenbank beide nötig sind und warum eine geänderte URL auch gespeicherte Inhalte betreffen kann.

## Fragestellungen
### Grundlegend
* Warum löst eine UML-Hierarchie noch kein WordPress-Berechtigungsproblem?
* Welche Wirkung haben eigene/fremde Beiträge, Seiten und Kategorien auf deine Rollen?
* Wo liegen Theme-Dateien, globale Stile, Inhalte und Benutzerrechte tatsächlich?
* Welche Vorteile hat ein CMS gegenüber einer statischen Website für diesen Fall, und welche zusätzlichen Betriebspflichten entstehen?
* Was fehlt deinem Pilot für einen echten schulweiten Redaktionsbetrieb?

## Abgabe
Arbeite allein oder zu zweit. Abzugeben sind ein knappes Protokoll mit Sitemap, UML-Diagramm, ausgefüllter Rechte-/Testmatrix, Versionsstand, Themeentscheidung, Quellen und Wiederherstellungsnachweis sowie die für deine Umgebung nötigen Konfigurationsdateien **ohne Passwörter**. Jede Person nennt ihren Anteil und erklärt einen Rollenversuch und einen Teil des Betriebs.

Zeige das laufende lokale System und die wiederhergestellte Kopie. Eine reine Screenshotsammlung ersetzt die Vorführung nicht. Die private Sicherung hältst du für die Abnahme bereit; sie gehört nicht ins öffentliche Repository. Kennzeichne KI-Unterstützung und erkläre eigene Entscheidungen. Als kleine Änderung im Gespräch kann z.B. ein neuer Beitrag oder eine Anpassung eines Rollenrechts verlangt werden.

Abgabetermin laut Lernplattform. Die alten Termine aus 2025/2026 gelten nicht weiter.

## Bewertung
Gruppengröße: 1–2 Personen

Die Vorlage war insgesamt als **grundlegende Kompetenz** ausgewiesen. Diese Zuordnung bleibt erhalten; es werden keine Aufgaben in EK verschoben und keine neuen EK-Pflichten eingeführt. Da die Vorlage keine feinere Bewertungsmatrix enthielt, ist die folgende Konkretisierung in [CHECK.md](CHECK.md) ein **Bewertungsvorschlag**.

### Grundanforderungen **überwiegend erfüllt**

- [ ]  CMS läuft persistent
- [ ]  Die sechs Rollen sind geplant und eingerichtet
- [ ]  Eigener Entwurf/Freigabe und zentrale Verbote sind nachgewiesen
- [ ]  One-Pager, zwei Unterseiten und TGM-Gestaltung sind erkennbar umgesetzt
- [ ]  Nachvollziehbare Dokumentation und Vorführung vorhanden

### Grundanforderungen **zur Gänze erfüllt**

- [ ]  Alle Pilotanforderungen und Pflichtversuche einschließlich Bereichsgrenze erfüllt
- [ ]  Dynamische Inhalte, Entwurfsfilter und responsive Bedienung geprüft
- [ ]  Wiederherstellung in einer zweiten Installation erfolgreich
- [ ]  Entscheidungen, Grenzen und Reflexionsfragen im Gespräch erklärt

### Erweiterte Anforderungen **überwiegend erfüllt**

Keine zusätzlichen Anforderungen festgelegt. Optionale Weiterarbeit nach abgeschlossener Grundaufgabe – tatsächliche Klassen-/Abteilungstrennung oder ein eigener kleiner Block – ist ein Lernangebot ohne hier festgelegte zusätzliche Bewertung. Den Umfang vor einer Erweiterung mit der Lehrkraft abstimmen.

### Erweiterte Anforderungen **zur Gänze erfüllt**

Keine zusätzlichen Anforderungen festgelegt (siehe oben).

*:robot: Diese Aufgabe wurde Mithilfe von KI erstellt.*

## Quellen
* "WordPress herunterladen"; zuletzt besucht 2026-09-13; [online](https://wordpress.org/download/)
* "WordPress-Anforderungen"; zuletzt besucht 2026-09-13; [online](https://wordpress.org/about/requirements/)
* "WordPress/PHP-Kompatibilität"; zuletzt besucht 2026-09-13; [online](https://make.wordpress.org/core/handbook/references/php-compatibility-and-wordpress-versions/)
* "Offizielles WordPress-Docker-Image"; zuletzt besucht 2026-09-13; [online](https://hub.docker.com/_/wordpress)
* "MariaDB 12.3 LTS"; zuletzt besucht 2026-09-13; [online](https://mariadb.org/mariadb-server-12-3-lts-released/)
* "Offizielles MariaDB-Image"; zuletzt besucht 2026-09-13; [online](https://hub.docker.com/_/mariadb)
* "WordPress: Rollen und Capabilities"; zuletzt besucht 2026-09-13; [online](https://wordpress.org/documentation/article/roles-and-capabilities/)
* "Plugin-Handbuch: Rollen"; zuletzt besucht 2026-09-13; [online](https://developer.wordpress.org/plugins/users/roles-and-capabilities/)
* "Members im Pluginverzeichnis"; zuletzt besucht 2026-09-13; [online](https://wordpress.org/plugins/members/)
* "Members: Rollenverwaltung"; zuletzt besucht 2026-09-13; [online](https://members-plugin.com/docs/role-management/)
* "Members: Rollen klonen"; zuletzt besucht 2026-09-13; [online](https://members-plugin.com/docs/clone-roles/)
* "WordPress Site Editor"; zuletzt besucht 2026-09-13; [online](https://wordpress.org/documentation/article/site-editor/)
* "Twenty Twenty-Five"; zuletzt besucht 2026-09-13; [online](https://wordpress.org/themes/twentytwentyfive/)
* "WordPress-Schriftbibliothek"; zuletzt besucht 2026-09-13; [online](https://wordpress.org/documentation/article/the-font-library/)
* "Query Loop Block"; zuletzt besucht 2026-09-13; [online](https://wordpress.org/documentation/article/query-loop-block/)
* "WordPress-Backups"; zuletzt besucht 2026-09-13; [online](https://developer.wordpress.org/advanced-administration/security/backup/)
* "WP-CLI: Datenbankexport"; zuletzt besucht 2026-09-13; [online](https://developer.wordpress.org/cli/commands/db/export/)
* "WP-CLI: Datenbankimport"; zuletzt besucht 2026-09-13; [online](https://developer.wordpress.org/cli/commands/db/import/)
* "WP-CLI: search-replace"; zuletzt besucht 2026-09-13; [online](https://developer.wordpress.org/cli/commands/search-replace/)
* "Materialpaket"; [online](https://download-directory.github.io/?url=https%3A%2F%2Fgithub.com%2FTGM-HIT%2Finsy-exercises%2Ftree%2Fmain%2Fdocs%2Fsem07%2F75_CMS%2Fproject)
* "Offizielle TGM-Website"; [online](https://www.tgm.ac.at/)

---

**Version**  *20261126v1*
