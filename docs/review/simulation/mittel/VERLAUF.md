# Didaktisches Modell: mittleres Profil

## Geltungsbereich und Transparenz

Dies ist eine konstruierte Bearbeitung der aktuellen Aufgabe mit sieben Fragen, keine Messung realer Lernender. Das Profil kennt XML-Grundbegriffe, arbeitet die Anleitung geordnet durch und braucht bei DTD teilweise die Syntaxhilfe. Ein kleiner DTD-Fehler und eine anfängliche fachliche Unsicherheit wurden als plausible Bearbeitungsschritte modelliert; das Profil wurde nicht auf ein bestimmtes Bestehen oder Scheitern festgelegt.

**Echt ausgeführt** wurden die unten benannten Prüfungen mit dem vorgegebenen Interpreter und `material/pruefen.py`; die Rohdaten enthalten Zeitpunkt, vollständigen absoluten Befehl, stdout, stderr und Exitcode. **Modelliert** sind Verhalten, Unterrichtsphasen, Hilfen und sämtliche Minutenangaben. Es wurden nicht 200 Echtminuten lang Unterricht simuliert. Die vorhandene QA-Umgebung ersetzt hier die echte Installation; eine erfolgreiche Installation durch einen Lernenden ist damit nicht nachgewiesen.

Gelesen wurden ausschließlich TASK.md, material/README.md, DATENVERTRAG.md, DTD-HILFE.md, DOKUMENTATION.md und die bereitgestellte Originalantwort; ausgeführt wurde die fertige Oberfläche von pruefen.py. Referenzlösungen, andere Profile und lösungshaltige Reports wurden nicht herangezogen.

## Zeitmodell: 200 Unterrichtsminuten als Annahme

| Phase | Modellierte Minuten | Verhalten, Hilfe und Ergebnis |
| --- | ---: | --- |
| UE 1: Einrichtung | 10 | Vorinstalliertes Python vorausgesetzt; modellierte Einrichtung anhand README. Echt ist nur der Versionstest: Python 3.14.7, lxml 6.1.3. |
| UE 1: Auftrag und Datenweg lesen | 18 | Aufgabenfolge und Dateirollen unterscheiden; keine eigene Anwendung programmieren. |
| UE 1: Originaldaten finden | 14 | EUR, CZK und EffectiveDate in derselben Antwort bestimmen; Kursrichtung in der Angabe nochmals lesen. |
| UE 1: Quellen- und Einführungsnotizen | 8 | Offline-Basis ausdrücklich kennzeichnen, keine Behauptung eines Liveausfalls. |
| UE 2: Erstes XML schreiben | 23 | XML-Grundsyntax gelingt; Namen und Attribute anhand des Datenvertrags übernehmen. |
| UE 2: Abgleich und XML-Prüfung | 12 | Originalwerte abgleichen, echten erfolgreichen XML-Test lesen, Offline-Hinweis ergänzen. |
| UE 2: Fragen 1–3 | 5 | Kurze sichere Antworten; DTD-Zweck mit der Quellenregel verbinden. |
| UE 2: DTD-Hilfe lesen | 10 | ELEMENT, ATTLIST, Enumeration und Wiederholungszeichen ansehen. |
| UE 3: Erste DTD formulieren | 24 | Alle Elementtypen, Pflichtattribute und Enumerationen angelegt; Wiederholungszeichen bei kurs übersehen. |
| UE 3: Fehler verstehen und korrigieren | 12 | Echte Meldung „expecting … kurs … got … kurs kurs kurs“ mit Syntaxhilfe verbinden; `+` ergänzen; Revision besteht. |
| UE 3: Fragen 4–5 | 4 | Häufigkeiten, Reihenfolge und Attribute jetzt richtig begründen. |
| UE 3: Fehlerkopien erstellen | 10 | Tagfehler und entfernte vollständige Quelle getrennt anlegen; korrektes Original bewahren. |
| UE 4: Fehlerprüfungen und Testzeilen | 9 | Echte differenzierte Ergebnisse dokumentieren. |
| UE 4: Fragen 6–7 | 9 | Frage 6 mit den Tests beantworten. Frage 7 zunächst unsicher; ein kurzer Lehrkraftimpuls und Nachlesen führen zur richtigen Abgrenzung. |
| UE 4: Handrechnung und Empfehlung | 9 | CZ einschließlich Versand umrechnen, erst Endbetrag runden; mit AT und PL vergleichen. |
| UE 4: Dokumentation fertigstellen | 7 | Kurze Antworten, Datenquelle, Rechenweg und Belege zusammenführen. |
| UE 4: Browserimport und Screenshot | 10 | Echte übergeordnete Browserprüfung bestanden: Nach einem Dateidialog-Timeout den tatsächlichen XML-Inhalt über das vorhandene Textfeld importiert; Screenshot gesichert. Die zehn Minuten bleiben eine Unterrichtszeitschätzung. |
| UE 4: Reserve | 6 | Nicht als geleistete Arbeit gezählt. |

