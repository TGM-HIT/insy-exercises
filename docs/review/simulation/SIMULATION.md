# Drei modellierte Bearbeitungen der XML-/DTD-Aufgabe

Stand: 13.11.2026, Aufgabenfassung `20261113v2`.

## Ergebnis und Aussagegrenze

Alle drei Modellprofile erzeugen am Ende funktionierende XML-/DTD-Dateien und
beantworten die sieben Grundfragen fachlich richtig. Die Unterschiede liegen im
Weg dorthin: Fehlerdiagnose, Unterstützungsbedarf und angenommene Zeitreserve.
Eine richtige Enddatei allein lässt deshalb noch keinen sicheren Schluss auf
selbstständiges Verständnis zu.

**Dies ist eine didaktische Simulation mit KI, keine Untersuchung realer Schüler.**
Fehler, Hilfen, Lernverhalten und Arbeitszeiten sind bewusst modelliert. Tatsächlich
ausgeführt wurden Dateiarbeiten, XML-/DTD-Prüfungen, Rechenkontrollen und die
Browserimporte. Die Modellzeiten sind keine gemessenen Bearbeitungszeiten und
ergeben keine Erfolgswahrscheinlichkeiten für eine Klasse.

## Was an den Grundfragen geändert wurde

| Schwierigkeit | Fragen | Grundkompetenz |
| --- | --- | --- |
| 3 × 1/5 | 1: Wurzelelement; 2: Element, Attribut und Text; 3: Zweck einer DTD | Begriffe an einem konkreten XML-Beispiel erkennen und eine eigene Strukturregel nennen. |
| 2 × 2/5 | 4: `+`, `?` und Reihenfolge; 5: `#REQUIRED` und Enumeration | Einfache DTD-Regeln lesen und auf zulässige bzw. unzulässige Dokumente anwenden. |
| 2 × 3/5 | 6: falsches Endtag gegenüber fehlendem Pflichtkindelement; 7: negativer Wert bei `#PCDATA` | Syntax, Struktur und fachliche Werteprüfung unterscheiden und kurz begründen. |

Auch 3/5 bleibt GK: Es werden bekannte Regeln auf kleine, vorgegebene Fälle
angewendet. Keine zusätzliche Programmiersprache oder weiterführende XML-Technik
ist erforderlich. Die Fragen sind auf 15–20 Minuten innerhalb der vier UE angelegt
und werden während der passenden Arbeitsschritte beantwortet. Sieben Kurzantworten
sind kein zusätzlicher Aufsatz. Checkliste, Dokumentationsvorlage und interne
Referenzantworten wurden entsprechend angepasst.

## Vergleich der drei Profile

| Profil | Modellierter Verlauf | Hilfen | Geschätzter Gesamtaufwand | Ergebnis im Modell |
| --- | --- | --- | --- | --- |
| Schwach | Verwechselt zuerst Attribute und Elemente, verwendet ein Dezimalkomma und ein falsches Endtag. Nach der Syntaxkorrektur deutet es die erfolgreiche XML-Prüfung zu weit. In der DTD fehlen zunächst Wiederholung und Wertebegrenzung; eine Fehlermeldung wird falsch auf den optionalen Hinweis bezogen. | Schriftliche Hilfen mehrfach; zwei kurze Lehrkraftimpulse zu Starttag/Inhalt und zum Wiederholungszeichen. | 200 Minuten, keine Reserve. | Richtige Enddateien und 7/7 richtige Antworten nach Überarbeitung. Fachliche GK-Anforderungen mit Unterstützung erfüllt; selbstständige Fehlerdiagnose bleibt unsicher. |
| Mittel | Erstes XML stimmt. In der DTD wird `kurs` statt `kurs+` verwendet; die Person korrigiert dies mit Fehlermeldung und Syntaxhilfe selbst. Bei Frage 7 wird zunächst ein negativer Wert mit DTD-Ungültigkeit gleichgesetzt. | Schriftliche Hilfen; ein kurzer Impuls zu `#PCDATA` und fachlichen Regeln. | 194 Minuten, sechs Minuten Reserve. | Richtige Enddateien und 7/7 richtige Antworten nach Korrektur. Fachliche GK-Anforderungen vollständig; Grenze der DTD anfangs noch unsicher. |
| Gut | Überträgt den Datenvertrag systematisch in XML und DTD. Die erste geprüfte Fassung stimmt. Unterscheidet bei den Fehlerkopien und Fragen direkt Syntax, Struktur und fachliche Regeln. | Erlaubte schriftliche Hilfen, keine Lehrkraftimpulse. | 175 Minuten, 25 Minuten Reserve. | Richtige Enddateien und 7/7 richtige Antworten ohne zusätzliche Hinweise. Fachliche GK-Anforderungen vollständig und selbstständig bearbeitet. |

