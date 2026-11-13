# Simulation und frühere Aufgabenstände

Diese Hinweise richten sich an die Lehrkraft. Die aktuelle [Aufgabe](TASK.md)
bleibt eine gemeinsame GK-Aufgabe für **4 UE à 50 Minuten** mit sieben
XML-/DTD-Fragen: **3 × 1/5, 2 × 2/5 und 2 × 3/5**.

## Drei modellierte Bearbeitungen

Die Simulation wurde am 13.11.2026 mit Aufgabenfassung `20261113v2` durchgeführt.
Version `20261113v3` vereinheitlicht die Dateiablage und Materialbereitstellung;
sie ergänzt keine neuen Lernanforderungen. Die folgenden Ergebnisse sind keine
neu gemessenen Schülerleistungen der Version 3.

**Verhalten, Hilfen und Unterrichtszeiten sind KI-gestützte Modellannahmen.**
Dateien, XML-/DTD-Prüfungen, Rechenkontrollen und Browserimporte wurden tatsächlich
ausgeführt. Alle Profile verwendeten dieselbe gesicherte NBP-Antwort. Liveabruf
und Neuinstallation wurden nicht für jedes Profil wiederholt.

| Profil | Modellierter Verlauf und Ursache | Hilfen | Geschätzte Zeit und Ergebnis |
| --- | --- | --- | --- |
| Schwach | Verwechselt zuerst Elemente und Attribute, verwendet Dezimalkomma und falsches Endtag. Liest DTD-Fehlermeldungen nur teilweise und korrigiert zunächst die falsche Stelle. | Schriftliche Hilfen mehrfach; zwei kurze Lehrkraftimpulse zu Starttag/Inhalt und Wiederholung. | 200 Minuten ohne Reserve. Richtige Enddateien und sieben richtige Antworten nach Überarbeitung; Fehlerdiagnose noch unsicher. |
| Mittel | XML gelingt. Ein fehlendes Wiederholungszeichen in der DTD wird selbst korrigiert. Ein negativer Wert wird zunächst mit DTD-Ungültigkeit gleichgesetzt. | Schriftliche Hilfen; ein kurzer Impuls zu `#PCDATA` und fachlichen Regeln. | 194 Minuten, sechs Minuten Reserve. Richtige Enddateien und sieben richtige Antworten nach Korrektur. |
| Gut | Überträgt die vereinbarten Regeln systematisch. Die erste geprüfte Fassung stimmt; Syntax, Struktur und fachliche Werte werden klar unterschieden. | Schriftliche Hilfen, keine Lehrkraftimpulse. | 175 Minuten, 25 Minuten Reserve. Richtige Enddateien und sieben richtige Antworten selbstständig erarbeitet. |

Alle drei Endfassungen bestehen die XML- und DTD-Prüfung. Die gezielten Fehlerkopien
liefern jeweils den erwarteten Syntaxfehler beziehungsweise eine wohlgeformte,
aber DTD-ungültige Struktur. Im Browser wurden die tatsächlichen XML-Inhalte über
das vorhandene Textfeld importiert, nachdem der Dateidialog einen Timeout erreicht
hatte. Alle drei Importe ergeben AT **192,00 EUR**, PL **192,87 EUR**, CZ **170,07 EUR**
und eine Ersparnis von **21,93 EUR** gegenüber AT.

Die fachlichen Endabgaben erfüllen im kontrollierten Offline-Modell die
GK-Anforderungen. Erlaubte Hilfen führen nicht automatisch zu einer schlechteren
Bewertung. Richtige Endantworten belegen aber noch keinen selbstständigen Transfer
auf neue Formate. Besonders die Frage zur Grenze von `#PCDATA` macht diesen
Unterschied sichtbar.

Vier UE erscheinen unter den angenommenen Voraussetzungen plausibel; das schwache
Profil benötigt Unterstützung und hat keine Zeitreserve. Einrichtungsschwierigkeiten
oder Wartezeiten können den Rahmen überschreiten. Tatsächliche Bearbeitungszeiten
und Lernerfolge lassen sich erst in einem Unterrichtsdurchlauf prüfen.

## Einheitliche Ablage

