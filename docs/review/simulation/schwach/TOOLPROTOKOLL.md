# Tatsächliche Werkzeugausgaben – didaktisches Modell „schwach“

Die folgenden Prüfungen wurden tatsächlich mit dem bereitgestellten Werkzeug ausgeführt. Fehler, Lernhandlungen und Unterrichtsminuten im VERLAUF sind dagegen modelliert. Es fand kein Liveabruf statt. Der einheitliche Testdatensatz ist die gesicherte NBP-Antwort vom 13.11.2026.

Interpreter: `SOURCE_WORKSPACE\xml-webservice-20261113\qa\tools-venv\Scripts\python.exe`

Prüfskript: `SOURCE_WORKSPACE\xml-webservice-20261113\material\pruefen.py`

## 00 – Umgebung

Aufruf: Interpreter `-X utf8` Prüfskript `versionen`

```text
Python 3.14.7
lxml 6.1.3
libxml2 2.11.9
```

Exitcode: `0`

## 01 – Erster XML-Versuch

Aufruf: Interpreter -X utf8 Prüfskript xml SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\versuche\01-wechselkurse.xml

~~~text
XML-FEHLER in Zeile 8, Spalte 42: Die Datei ist nicht wohlgeformt.
  Parsermeldung: Opening and ending tag mismatch: kurs line 8 and kurse, line 8, column 42
~~~

Exitcode: 1

## 02 – Nur Endtag berichtigt

Aufruf: Interpreter -X utf8 Prüfskript xml SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\versuche\02-wechselkurse.xml

~~~text
WOHLGEFORMT: SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\versuche\02-wechselkurse.xml (Wurzelelement: wechselkurse)
Damit sind weder die DTD-Gültigkeit noch die Richtigkeit der Werte nachgewiesen.
~~~

Exitcode: 0

## 03 – DTD gegen wohlgeformten Zwischenstand

Aufruf: Interpreter -X utf8 Prüfskript dtd SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\versuche\02-wechselkurse.xml SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\versuche\01-wechselkurse.dtd

~~~text
DTD-UNGÜLTIG: Die XML-Struktur entspricht nicht der angegebenen DTD.
  Zeile 2: Element wechselkurse content does not follow the DTD, expecting (quelle , kurs , hinweis?), got (basis datum quelle kurs kurs kurs )
  Zeile 2: Element wechselkurse does not carry attribute basis
  Zeile 2: Element wechselkurse does not carry attribute datum
  Zeile 3: No declaration for element basis
  Zeile 4: No declaration for element datum
  Zeile 6: Element kurs was declared #PCDATA but contains non text nodes
  Zeile 6: Element kurs does not carry attribute waehrung
  Zeile 6: No declaration for element waehrung
  Zeile 7: Element kurs was declared #PCDATA but contains non text nodes
  Zeile 7: Element kurs does not carry attribute waehrung
  Zeile 7: No declaration for element waehrung
  Zeile 8: Element kurs was declared #PCDATA but contains non text nodes
  Zeile 8: Element kurs does not carry attribute waehrung
  Zeile 8: No declaration for element waehrung
~~~

Exitcode: 1

## 04 – Attribute und Dezimalpunkt korrigiert

Aufruf: Interpreter -X utf8 Prüfskript dtd SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\versuche\03-wechselkurse.xml SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\versuche\01-wechselkurse.dtd

~~~text
DTD-UNGÜLTIG: Die XML-Struktur entspricht nicht der angegebenen DTD.
  Zeile 2: Element wechselkurse content does not follow the DTD, expecting (quelle , kurs , hinweis?), got (quelle kurs kurs kurs )
~~~

Exitcode: 1

## 05 – Hinweis ergänzt, Wiederholungsfehler bleibt

Aufruf: Interpreter -X utf8 Prüfskript dtd SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\versuche\04-wechselkurse.xml SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\versuche\01-wechselkurse.dtd

~~~text
DTD-UNGÜLTIG: Die XML-Struktur entspricht nicht der angegebenen DTD.
  Zeile 2: Element wechselkurse content does not follow the DTD, expecting (quelle , kurs , hinweis?), got (quelle kurs kurs kurs hinweis )
~~~

Exitcode: 1

## 06 – Endfassung XML

Aufruf: Interpreter -X utf8 Prüfskript xml SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\arbeit\wechselkurse.xml

~~~text
WOHLGEFORMT: SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\arbeit\wechselkurse.xml (Wurzelelement: wechselkurse)
Damit sind weder die DTD-Gültigkeit noch die Richtigkeit der Werte nachgewiesen.
~~~

