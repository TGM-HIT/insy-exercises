# Prüfbericht zur Review-Fassung

Stand: **13.11.2026**, Aufgabe **20261113v2**.

Die folgenden Berichte stammen aus der Prüfung vor der Review-Ablage:

- [Werkzeuge](tools-test-results.json): 30 Tests, keine Fehler; Python 3.14.7 und lxml 6.1.3.
- [Rechenlogik](app-logic-results.json): 16 erfolgreiche Tests.
- [Browserprüfung der Anwendung](browser-results.json): erfolgreicher Dateiimport und positive/negative Eingabefälle.
- [Integration](integration-results.json): strikter MkDocs-Build erfolgreich, 81 lokale Links/Sprungziele, identische Downloads, korrekte Fragenverteilung und Checkliste; MkDocs und CommonMark mit Tabellen/Tasklisten geprüft.
- [Drei Modellbearbeitungen](../simulation/SIMULATION.md): jeweils fünf abschließende XML-/DTD-Prüfungen mit den erwarteten Exitcodes; richtige Endantworten nach unterschiedlich viel Hilfe.
- [Browserprüfung der drei Modellabgaben](../simulation/browser-results.json): drei erfolgreiche XML-Textimporte, jeweils AT 192,00 EUR, PL 192,87 EUR, CZ 170,07 EUR und Ersparnis 21,93 EUR. Der Dateidialog hatte in diesem zusätzlichen Durchlauf einen Timeout; kein erfolgreicher Dateidialogimport wird dafür behauptet.
- [Archivmanifest](archive-manifest.json): 29 Dateien im veröffentlichten Altstand und 34 im letzten lokalen Altstand, unverändert gesichert.
- [Materialmanifest](material-manifest.json): 14 Schülerdateien; Lösungen und Prüfumgebungen sind nicht im Paket.

Die bisherigen Link- und Buildprüfungen betreffen die lokale Kursintegration. Die
zusätzliche Prüfung am endgültigen Ziel **`insy-exercises/docs/review`** ist in
[review-copy-check.json](review-copy-check.json) festgehalten: vollständiger strikter
MkDocs-Build ohne neue Warnungen, beide Renderer mit fünf Dropdowns, drei Tabellen,
vier Befehlsblöcken und elf Checkboxen sowie 15 erneut ausgeführte XML-/DTD-Prüfungen
mit den erwarteten Ergebnissen. Historische Protokollpfade wurden wie in der [README](../README.md) beschrieben normalisiert.

Die Browserumgebung blockierte beim ursprünglichen Test `file://`-Navigation.
Der Rechner wurde über die lokale HTTP-Vorschau getestet; das direkte lokale Öffnen
war in dieser Browserumgebung nicht interaktiv prüfbar. Die Modellzeiten sind keine
gemessenen Schülerarbeitszeiten. Die Lehrkraft muss den Zeitrahmen in der Klasse prüfen.
