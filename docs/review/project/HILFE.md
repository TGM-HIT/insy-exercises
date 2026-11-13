# Projekt: Lieferantenangebote mit XML vergleichen

Diese Dateien unterstützen die gemeinsame GK-Aufgabe aus [TASK.md](https://github.com/TGM-HIT/insy-exercises/blob/main/docs/review/TASK.md).
Die Werkzeuge sind fertig; du erstellst die XML-Datei und die DTD selbst. Arbeite
im heruntergeladenen Ordner `project`. Die kurze Vorlage
[DOKUMENTATION.md](DOKUMENTATION.md) begleitet deine Bearbeitung.

## Einrichtung

Python 3.14 muss vor Unterrichtsbeginn installiert sein. Getestet wurden Python
3.14.7 und lxml 6.1.3. Öffne im Ordner `project` ein Terminal. Unter Windows / PowerShell:

```powershell
py -3.14 -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
.\.venv\Scripts\python.exe -X utf8 pruefen.py versionen
```

Eine Aktivierung ist nicht nötig. Findet `py -3.14` deine Installation nicht,
verwende beim ersten Befehl den vollständigen Pfad zur `python.exe`, in PowerShell
mit `&` vor dem Pfad in Anführungszeichen. Linux/macOS: `python3.14 -m venv .venv`,
anschließend `.venv/bin/python` verwenden; diese Varianten wurden nicht separat getestet.

In den folgenden Befehlen steht `python` für den Interpreter dieser Umgebung,
unter Windows also `.\.venv\Scripts\python.exe`.

## Daten abrufen und eigene Dateien prüfen

```bash
python -X utf8 abrufen.py
python -X utf8 pruefen.py xml arbeit/wechselkurse.xml
python -X utf8 pruefen.py dtd arbeit/wechselkurse.xml arbeit/wechselkurse.dtd
```

`abrufen.py` stellt eine HTTP-GET-Anfrage mit `format=xml` an die NBP. Es erstellt
`quellen/`, speichert die unveränderte Antwort als `nbp-antwort.xml` und protokolliert
Anfrage, HTTP-Status, Abrufzeit, Kursdatum und Prüfsumme in `nbp-abruf.json`.
Ein erneuter erfolgreicher Abruf überschreibt diese beiden Dateien.

Die zwei Dateien unter `arbeit/` enthalten zunächst nur Kommentare. Ergänze sie
gemäß der Aufgabe. `xml` prüft die Wohlgeformtheit, `dtd` zusätzlich gegen deine
separat angegebene DTD. Füge keinen DOCTYPE in die XML-Datei ein. Rückgabecode 0
bedeutet Erfolg, 1 einen Prüf-/Dateifehler und 2 einen falschen Aufruf. Meldungen
der XML-Bibliothek können Englisch sein.

Öffne anschließend [index.html](index.html) aus deinem lokalen Projektordner im
Browser und lade dein korrektes XML. Der Rechner benötigt keinen Webserver und
nach dem Laden keine Internetverbindung. Die Skripte und die Anwendung sind
Hilfsmittel und werden nicht als selbst programmierte Lösung abgegeben.

## Austauschformat

Das vereinbarte Unterrichtsformat ist das Eingabeformat des Rechners, nicht das
Format der Nationalbank. Erzeuge dein Dokument selbst nach diesen Regeln:

- XML 1.0 und UTF-8, ohne Namespace und ohne DOCTYPE.
- Wurzelelement `wechselkurse` mit den Pflichtattributen `basis="PLN"` und `datum`.
- `datum` enthält das Kursdatum aus `EffectiveDate` im Format `YYYY-MM-DD`.
- Kindelemente in dieser Reihenfolge: genau eine `quelle`, ein oder mehrere `kurs`,
  am Ende optional ein `hinweis`.
- `quelle` enthält die Anfrage-URL `https://api.nbp.pl/api/exchangerates/tables/a/?format=xml` als Text.
- Jedes `kurs`-Element hat das Pflichtattribut `waehrung` mit einem der Werte
  `EUR`, `CZK` oder `PLN`. Der Zahlenwert steht direkt als Elementtext.
- `hinweis` enthält bei Bedarf eine kurze Anmerkung, etwa zur Nutzung der Ersatzdaten.
  Weitere Elemente und Attribute sind nicht vorgesehen.

Die NBP-Werte `Mid` geben **PLN pro einer Einheit der jeweiligen Währung** an.
Übernimm EUR, CZK und das Datum aus derselben Antwort; für PLN ist der Wert `1`.
Die Anwendung benötigt genau einen Eintrag je Währung. Die Reihenfolge der drei
Kurse ist beliebig. Kurse sind positive Dezimalzahlen mit Punkt, ohne
Tausendertrennzeichen oder Währungssymbol, höchstens 1.000.000 und mit höchstens
zwölf Nachkommastellen. Das Datum muss ein gültiges Kalenderdatum sein und darf
nicht in der Zukunft liegen. Historische Kurse behalten ihr tatsächliches Datum.

| Prüfung | Was sie nachweist |
| --- | --- |
| XML-Prüfwerkzeug | Wohlgeformtheit, etwa passende Start- und Endtags. |
| Deine DTD | Elementtypen, Reihenfolge, Häufigkeit, Pflichtattribute und erlaubte Attributwerte. |
| Fertiger Rechner | Format und fachliche Regeln: positive Zahlen, gültiges Datum, genau EUR/CZK/PLN und PLN gleich 1. |
| Vergleich mit der Originalantwort | Werte, Quelle und Datum wurden richtig übertragen. |

Eine DTD mit Textinhalten prüft keine positiven Zahlen oder Kalenderdaten und
stellt hier auch nicht sicher, dass jede Währung genau einmal vorkommt. Diese
Regeln prüft die Anwendung zusätzlich. Der Rechner führt keine DTD-Validierung
durch; diese bleibt ein eigener Nachweis mit `pruefen.py dtd`.

Der Vergleich verwendet `(Warenpreis + Versand) × Kurs der Währung ÷ EUR-Kurs`.
Warenpreis und Versand stehen in derselben Währung. Erst das Endergebnis wird
auf Cent gerundet; Rangfolge, Gleichstand und Ersparnis beziehen sich auf diese
Centbeträge. Die Angebote gelten für dieselben 1.000 Papierbecher à 300 ml bei
gleicher Qualität und Lieferfrist. Steuern, Bankgebühren und weitere Kosten
werden in diesem Unterrichtsmodell nicht berücksichtigt.

## DTD-Hilfe

Diese unabhängige Messwertdatei zeigt nur die Schreibweise. Formuliere die Regeln
für deine eigene Wechselkursdatei selbst:

```dtd
<!ELEMENT messung (ort, wert+, notiz?)>
<!ELEMENT ort (#PCDATA)>
<!ELEMENT wert (#PCDATA)>
<!ELEMENT notiz (#PCDATA)>
<!ATTLIST wert einheit (C|K) #REQUIRED>
<!ATTLIST messung kennung CDATA #REQUIRED>
```

- `ELEMENT` deklariert einen Elementtyp; jeder vorkommende Typ benötigt eine Deklaration.
- Das Komma legt die Reihenfolge fest. Ohne Zusatz kommt ein Element genau einmal
  vor; `+` bedeutet mindestens einmal, `?` null oder einmal, `*` null bis beliebig oft.
- `#PCDATA` erlaubt Textinhalt und prüft keine Zahlen.
- `ATTLIST` beschreibt Attribute; `#REQUIRED` verlangt ihre Angabe.
- `(C|K)` begrenzt den Attributwert auf die aufgeführten Möglichkeiten.
- `CDATA` erlaubt Attributtext und prüft kein Datumsformat.

Quelle: W3C, [XML 1.0, Fifth Edition, Abschnitt 3](https://www.w3.org/TR/xml/#sec-logical-struct),
zuletzt geprüft am 13.11.2026.

## Ersatzdaten bei Dienstausfall

Das Abrufwerkzeug wechselt bei einem Fehler nicht still auf Ersatzdaten. Falls
der Liveabruf scheitert, verwende ausdrücklich die mitgelieferte echte Antwort
`ersatzdaten/nbp-2026-11-13.xml`. **Erstelle zuerst `quellen/`, falls der fehlgeschlagene
Abruf den Ordner noch nicht angelegt hat.** Unter Windows / PowerShell:

```powershell
New-Item -ItemType Directory -Force quellen | Out-Null
Copy-Item -LiteralPath 'ersatzdaten/nbp-2026-11-13.xml' -Destination 'quellen/nbp-antwort.xml'
```

Alternativ kannst du den Ordner im Dateimanager anlegen und die Datei hineinkopieren
und in `nbp-antwort.xml` umbenennen. Notiere den gescheiterten Abruf, die Verwendung
der Ersatzantwort und deren tatsächliches Kursdatum. Die eigene XML-Datei und die
DTD werden weiterhin selbst erstellt.

Die Ersatzdatei wurde unverändert mit `abrufen.py` gespeichert:

- Herausgeber: Narodowy Bank Polski (NBP), [XML-Kurstabelle A](https://api.nbp.pl/api/exchangerates/tables/a/?format=xml).
- Methode: GET; HTTP-Status: 200; Content-Type: `application/xml; charset=utf-8`.
- Kursdatum: **2026-11-13**; Tabelle: `221/A/NBP/2026`.
- Tatsächlicher Abrufzeitpunkt (UTC): `2026-11-13T11:27:55.116643+00:00`.
- Serverdatum: `Fri, 13 Nov 2026 11:27:55 GMT`; Antwortgröße: 3009 Bytes.
- SHA256: `bc3b79f668dbc43e1f81287249bdd24a7630dacf3889d7031e2f72d3c280203e`.

Das Kursdatum bezeichnet die Veröffentlichung der Kurse, nicht den Zeitpunkt
deines Downloads. Der ursprüngliche [technische Abrufnachweis](https://github.com/TGM-HIT/insy-exercises/blob/27704ddaa452e5c4dbe284fbcca831c747924591/docs/review/aufgabe/material/ersatzdaten/nbp-2026-11-13-herkunft.json)
bleibt im unveränderlichen früheren Stand erhalten.
