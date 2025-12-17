# Informationssysteme "Vue PWA"

## Einführung
Bei dieser Übung soll die vorhandene Implementierung in der Cloud deployed werden und auch als PWA für mobile Endgeräte angeboten werden.

## Ziele
Das Ziel dieser Übung ist das Bereitstellen einer Webanwendung in der Cloud. Dabei sollen Werkzeuge zum Einsatz kommen, die das leichte Umsetzen, Testen und Bereitstellen beschleunigen. Bestehender Code soll dabei angepasst und erweitert werden ohne die Funktionalität zu beeinträchtigen.

## Voraussetzungen
+ Docker Compose
+ Kenntnisse über Javascript
+ Funktionstüchtige ReST Schnittstelle aus "ReST Backend"
+ Funktionstüchtige JS-Applikation aus "Vue CRUD"
+ Kenntnisse über CI/CD-Workflow oder Zusammenarbeit mit DevOps Engineer

## Detailierte Aufgabenstellung
Basierend auf der Übung [Vue CRUD](https://tgm-hit.github.io/insy-exercises/informationssysteme_/sem09_vue_crud/TASK) soll nun die ganze Implementierung in der Cloud zugänglich gemacht werden.

### Grundlegende Kompetenzen
Die bestehende JS-Applikation soll als *Progressive Webapplication* konfiguriert werden, um lokal gespeicherte Einstellungen als auch schnellere Ladezeiten und grundlegende Offline-Funktionen auf mobilen Endgeräten zu ermöglichen. Die Applikation soll als Icon auf dem Startbildschirm abgelegt und im Vollbild ohne sichtbare Browser-UI geöffnet werden können. Um die Funktionalitäten im vollsten Maße auch auf mobilen Geräten nutzen zu können, soll ein *Cloud-Deployment* durchgeführt werden. Dafür bietet sich das *Github-Student-Developer-Pack* an, welches Cloud-Deployments bei Heroku oder Digital-Ocean kostenfrei zur Verfügung stellt. Die Implementierung muss dabei öffentlich zugänglich sein und daher auch mit einem einfachen Login gesichert werden.

Nutzen Sie die Kenntnisse Ihrer Kolleg:innen und binden Sie die Applikation in einen *CI/CD-Workflow* ein. Es sollen alle Bereiche der Applikation ausreichend getestet und dies auch über Testreports ersichtlich sein. Die bestehende Implementierung soll auf Kundenwunsch nun auch mit einem *Auswahlfeld für Attribute* der einzelnen Tabellen und einer Dark/Light-*Theme* erweitert werden.

### Erweiterte Kompetenzen
- **Filterung (dateIn/dateOut, SampleID/AnalysisID, Flags) und Paging am Server** Um eine Erhöhung der Performance sicherzustellen, ist eine Filterung der Datensätze im Backend zu implementieren, die auf Zeitspannen, die IDs und Flags die zurückgegebenen Daten einschränkt. Wichtig ist dabei auf die Performance zu achten, da bei den Tests dann eine komplette Datenbank eingespielt wird.
- **Export der angezeigten Analysen und Samples als CSV über ReST-Schnittstelle** Die eingeschränkte Datenmenge über die Filter
- **Login von Usern mit den Rollen Reader, Admin und Researcher**  Für den *Login von Usern* mit den Rollen Reader, Admin und Researcher soll schon bereitstehender Code der DevOps-Engineers eingesetzt werden. Der Login soll auch den Zugriff auf das Backend einschränken. Hierfür bietet sich eine JWA-Implementierung an.
- **User der Researcher-Rolle bekommen nur eingeschränkte Daten zur Verfügung gestellt** Wenn sich ein Benutzer mit der Rolle *Researcher* einloggt, sollen nur Samples und Analysen über die Rest-Schnittstelle zurückgegeben werden, wo die Flags mit F oder V beginnen. Nur diese dürfen übergeben und angezeigt werden.
- **Erstellung und Anzeige der Reports auf Basis der SQL-Funktionen** Die Datenbank enthält vordefinierte SQL-Funktionen, die für tägliche Reports gebraucht werden. Es sollen folgende Punkte analysiert und angezeigt werden:
	+ Rueckstellbehaelter beinhalten Probenummern ohne Analyse
	+ Rueckstellbehaelter beinhalten keine Probenummer
	+ Verdaechtige Probenummern im gewünschten Zeitraum
	+ Analysen haben keine Rueckstellposition
	+ Analysen haben 0 Werte
	+ Analysen haben keine Start- bzw. Endzeit
	+ Proben haben mehr als 1 Analyse (mit Angabe der Anzahl)
	+ Verdaechtige Probenummern
	+ Probenummern mit falscher EAN13 Pruefziffer

- **Globale Filterung nach einem gesetzten Start- und Enddatum** Die Datenbank kann über Kampagnen-Grenzen hinweg Daten enthalten, die bei der täglichen Arbeit störend wirken können. Dies soll mit einem Setzen eines Start- und End-Datums für die DateIn-Werte im Backend gefiltert werden.

## Abgabe
Im Repository soll das `README.md` die notwendigen Schritte beschreiben. Auch das kombinierte `docker-compose.yml` soll enthalten sein. Bitte die Binaries und Class-Files in das `.gitignore` eintragen, sodass keine irrtümliche Abgabe erfolgt (besonders das `node-modules` Verzeichnis). Die Source-Code Files sollen getrennt abgelegt werden. Jegliche Änderungen müssen im `CHANGELOG.md` dokumentiert werden.

Bei der Verwendung von KI-Tools müssen die Prompts im Verzeichnis `prompts/` als Markdown-Files exportiert werden. Hier soll darauf geachtet werden, dass die Anfrage als auch die Quellen der Antworten ersichtlich sind.

### Classroom Repository
[Hier](https://classroom.github.com/a/F7XdDVq4) finden Sie das Abgabe-Repository zum Entwickeln und Commiten Ihrer Lösung.

## Help, oh I need somebody

## Bewertung
Gruppengrösse: 3 Personen
### Grundanforderungen überwiegend erfüllt
- [ ] PWA Konfiguration
- [ ] Cloud-Deployment mit einfachem Login
- [ ] Einbindung von CI/CD-Workflow mit Testreports

### Grundanforderungen zur Gänze erfüllt
- [ ] Auswahlfeld von zu anzeigenden Attributen der einzelnen Tabellen
- [ ] Theme mit dark/light Switch

### Erweiterte Anforderungen überwiegend erfüllt
- [ ] Filterung (dateIn/dateOut, SampleID/AnalysisID, Flags) und Paging am Server
- [ ] Export der angezeigten Analysen als CSV über ReST-Schnittstelle
- [ ] Login von Usern mit den Rollen Reader, Admin und Researcher

### Erweiterte Anforderungen zur Gänze erfüllt
- [ ] User der Researcher-Rolle bekommen nur eingeschränkte Daten zur Verfügung gestellt
- [ ] Erstellung und Anzeige der Reports auf Basis der SQL-Funktionen
- [ ] Globale Filterung nach einem gesetzten Start- und Enddatum

## Quellen
* [CLI Plugin PWA](https://cli.vuejs.org/core-plugins/pwa.html#example-configuration)

* [GitHub Student Developer Pack](https://education.github.com/pack)
* [Heroku for GitHub Students](https://www.heroku.com/github-students/)
* [App Platform Quickstart](https://docs.digitalocean.com/products/app-platform/getting-started/quickstart/#create-an-app)

* [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
* [Write changelogs for humans](https://github.com/vweevers/common-changelog)
* [Turn your GitHub Changelog into a dedicated Website](https://openchangelog.com/blog/github-changelog)

---
**Version** *20251216v2*
