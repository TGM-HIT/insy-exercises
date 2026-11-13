# Austauschformat für den Lieferantenvergleich

Dieses kleine XML-Format ist für den bereitgestellten Rechner vereinbart. Es ist
ein Unterrichtsformat, kein Format der Nationalbank. Du erstellst das Dokument selbst.

## Aufbau

* XML 1.0, UTF-8, ohne Namespace und ohne DOCTYPE.
* Wurzelelement: `wechselkurse`.
* Pflichtattribute der Wurzel: `basis` mit Wert `PLN` und `datum` mit dem Kursdatum
  aus `EffectiveDate` im Format `YYYY-MM-DD`.
* Kindelemente in dieser Reihenfolge: eine `quelle`, ein oder mehrere `kurs`,
  optional abschließend ein `hinweis`.
* `quelle` enthält die Anfrage-URL `https://api.nbp.pl/api/exchangerates/tables/a/?format=xml` als Text.
* Jedes `kurs`-Element hat das Pflichtattribut `waehrung` mit einem der Werte `EUR`,
  `CZK` oder `PLN`. Der Kurswert steht direkt als Text im Element.
* `hinweis` enthält bei Bedarf eine kurze Anmerkung, etwa zur Nutzung der Ersatzdaten.
* Weitere Elemente und Attribute sind nicht vorgesehen.

## Bedeutung und Werte

Der Kurs ist immer **PLN pro einer Einheit der angegebenen Währung**. Die NBP-Antwort
liefert für EUR und CZK das Feld `Mid`; für PLN trägst du selbst `1` ein.
Übernimm EUR, CZK und das Datum aus **derselben** Antwort. Der Rechner benötigt genau
einen Eintrag pro Währung. Die Reihenfolge der drei Kurse ist beliebig.

Alle Kurse sind positive Dezimalzahlen mit Punkt, ohne Tausendertrennzeichen oder
Währungssymbol, höchstens 1.000.000 und mit höchstens zwölf Nachkommastellen.
`datum` ist ein gültiges Kalenderdatum und liegt nicht in der Zukunft. Historische Kursdaten werden
mit ihrem tatsächlichen Datum verwendet und nicht als heutige Kurse ausgegeben.

## Was wird geprüft?

| Prüfung | Nachweis |
| --- | --- |
| XML-Prüfwerkzeug | Wohlgeformtheit, etwa passende öffnende und schließende Tags. |
| Deine DTD | Elementtypen, Reihenfolge, Häufigkeit, Pflichtattribute und erlaubte Attributwerte. |
| Fertiger Rechner | Vereinbartes Format und zusätzlich positive Zahlen, gültiges Datum, genau EUR/CZK/PLN und PLN gleich 1. |
| Dein Vergleich mit der Originalantwort | Werte, Quelle und Datum wurden richtig übertragen. |

Eine DTD mit Textinhalten prüft keine positiven Zahlen oder Kalenderdaten. Sie kann
in diesem Format auch nicht sicherstellen, dass jede der drei Währungen genau einmal
vorkommt. Diese fachlichen Regeln bleiben Aufgabe der Anwendung. Der Rechner führt
keine DTD-Validierung durch; diese wird mit `pruefen.py dtd` separat nachgewiesen.

## Angebotsvergleich

Für jede Angebotswährung gilt:

`Gesamtbetrag in EUR = (Warenpreis + Versand) × Kurs der Währung ÷ EUR-Kurs`

Die beiden Preise eines Angebots stehen in derselben Währung. Gerechnet wird mit
den eingelesenen Kurswerten; erst das Endergebnis wird auf Cent gerundet. Rangfolge,
Gleichstand und Ersparnis orientieren sich an den angezeigten Centbeträgen.

Die fiktiven Angebote gelten für dieselben 1.000 Papierbecher à 300 ml, dieselbe
Qualität und Lieferfrist. Nettopreis und Versand werden berücksichtigt; Steuern,
Bankgebühren und weitere Kosten sind nicht Teil des Unterrichtsmodells.