Die Minutenwerte stammen aus den jeweiligen Planungsmodellen; ihre Genauigkeit ist
nicht empirisch belegt. Die fachliche Rubrik erlaubt Hilfen. Deshalb wird das
schwächere Profil nicht allein wegen seiner Profilbezeichnung schlechter bewertet,
wenn seine überarbeitete Abgabe die Kriterien erfüllt. Umgekehrt beweisen richtige
Antworten nach einem Hinweis noch keinen sicheren Transfer auf eine neue Struktur.

## Warum die Profile unterschiedlich arbeiten

**Schwach:** Es fehlt zunächst die sichere Zuordnung zwischen grafischer Schreibweise
und Struktur: Ein Attribut wird wie ein Kindelement behandelt. Fehlermeldungen werden
nur ausschnittsweise gelesen, wodurch die falsche Stelle repariert wird. Die konkrete
Syntaxhilfe und zwei gezielte Hinweise ermöglichen im Modell die Korrektur. Die
Endantworten sind richtig, aber stark an Material und eigene Überarbeitung gebunden.

**Mittel:** XML-Grundbegriffe sind verfügbar. Der zentrale DTD-Fehler ist lokal und
wird selbst behoben. Schwieriger ist der gedankliche Unterschied zwischen „fachlich
falscher Zahlenwert“ und „von der DTD nicht eingeschränkter Text“. Frage 7 macht
diese Verständnislücke sichtbar; ein kurzer Hinweis reicht im Modell zur Klärung.

**Gut:** Die Person arbeitet vom Datenvertrag zu den konkreten Deklarationen und
prüft Regeln systematisch. Sie erkennt, dass `#PCDATA` keine Positivität garantiert.
Die frei werdende Zeit ist Reserve und setzt keine zusätzlichen EK-Aufträge voraus.

## Tatsächlich geprüfte Ergebnisse

Für jedes Profil wurden dieselben fünf abschließenden Prüfungen ausgeführt:

| Prüfung | Beobachtetes Ergebnis bei allen drei Profilen |
| --- | --- |
| Korrektes XML, Wohlgeformtheit | Erfolgreich, Exitcode 0. |
| Korrektes XML gegen eigene DTD | Erfolgreich, Exitcode 0. |
| Kopie mit falschem Endtag, Wohlgeformtheit | Erwarteter Fehler, Exitcode 1. |
| Kopie ohne vollständiges `quelle`-Element, Wohlgeformtheit | Erfolgreich, Exitcode 0. |
| Kopie ohne `quelle` gegen eigene DTD | Erwarteter Strukturfehler, Exitcode 1. |

Die drei finalen XML-Inhalte wurden außerdem tatsächlich über das vorhandene
XML-Textfeld in den Rechner übernommen. Ein Dateidialog erreichte zuvor einen
Timeout; für diesen Durchlauf wird daher kein erfolgreicher Dateidialogimport
behauptet. Alle drei Importe bestätigen die Format-/Werteprüfung und zeigen:

| Lieferant | Gesamtkosten einschließlich Versand |
| --- | ---: |
| AT | 192,00 EUR |
| PL | 192,87 EUR |
| CZ | 170,07 EUR |

