# DIDAKTISCHES MODELL: Profil „leistungsschwach“

**Keine Beobachtung eines realen Lernenden.** Dies ist eine mögliche Bearbeitung unter den vorgegebenen Profilannahmen. Fehler, Entscheidungen, Lernzuwachs und Unterrichtsminuten wurden modelliert. Ausschließlich die im TOOLPROTOKOLL wiedergegebenen Toolausgaben sind tatsächlich gemessen; deren Laufzeit ist kein Maß für Schülerarbeitszeit. Es wird keine Erfolgswahrscheinlichkeit für eine Klasse abgeleitet.

## Annahmen und Materialgrenze

Die modellierte Person kann Dateien bearbeiten und Befehle ausführen, verwechselt zunächst Element und Attribut, kennt die Einführung, benötigt für DTD-Symbole die Hilfe und liest Fehlermeldungen unsystematisch. Verwendet wurden ausschließlich die zugelassenen Aufgaben-/Hilfedateien, die gesicherte NBP-Antwort und die fertige Prüfschnittstelle. Es wurden keine Musterlösungen, Referenzdateien oder fremden Simulationen eingesehen. Die eigene Quelle ist bytegleich kopiert. Kein Liveabruf, kein behaupteter Liveausfall.

Die folgende Zeiteinteilung ist eine **Annahme von 200 Minuten modellierter Bearbeitung**, keine gemessene Lernzeit. Für den abschließenden Rechnerimport samt Screenshot werden 10 Minuten angenommen. Der Browsernachweis wurde durch den koordinierenden Prüflauf tatsächlich erbracht; seine technische Ausführungszeit ist keine Schülerarbeitszeit. Ob eine reale Person diese Zeit benötigt oder damit auskommt, bleibt offen.

| Phase | Modellierte Minuten | Tätigkeit, Werkzeugbefund und Reaktion |
| --- | ---: | --- |
| Orientierung und Umgebung | 10 | README und Auftrag lesen, Pfade verstehen; vorhandenen Interpreter benutzen. Echter Versionsaufruf erfolgreich. Die Simulation installiert nichts neu. |
| Daten finden | 22 | In der Originalantwort nach EUR, CZK und EffectiveDate suchen; `Mid` als zugehörigen Wert erkennen. Die Kursrichtung wird im Auftrag nachgelesen. Quelle unverändert kopieren. |
| Erster XML-Versuch | 26 | `basis`, `datum` und `waehrung` zunächst als Kindelemente; EUR außerdem mit Dezimalkomma. Ein Endtag heißt versehentlich `kurse`. Prüflauf 01 findet den Tagfehler. Korrektur nur des Endtags in Versuch 02 führt zu `WOHLGEFORMT`; der zusätzliche Hinweis zu fehlender DTD-/Werteprüfung wird zunächst nicht verarbeitet. |
| Erste DTD | 24 | DTD-HILFE neben die Datei legen, Elementtypen/ATTLIST übertragen. Wiederholung bei `kurs` vergessen, `waehrung` zunächst nur CDATA. Lauf 03 liefert viele Fehlermeldungen; vor allem `No declaration` wird wahrgenommen. Kein sicherer eigener Reparaturplan. |
| Attribute und Werte berichtigen | 25 | Lehrkraftimpuls 1, danach Datenvertrag Zeile für Zeile mit eigenem XML vergleichen. Attribute werden in die Starttags versetzt; Dezimalpunkt wird beim Nachlesen erkannt. Lauf 04 zeigt nur noch den Inhaltsmodellfehler. Fragen 1/2 werden dabei vorbereitet. |
| DTD-Reihenfolge/Wiederholung | 25 | Das Wort `hinweis?` in der Fehlermeldung wird zunächst als fehlender Hinweis gedeutet. Versuch 04 ergänzt einen sachlich passenden Offline-Hinweis; Lauf 05 scheitert weiterhin. Nach Impuls 2 wird `kurs+` aus der Hilfe hergeleitet. Beim erneuten Abgleich mit dem Auftrag wird auch CDATA durch die Währungsaufzählung ersetzt. Endfassung besteht XML- und DTD-Prüfung. |
| Fragen 1–5 | 18 | Kurze Antworten mit Hilfe der eigenen Dateien und DTD-HILFE formulieren. Die ursprüngliche Verwechslung bei Frage 2 ist korrigiert. Die Bedeutung der Zeichen wird anhand der aktuellen Deklaration erklärt. |
| Fehlerkopien und Frage 6 | 17 | Zwei Kopien gemäß Auftrag herstellen. Syntaxkopie: XML-Fehler. Strukturkopie: XML erfolgreich, DTD-Fehler. Tatsächliche Ausgaben für Frage 6 und die drei Testzeilen verwenden. |
| Rechencheck und Empfehlung | 12 | Vorgegebene Formel einsetzen; CZ zunächst in PLN, dann in EUR berechnen. Centbeträge und Ersparnis bilden. Keine eigene Anwendung programmieren. Die festgehaltenen Werte sind rechnerische Erwartungen. |
| Frage 7 und Dokumentation | 11 | Im Datenvertrag „Was wird geprüft?“ nachlesen. Antwort zu negativem Textwert fachlich richtig formulieren und Quellen/Unterstützung eintragen. |
| Rechnerimport und Bild | 10 | Echter Browsernachweis durch den koordinierenden Prüflauf, Screenshot hier zusätzlich angesehen. Nach Dateidialog-Timeout wurde der unveränderte XML-Inhalt im vorgesehenen Textfeld importiert. Status „Format und Werte geprüft“, AT 192,00 EUR, PL 192,87 EUR, CZ 170,07 EUR, Ersparnis 21,93 EUR. Die Zuordnung von 10 Unterrichtsminuten zu diesem Schritt bleibt modelliert. |
| **Gesamtbudget** | **200** | **Sämtliche Unterrichtsminuten sind geschätzt; keine Zeitreserve im Modell.** |