Summe: 194 Minuten modellierte Bearbeitung einschließlich Browserabschluss + 6 Minuten Reserve = 200 Minuten Budget. Theoriefragen insgesamt 18 Minuten, darin der unten stehende kurze Impuls. Das Zeitmodell ist plausibilitätsbasiert und sagt nicht voraus, dass reale mittelgute Lernende dieselbe Zeit benötigen.

## Versionen und Fehlerursachen

1. `erste-versuche/wechselkurse-v1.xml`: fachlich und syntaktisch korrekt, noch ohne optionalen Offline-Hinweis. Der echte XML-Test besteht. XML-Grundkenntnisse werden nicht künstlich mit einem Grundsyntaxfehler belastet.
2. `erste-versuche/wechselkurse-v1.dtd`: `(quelle, kurs, hinweis?)` erlaubt nur einen Kurs. Ursache im Modell: Ein Elementtyp wurde mit allen vorkommenden Instanzen dieses Typs verwechselt; das Wiederholungszeichen wurde beim Übertragen aus der Hilfe ausgelassen. Die echte DTD-Prüfung scheitert mit genau diesem Inhaltsmodell-Konflikt.
3. `arbeit/wechselkurse.xml` und `.dtd`: XML um den optionalen Hinweis ergänzt, DTD zu `kurs+` revidiert. Keine fremde Musterlösung; die Änderung folgt der Fehlermeldung und der bereitgestellten Häufigkeitsreferenz.
4. `arbeit/syntaxfehler.xml`: gezielt ein Endtag verändert. Dieser verlangte Testfall ist kein unbeabsichtigter Lernfehler.
5. `arbeit/strukturfehler.xml`: gezielt vollständige Quelle entfernt. Auch dies ist ein verlangter Testfall.
6. Frage 7: Die erste Antwortidee in `erste-versuche/UEBERLEGUNGEN.md` verwechselt einen fachlich falschen Wert mit DTD-Ungültigkeit. Die Revision nennt korrekt die fehlende Positivitätsprüfung bei #PCDATA.

## Hilfen und genau ein modellierter Lehrkraftimpuls

Erlaubte schriftliche Hilfen: Auftrag, Datenvertrag, README, DTD-HILFE und Dokumentationsvorlage. Englische Fehlermeldung wurde mithilfe der sichtbaren Elementfolgen und der Syntaxhilfe verstanden; keine zusätzliche Lehrerhilfe für die DTD-Korrektur angenommen.

Ein kurzer modellierter Impuls bei Frage 7, etwa 1 Minute innerhalb der 9-Minuten-Phase: **„Schau in der DTD-Hilfe nach, was `#PCDATA` zusichert, und vergleiche es mit den Wertregeln im Datenvertrag.“** Anschließend etwa 2 Minuten selbstständiges Nachlesen und Umformulieren. Der Impuls gibt keine fertige Antwort und ist keine tatsächlich stattgefundene Lehrerinteraktion.

## Tatsächliche Werkzeugergebnisse