Wie bei den Vergleichsaufgaben 71 und 72 liegen Angabe und Checkliste direkt im
Aufgabenordner. Das Arbeitsmaterial wird als Ordner `project/` bereitgestellt.
Der aktuelle Stand enthält **12 Dateien**:

```text
review/
├── TASK.md
├── CHECK.md
├── SIMULATION.md
└── project/
    ├── abrufen.py
    ├── pruefen.py
    ├── index.html
    ├── requirements.txt
    ├── HILFE.md
    ├── DOKUMENTATION.md
    ├── arbeit/
    │   ├── wechselkurse.xml
    │   └── wechselkurse.dtd
    └── ersatzdaten/
        └── nbp-2026-11-13.xml
```

Einrichtung, Austauschformat, DTD-Hilfe und Ersatzdatenherkunft sind in der
[Projektbeschreibung](project/HILFE.md) zusammengeführt. Die XML-/DTD-Startdateien
enthalten lediglich Kommentare. Die vollständigen Modellabgaben und technischen
Rohprotokolle gehören nicht zu den Arbeitsdateien der Schüler.

## Prüfung der vereinheitlichten Struktur

Die Neuordnung wurde am 13.11.2026 geprüft: Der vollständige MkDocs-Build mit
`--strict` ist erfolgreich. MkDocs und CommonMark mit Tabellen/Tasklisten zeigen
je fünf Dropdowns, drei Tabellen, vier Befehlsblöcke und elf Checkboxen.
Der ausgelieferte Rechner ist bytegleich zum bisher getesteten Rechner; die
Hilfeseite überschreibt ihn nicht. Der Liveabruf lieferte HTTP 200 und legte
`quellen/` samt Originalantwort und Abrufnachweis an. Die 15 XML-/DTD-Prüfungen
der drei vorhandenen Modellabgaben lieferten auch mit den Werkzeugen aus dem
neuen Projektordner die erwarteten Ergebnisse. Die sieben Fragen und die
Bewertungskriterien sind gegenüber Version 2 unverändert.

## Erhaltene Nachweise und Archive

Die ausführlichen Ergebnisse und früheren Aufgabenstände bleiben im festen
Git-Commit `27704ddaa452e5c4dbe284fbcca831c747924591` erhalten. Die folgenden Links
zeigen ausdrücklich auf diesen historischen Stand und verändern sich nicht mit
späteren Änderungen auf `main`:

- [Vollständige Simulation mit allen drei Profilen, Antworten, Zwischenständen und Screenshots](https://github.com/TGM-HIT/insy-exercises/tree/27704ddaa452e5c4dbe284fbcca831c747924591/docs/review/simulation).
- [Prüfbericht](https://github.com/TGM-HIT/insy-exercises/blob/27704ddaa452e5c4dbe284fbcca831c747924591/docs/review/pruefung/PRUEFBERICHT.md) und [technische Prüfnachweise](https://github.com/TGM-HIT/insy-exercises/tree/27704ddaa452e5c4dbe284fbcca831c747924591/docs/review/pruefung).
- [Archivbeschreibung der beiden früheren Aufgabenstrukturen](https://github.com/TGM-HIT/insy-exercises/blob/27704ddaa452e5c4dbe284fbcca831c747924591/docs/review/archiv/2026-11-13/index.md).
- [Historisches Archiv: veröffentlichte Aufgabenstruktur](https://github.com/TGM-HIT/insy-exercises/blob/27704ddaa452e5c4dbe284fbcca831c747924591/docs/review/archiv/2026-11-13/veroeffentlichte-aufgabenstruktur.zip).
- [Historisches Archiv: lokaler XML-GK-Entwurf für vier UE](https://github.com/TGM-HIT/insy-exercises/blob/27704ddaa452e5c4dbe284fbcca831c747924591/docs/review/archiv/2026-11-13/lokaler-xml-gk-4ue-stand.zip).

Die Archiv-ZIPs sind historische Sicherungen. Im aktuellen Aufgabenordner liegen
keine ZIP-Dateien und keine doppelten Materialkopien; das benötigte Projekt wird
über den Ordnerdownload in der Angabe bezogen.