CZ spart gegenüber AT **21,93 EUR**. Diese Werte beziehen sich auf die gemeinsame
gesicherte NBP-Antwort vom 13.11.2026, nicht auf beliebige spätere Tageskurse.
Die Browserprüfung führt keine DTD-Validierung aus; diese ist separat protokolliert.

## Bedingungen und Grenzen der Simulation

- Die drei Profile wurden getrennt bearbeitet. Sie erhielten ausschließlich Aufgabe,
  Schülerhilfen und die vorgegebene Originalantwort, keine Musterlösung oder fremde
  Profilabgabe.
- Die Offline-Antwort wurde absichtlich für identische Vergleichsbedingungen benutzt.
  Ein Dienstausfall wurde nicht beobachtet oder behauptet. Die Quellenkopien wurden
  unverändert erhalten.
- Ein eigener Liveabruf und eine Neuinstallation wurden nicht für jedes Profil
  durchgeführt. Die bereits vorhandene Prüfumgebung wurde benutzt. Die vollständige
  reale Abruf- und Einrichtungskompetenz der Profile ist dadurch nicht geprüft.
- Die Einordnung „fachliche GK-Anforderungen erfüllt“ gilt für diesen kontrollierten
  Offline-Durchlauf und ist keine vollständige Prüfungsnote. Insbesondere das
  Verständnis und die Selbstständigkeit echter Lernender lassen sich nicht durch
  funktionierende Modellabgaben ersetzen.
- Der theoretische Lernzuwachs nach den Hinweisen ist eine Annahme des jeweiligen
  Profils. Dass ein realer Lernender nach demselben Hinweis ebenso reagiert, ist offen.

## Didaktische Einschätzung für vier UE

Der Umfang erscheint mit vorbereiteter Umgebung und kurzer XML-/DTD-Einführung
für mittlere und gute Lernende plausibel. Die mittlere Modellbearbeitung lässt aber
nur wenig Reserve; die schwache nutzt die gesamten 200 Minuten und benötigt
Unterstützung. Einrichtungsschwierigkeiten, längere Wartezeiten auf Hilfe oder
zusätzlicher Dokumentationsaufwand können den Zeitrahmen überschreiten.

Die neuen Fragen erfüllen ihren Zweck: 1–3 prüfen das Erkennen der XML-Bausteine,
4–5 das Anwenden grundlegender DTD-Regeln, 6–7 das Verständnis der unterschiedlichen
Prüfebenen. Gerade Frage 7 trennt nachvollziehbares Verständnis vom bloßen Erzeugen
einer akzeptierten Datei. Bei unterstützten Lösungen kann die Lehrkraft während
der Arbeitszeit eine kurze Begründung mündlich erklären lassen, wie bereits in der
Aufgabe vorgesehen. Ein zusätzlicher Pflichtauftrag wird daraus nicht abgeleitet.

Eine belastbare Aussage zur tatsächlichen Bearbeitungsdauer braucht einen ersten
Unterrichtsdurchlauf. Die Simulation liefert Ansatzpunkte für Beobachtung und Hilfe,
keinen Nachweis, dass alle Schüler in vier UE fertig werden.

## Nachweise

- [Schwach: Verlauf](schwach/VERLAUF.md), [Abgabe](schwach/DOKUMENTATION.md), [Prüfprotokoll](schwach/TOOLPROTOKOLL.md).
- [Mittel: Verlauf und Prüfübersicht](mittel/VERLAUF.md), [Abgabe](mittel/DOKUMENTATION.md).
- [Gut: Verlauf und Prüfübersicht](gut/VERLAUF.md), [Abgabe](gut/DOKUMENTATION.md).
- [Gemeinsames Browserprotokoll](browser-results.json).
- [Aufgabenansicht mit den sieben Grundfragen](grundfragen.jpg).
- Browserbilder: [schwach](schwach/vergleich.png), [mittel](mittel/vergleich.png), [gut](gut/vergleich.png).

Die Modellabgaben und Antworten liegen in `docs/review` des Repositorys
`TGM-HIT/insy-exercises`. Sie sind nicht im Schülerpaket enthalten. Diese zusätzliche
Review-Ablage ersetzt die bisherigen Semesteraufgaben nicht.