## Genau zwei modellierte Lehrkraftimpulse

1. Nach der ersten DTD-Fehlerliste: **„Vergleiche eine Zeile aus dem Datenvertrag mit deiner Datei: Was steht innerhalb des Starttags, was zwischen Start- und Endtag?“** Dieser Hinweis lenkt auf die bereits vorhandene Hilfe; er liefert weder eine fertige XML-Zeile noch die DTD.
2. Nach dem erfolglosen Ergänzen von `hinweis`: **„Vergleiche in der Fehlermeldung ‚expecting‘ mit ‚got‘. Welches Zeichen in der DTD-Hilfe erlaubt mehrere Wiederholungen?“** Die Person muss das Zeichen und die betroffene Deklaration selbst zuordnen.

Weitere modellierte Lehrkraftimpulse wurden nicht benutzt. Die ausdrücklich erlaubten schriftlichen Hilfen wurden wiederholt verwendet.

## Konkrete Fehlerursachen und erhaltene Zwischenstände

- `versuche/01-wechselkurse.xml`: Attribute werden als zusätzliche Elemente aufgefasst; außerdem deutscher Dezimaltrenner und abweichendes Endtag. Die XML-Prüfung entdeckt nur den Syntaxfehler und bestätigt keine fachlichen Werte.
- `versuche/02-wechselkurse.xml`: nur das Endtag ist repariert. Die erfolgreiche Wohlgeformtheitsprüfung wird anfangs zu weit ausgelegt; die DTD meldet fehlende Attribute und unzulässige Kindelemente.
- `versuche/01-wechselkurse.dtd`: Das Wiederholungszeichen fehlt; CDATA begrenzt die Währung noch nicht. Die DTD-Datei selbst ist syntaktisch lesbar, beschreibt aber eine zu enge Kursanzahl und zu weite Attributwerte.
- `versuche/03-wechselkurse.xml`: Attribute und Dezimalpunkt korrigiert. Der verbleibende Fehler ist `kurs` statt `kurs+` in der DTD, nicht die XML-Datei.
- `versuche/04-wechselkurse.xml`: Hinweis ergänzt, weil die Fehlermeldung nur teilweise gelesen wird. Das hilft gegen den Kursanzahlfehler nicht. Diese XML wird unverändert zur Endfassung, da ihr Hinweis zulässig und sachlich richtig ist.
- `arbeit/wechselkurse.dtd`: `kurs+` und Enumeration nach Abgleich mit DTD-Hilfe und Auftrag korrigiert. Es wird keine fertige DTD übernommen.

Die eigenen Fehler werden mit dem Material und tatsächlichen Rückmeldungen behoben. Ein Scheitern wird nicht als festes Ergebnis des Profils vorgegeben. Umgekehrt beweisen die guten Endantworten nach Unterstützung keinen selbstständigen Transfer auf ein neues Format.

## Grenzen des Ergebnisses

Der sichere Nachweis umfasst Dateiartefakte, Versionsausgabe, echte XML-/DTD-Prüfungen und den erfolgreichen Browserimport mit Screenshot. Die Antworten, das Verständnis und der Zeitplan sind eine plausible Konstruktion, keine Messung. Der Browserimport bestätigt die Dateikompatibilität und Anzeige, aber nicht die Arbeitszeit oder Selbstständigkeit eines realen Schülers. Das Gesamtprotokoll des koordinierenden Prüflaufs liegt projektbezogen in `simulation/browser-results.json`; der eigene Screenshot liegt hier als `vergleich.png`.
