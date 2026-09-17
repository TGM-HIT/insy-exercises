# Informationssysteme "Vue CRUD"

## Einführung
Bei dieser Übung sollen für eine bestehende ReST-Schnittstelle mithilfe eines JS-Frameworks die CRUD Funktionen auf Data-Tables implementiert werden.

## Ziele
Das Ziel dieser Übung ist das Bereitstellen einer grundlegenden Datenmanipulation über eine JS-View. Dabei sollen Werkzeuge zum Einsatz kommen, die das leichte Umsetzen und Bereitstellen beschleunigen. Die grafische Oberfläche soll die bestehenden Resourcen sinnvoll nutzen, und für besondere Funktionen (Business Use Cases) erweiterbar sein.

## Voraussetzungen
+ Docker Compose
+ Kenntnisse über Javascript
+ Funktionstüchtige ReST Schnittstelle aus "ReST Backend"
+ Grundlagen über ReST-API

## Detailierte Aufgabenstellung
Basierend auf der Übung [Vue Datatable](https://tgm-hit.github.io/insy-exercises/informationssysteme_/sem09_vue_datatable/TASK) sollen nun folgende Tabellen editierbar sein: **Analysis**, **Sample**, **Box**, **BoxPos**. Die Tabelle **Log** soll weiterhin nur lesend zur Verfügung gestellt werden. Die Ansicht der Tabelle **Analysis** soll neben der _SampleID_ und _SampleTime_ auch noch die Attribute *weight_bru*, *weight_net*, *name* und die View *Box* erhalten. Auch die Ansicht von **Sample** soll die abgelegte Position in der Box über die zur Verfügung gestellte View **sample_boxpos** angezeigt bekommen.

Die Attribute, die in den einzelnen Tabellen auch indiziert (siehe `restore.sql`) sind, müssen in der angezeigten Tabelle auch sortierbar sein.

Eine direkte Änderung der Datensätze in der Tabelle wäre von Vorteil. Es ist darauf zu achten, dass bestimmte Attribute nicht veränderbar sein sollen:

* Analysis
    - ID (a_id)
    - SampleID (s_id)
    - SampleTime (s_stamp)
    - weightBru (weight_bru)
    - weightNet (weight_net)
    - Name (name)
    - Box
* Sample
    - SampleID (s_id)
    - SampleTime (s_stamp)
* Box
    - BoxID (b_id)
* BoxPos
    - BoxID (b_id)
    - BoxPosID (bpos_id)

Es muss bei der Bearbeitung und Erstellung der einzelnen Datensätze auf die Konsistenzüberprüfung geachtet und entsprechende Fehlermeldungen generiert werden. Die Darstellung der Tabellen **Box** und **BoxPos** sollte passend gewählt werden, es würde sich eine kombinierte Form der Anzeige dabei anbieten.

Das Sortieren der indexierten Datensätze soll über die Anzeige der Attribute ermöglicht werden. Bei der Filterung soll das Backend angedacht werden. Welche Parameter müsste man hier übergeben?

## Abgabe
Im Repository soll das `README.md` die notwendigen Schritte beschreiben. Auch das verwendete `docker-compose.yml` soll enthalten sein. Bitte alle Binaries und Class-Files in das `.gitignore` eintragen, sodass keine irrtümliche Abgabe erfolgt (besonders das `node-modules` Verzeichnis). Die Source-Code Files, sprich die Implementierung soll im Verzeichnis `frontend/` abgelegt werden.

Bei der Verwendung von KI-Tools müssen die Prompts im Verzeichnis `prompts/` als Markdown-Files exportiert werden. Hier soll darauf geachtet werden, dass die Anfrage als auch die Quellen der Antworten ersichtlich sind.

## Help, oh I need somebody

### Classroom Repository
[Hier](https://classroom.github.com/a/0TjwqmNQ) finden Sie das Abgabe-Repository zum Entwickeln und Commiten Ihrer Lösung.

## Bewertung
Gruppengrösse: 2 Personen
### Grundanforderungen überwiegend erfüllt
- [ ] Tabellen Analysis, Sample, Box, BoxPos sind editierbar
- [ ] Neue Datensätze können in allen editierbaren Tabellen angelegt werden
- [ ] Konsistenzüberprüfung bei Edit und Erstellung mit sprechender Fehlermeldung

### Grundanforderungen zur Gänze erfüllt
- [ ] Einbettung der View *sample_boxpos* und Anzeige bei Sample und Analysis
- [ ] Sortieren von indizierten Datensätzen
- [ ] Überlegungen zur Anpassung der Oberfläche für eine Filterung im Backend

## Quellen
* [Vuetify Documentation](https://vuetifyjs.com/en/)
* [Vuetify Basic Data Tables](https://vuetifyjs.com/en/components/data-tables/basics/#usage)
* [Vue.js Documentation](https://vuejs.org/)
* [Axios Documentation](https://axios-http.com/docs)
* [Vue CLI Documentation](https://cli.vuejs.org/)
* ["Vue 3 + Vuetify + Axios" Example](https://github.com/mborko/code-examples/tree/master/js/v-data-table)

---
**Version** *20251118v3*