Exitcode: 0

## 07 – Endfassung DTD

Aufruf: Interpreter -X utf8 Prüfskript dtd SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\arbeit\wechselkurse.xml SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\arbeit\wechselkurse.dtd

~~~text
DTD-GÜLTIG: SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\arbeit\wechselkurse.xml entspricht SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\arbeit\wechselkurse.dtd.
Zahlenwerte, Datumswerte und die Vollständigkeit der drei Währungen prüft anschließend die Anwendung.
~~~

Exitcode: 0

## 08 – Syntaxfehler XML

Aufruf: Interpreter -X utf8 Prüfskript xml SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\arbeit\syntaxfehler.xml

~~~text
XML-FEHLER in Zeile 4, Spalte 44: Die Datei ist nicht wohlgeformt.
  Parsermeldung: Opening and ending tag mismatch: kurs line 4 and kurs_falsch, line 4, column 44
~~~

Exitcode: 1

## 09 – Strukturfehler XML

Aufruf: Interpreter -X utf8 Prüfskript xml SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\arbeit\strukturfehler.xml

~~~text
WOHLGEFORMT: SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\arbeit\strukturfehler.xml (Wurzelelement: wechselkurse)
Damit sind weder die DTD-Gültigkeit noch die Richtigkeit der Werte nachgewiesen.
~~~

Exitcode: 0

## 10 – Strukturfehler DTD

Aufruf: Interpreter -X utf8 Prüfskript dtd SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\arbeit\strukturfehler.xml SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\arbeit\wechselkurse.dtd

~~~text
DTD-UNGÜLTIG: Die XML-Struktur entspricht nicht der angegebenen DTD.
  Zeile 2: Element wechselkurse content does not follow the DTD, expecting (quelle , kurs+ , hinweis?), got (kurs kurs kurs hinweis )
~~~

Exitcode: 1

## 11 – Endgültige Syntaxkopie: genau ein Endtag geändert

Technische Nachkontrolle der erzeugten Datei: Die Kopie enthält genau ein geändertes Endtag. Dies ist keine zusätzliche modellierte Lernphase. Aufruf: Interpreter -X utf8 Prüfskript xml SOURCE_WORKSPACE\xml-webservice-20261113\qa\simulation\schwach\arbeit\syntaxfehler.xml

~~~text
XML-FEHLER in Zeile 4, Spalte 44: Die Datei ist nicht wohlgeformt.
  Parsermeldung: Opening and ending tag mismatch: kurs line 4 and kurs_falsch, line 4, column 44
~~~

Exitcode: 1

## 12 – Rechen- und Kopierkontrolle (tatsächlich ausgeführt)

PowerShell-Dezimalrechnung, keine Browserbehauptung:

~~~text
PL = 192.87497163603358293623780349
CZ = 170.06807351940095302927161334
PL gerundet = 192.87
CZ gerundet = 170.07
CZ-Ersparnis gegenüber 192.00 = 21.93
Originalantwort bytegleich kopiert: True
SHA256: BC3B79F668DBC43E1F81287249BDD24A7630DACF3889D7031E2F72D3C280203E
~~~

Der ausführende PowerShell-Prozess endete mit Exitcode 0. Die hashgleiche Kopie bestätigt die unveränderte Übernahme der Offline-Antwort.

## 13 – Browsernachweis aus koordinierendem Prüflauf

Tatsächlich ausgeführt durch den koordinierenden Agenten, danach wurde die eigene `vergleich.png` hier mit dem Bildwerkzeug angesehen. Grundlage: finale `arbeit/wechselkurse.xml`. Der Dateidialog hatte in der Prüfumgebung einen Timeout; deshalb wurde derselbe XML-Inhalt über das bereits vorhandene Textimportfeld der fertigen Anwendung geladen.

Sichtbarer Status: „Format und Werte geprüft. Drei Wechselkurse übernommen.“ Kursdatum: 13.11.2026, Offline-Hinweis sichtbar. Beträge: AT 192,00 EUR, PL 192,87 EUR, CZ 170,07 EUR. Ergebnis: CZ am günstigsten, Ersparnis 21,93 EUR.

Screenshot: `vergleich.png`. Koordinierendes Protokoll: `simulation/browser-results.json` (projektbezogener Pfad). Für diese UI-Aktion existiert kein Python-Exitcode; die Bestätigung ist die beobachtete Anzeige und das gesicherte Bild. Die angenommene Schülerzeit von zehn Minuten ist davon getrennt.
