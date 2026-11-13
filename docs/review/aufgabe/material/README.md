# Arbeitsmaterial: Lieferantenangebote mit XML vergleichen

Dieses Paket enthält die fertigen Werkzeuge für eine gemeinsame GK-Aufgabe in
vier Unterrichtseinheiten. Erstellt eure XML-Datei und eure DTD selbst. Der
Auftrag, der Datenvertrag und die Bewertung stehen auf der Kursseite.

## Start unter Windows / PowerShell

Python 3.14 muss vor Unterrichtsbeginn installiert sein. Getestete Basis:
Python 3.14.7 und lxml 6.1.3. Entpackt das Paket vollständig und öffnet im Ordner
`material` ein Terminal. Eine Aktivierung der Umgebung ist nicht erforderlich.

```powershell
py -3.14 -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
.\.venv\Scripts\python.exe -X utf8 pruefen.py versionen
```

Findet `py -3.14` eure Installation nicht, ersetzt es beim ersten Befehl durch
den vollständigen Pfad zur `python.exe`, in PowerShell mit `&` vor dem Pfad
in Anführungszeichen. Anschließend verwendet ihr immer den Interpreter der venv.

Linux/macOS: `python3.14 -m venv .venv`, anschließend `.venv/bin/python` verwenden.
Diese Betriebssystemvarianten wurden für dieses Paket nicht separat getestet.

In den folgenden Beispielen bedeutet `python` den Interpreter eurer venv,
unter Windows also `.\.venv\Scripts\python.exe`.

## Daten abrufen

```bash
python -X utf8 abrufen.py
```

Der vorgegebene HTTP-GET-Abruf fordert die NBP-Kurstabelle A als XML an und legt
die unveränderte Antwort in `quellen/nbp-antwort.xml` ab. `quellen/nbp-abruf.json`
enthält Anfrage, Status, Abrufzeit, Kursdatum und Prüfsumme. Ein erneuter
erfolgreicher Abruf überschreibt diese beiden Dateien.

**Die NBP-Werte `Mid` sind PLN je einer Einheit der jeweiligen Währung.**
Übernehmt EUR und CZK aus derselben Antwort. Für die Basiswährung PLN gilt 1.
Das Kursdatum steht in `EffectiveDate` und muss nicht dem Abrufdatum entsprechen.

Bei einem Dienstausfall gibt es keinen stillen Wechsel auf Ersatzdaten. Verwendet
ausdrücklich die Datei unter `ersatzdaten/`; deren Herkunft ist daneben dokumentiert.
Notiert den Ausfall und das tatsächliche Kursdatum in eurem Protokoll. Die
Ersatzantwort ist eine echte frühere Dienstantwort und keine eigene XML-Lösung.

## Eigene Dateien prüfen

Erstellt `arbeit/wechselkurse.xml` und `arbeit/wechselkurse.dtd`. Beide Vorlagen
enthalten zunächst nur einen Kommentar und sind noch keine fertige Lösung.

```bash
python -X utf8 pruefen.py xml arbeit/wechselkurse.xml
python -X utf8 pruefen.py dtd arbeit/wechselkurse.xml arbeit/wechselkurse.dtd
```

`xml` prüft die Wohlgeformtheit. `dtd` prüft zusätzlich gegen **eure** DTD.
Eine erfolgreiche DTD-Prüfung garantiert keine korrekten Zahlen oder vollständigen
Währungen. Diese Anwendungsregeln prüft zusätzlich der fertige Rechner.

Die DTD wird separat angegeben; fügt keinen DOCTYPE in die XML-Datei ein.
Rückgabecode 0 bedeutet Erfolg, 1 einen Prüf-/Dateifehler und 2 einen falschen
Kommandozeilenaufruf. Originalmeldungen der XML-Bibliothek können Englisch sein.

## Ergebnis verwenden

Öffnet `rechner.html` im Browser und ladet eure selbst erstellte XML-Datei.
Der Rechner funktioniert nach dem Entpacken lokal ohne Webserver. Er berechnet
den Warenpreis einschließlich vorgegebener Versandkosten in Euro. Die Erklärung
des Ergebnisses und eure Empfehlung gehören in die gemeinsame Dokumentation.

Die Rechnerdatei und die vorgegebenen Python-Werkzeuge werden nicht programmiert
oder als eigene Lösung abgegeben. Die vollständige Abgabeliste steht in der Angabe.
