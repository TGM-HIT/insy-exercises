# Informationssysteme "E2E Testing"

## Einführung
Bei dieser Übung sollen für eine bestehende CRUD Webapplikation E2E-Tests implementiert werden.

## Ziele
Das Ziel dieser Übung ist das funktionale Überprüfen einer bereitgestellten JS-View zur Datenmanipulation.

## Voraussetzungen
+ Docker Compose
+ Kenntnisse über Javascript
+ Funktionstüchtige ReST Schnittstelle aus "ReST Backend"
+ Funktionstüchtige Weboberfläche aus "Vue CRUD"
+ Grundlagen über E2E Tests

## Detailierte Aufgabenstellung
Für die Übung [Vue CRUD](https://tgm-hit.github.io/insy-exercises/informationssysteme_/sem09_vue_crud/TASK) sollen nun E2E-Tests geschrieben werden. Die folgende Tabellen sollen dabei auf ihre CRUD-Funktionen getestet werden: **Analysis**, **Sample**, **Box**, **BoxPos**. Die Tabelle **Log** soll weiterhin nur lesend zur Verfügung gestellt werden.

Es sollen kontinuierliche Testprotokolle abgelegt werden, die den Testfortschritt dokumentieren. Dabei bieten sich `*.html` Generatoren an. Die Tests sollen mittels `npm` oder `yarn` aus der Konsole gestartet werden können.

Auch die Aufnahme der Tests als Video bzw. das Speichern von Screenshots soll ermöglicht werden. Diese dürfen aber auf keinen Fall ins Repository hinzugefügt werden.

## Abgabe
Im Repository soll das `README.md` die notwendigen Schritte beschreiben. Auch das verwendete `docker-compose.yml` soll enthalten sein. Bitte alle Binaries und Class-Files in das `.gitignore` eintragen, sodass keine irrtümliche Abgabe erfolgt (besonders das `node-modules` Verzeichnis). Die Source-Code Files, sprich die Implementierung soll im Verzeichnis `frontend/` und die dazugehörigen Tests in `tests/` abgelegt werden.

Bei der Verwendung von KI-Tools müssen die Prompts im Verzeichnis `prompts/` als Markdown-Files exportiert werden. Hier soll darauf geachtet werden, dass die Anfrage als auch die Quellen der Antworten ersichtlich sind.

## Help, oh I need somebody

### Classroom Repository
[Hier](https://classroom.github.com/a/rfRctHJJ) finden Sie das Abgabe-Repository zum Entwickeln und Commiten Ihrer Lösung.

## Bewertung
Gruppengrösse: 2-3 Personen
### Grundanforderungen überwiegend erfüllt
- [ ] Tabellen Analysis und Sample sind mit E2E-Tests auf grundlegende Editier-Befehle getestet
- [ ] Anzeige von Tabelle Log ist überprüft
- [ ] Fehlermeldungen sind überprüft

### Grundanforderungen zur Gänze erfüllt
- [ ] Tabellen Box und BoxPos sind grundlegend (CRUD) getestet
- [ ] HTML-Testreports werden erstellt und sind eingebunden
- [ ] Konfiguration für Aufzeichnungen der E2E-Tests ist bereitgestellt

## Quellen
* [Why Cypress?](https://docs.cypress.io/app/get-started/why-cypress)
* [Cypress App - Your First Test](https://docs.cypress.io/app/end-to-end-testing/writing-your-first-end-to-end-test)
* [Cypress Component Testing](https://docs.cypress.io/app/component-testing/get-started)
* [Reporters in Cypress](https://docs.cypress.io/app/tooling/reporters)
* [Integrating Mochawesome reporter with Cypress](https://antontelesh.github.io/testing/2019/02/04/mochawesome-merge.html)
* [Screenshots and Videos](https://docs.cypress.io/app/guides/screenshots-and-videos)

---
**Version** *20251202v1*