| Logpräfix | Prüfung | Exitcode | Beobachtung |
| --- | --- | ---: | --- |
| 00-versionen | fertige Versionenoberfläche | 0 | Python 3.14.7, lxml 6.1.3, libxml2 2.11.9 |
| 01-erster-xml-test | XML v1 | 0 | WOHLGEFORMT |
| 02-erster-dtd-test | XML v1 gegen DTD v1 | 1 | Genau ein kurs erwartet, drei gefunden |
| 03-final-xml | XML Revision | 0 | WOHLGEFORMT |
| 04-final-dtd | XML Revision gegen DTD Revision | 0 | DTD-GÜLTIG |
| 05-syntax-xml | Syntaxkopie | 1 | Endtag stimmt in Zeile 4 nicht überein |
| 06-struktur-xml | Strukturkopie, nur XML | 0 | WOHLGEFORMT |
| 07-struktur-dtd | Strukturkopie gegen finale DTD | 1 | Pflichtquelle fehlt |

Je Präfix unter `pruefungen/`: JSON mit Befehl und Zeit sowie getrennte stdout-, stderr- und Exitcode-Dateien. Der dortige `werkzeuglauf.py` dient nur dem Sichern der echten Ergebnisse und gehört nicht zur Schülerabgabe. Die Fehlerprüfungen liefern absichtlich Exitcode 1; der umgebende Protokollschreiber liefert nach erfolgreicher Sicherung Exitcode 0. Maßgeblich ist der in den Logdateien gesicherte Exitcode des Prüfwerkzeugs.

Die selbst gelöste Rechnung ergibt CZ 170,07 EUR, AT 192,00 EUR und PL 192,87 EUR. Die ungerundeten Werte wurden zusätzlich arithmetisch ausgewertet und in `pruefungen/rechenkontrolle.txt` gesichert.

Nachtrag zum echten Browsernachweis: Die übergeordnete Prüfung meldete einen Timeout des Dateidialogs und importierte anschließend den tatsächlichen Inhalt der eigenen Datei über das vorhandene XML-Textfeld. Die Anwendung bestätigte „Format und Werte geprüft. Drei Wechselkurse übernommen.“ Die beobachteten Beträge AT 192,00 EUR, PL 192,87 EUR, CZ 170,07 EUR und Ersparnis 21,93 EUR stimmen mit der eigenen Rechnung überein. Der echte Screenshot liegt als `vergleich.png` vor; das übergeordnete Protokoll liegt unter `simulation/browser-results.json`. Der ebenfalls erzeugte Screenshot `vergleich-browser.jpg` wurde hier visuell geprüft und zeigt diese Werte sowie den eigenen Offline-Hinweis. Eine erfolgreiche Dateiauswahl wird nicht behauptet. Unterrichtszeit und Lernverhalten bleiben auch nach diesem echten Funktionsnachweis modelliert.

## GK-Einschätzung anhand der aktuellen Abgabe

Die Fragen 1–3 benennen XML-Bausteine und eine eigene DTD-Regel zutreffend. Frage 4 erklärt beide Häufigkeiten sowie die Reihenfolge vollständig; Frage 5 beurteilt fehlendes Attribut und USD korrekt. Frage 6 unterscheidet beide real geprüften Fehlerfälle. Frage 7 ist nach dem ausdrücklich dokumentierten Impuls fachlich richtig und benennt die nötige zusätzliche positive Zahlenprüfung.

XML, DTD mit Enumerationen und optionalem Hinweis, beide Fehlerkopien, drei Testzeilen, richtige Handrechnung und Empfehlung sind nach den aktuellen GK-Kriterien vollständig vorhanden. Diese Qualität ist mit erlaubter Syntaxhilfe und einem kurzen Hinweis mit dem mittleren Profil vereinbar; sie beweist keine selbstständige Erstlösung ohne Hilfe. Der Datenbezug ist für dieses Vergleichsmodell ausdrücklich offline; ein echter Liveabruf und die Einrichtung wurden nicht geprüft.

**Abschließende Einordnung:** Die dokumentierte fachliche Bearbeitung einschließlich echtem Rechnerimport und Screenshot stützt „Grundanforderungen zur Gänze erfüllt“ innerhalb der ausdrücklich vorgegebenen Offline-Simulation. Alle sieben Antworten sind in der Revision fachlich richtig; bei Frage 7 ist der kurze erlaubte Lehrkraftimpuls transparent dokumentiert. Der Nachweis umfasst die Nutzung der eigenen XML-Daten über den Textimport, nicht einen erfolgreichen Dateidialog oder Liveabruf. Eine automatische Schulnote oder eine Aussage über reale Lernende wird daraus nicht abgeleitet.