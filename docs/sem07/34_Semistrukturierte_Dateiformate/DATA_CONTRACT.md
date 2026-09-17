# Datenvertrag: Lieferantenkatalog

Dies ist ein didaktischer Austauschvertrag, kein bestehender Branchenstandard.
Zeichenkodierung: UTF-8. XML-Version: 1.0. Währung: EUR; alle Preise sind Nettopreise pro angegebener Einheit.

`catalog` trägt `currency="EUR"` und `updated="2026-09-13"`. Es enthält null bis viele
`product`-Elemente. Jedes hat eine eindeutige `id` (XML-ID-kompatibel, z. B. A100) und das
Attribut `active` mit genau `true` oder `false`.

Die Kindelemente stehen in dieser Reihenfolge:

| Feld | Regel |
| --- | --- |
| name | Genau einmal; nichtleerer Text. |
| category | Genau einmal; nichtleerer Text. |
| unit | Genau einmal; nichtleerer Text, z. B. kg, Stück oder Flasche. |
| price | Genau einmal; Dezimalzahl als Text mit Punkt und genau zwei Nachkommastellen, 0.00 bis 999999.99. |
| stock | Genau einmal; ganze Zahl von 0 bis 1000000. |
| description | Null oder einmal; optionaler Text. |
| tags | Genau einmal; enthält null bis viele nichtleere tag-Elemente. |

Unbekannte Elemente/Attribute und doppelte IDs sind nicht zulässig. DTD prüft Struktur,
Reihenfolge, Attribute und IDs; ihre Texttypen erzwingen keine Dezimalzahlen, Wertebereiche
oder nichtleeren Elementtext. Diese Regeln prüft der Import zusätzlich in Python.

In JSON bleiben Preise absichtlich Zeichenketten, damit Nachkommastellen und Dezimalpräzision
erhalten bleiben; `stock` ist eine Zahl, `active` ein Boolean und `tags` eine Liste. Eine fehlende
Beschreibung ist ausgelassen. Andere Aufteilungen sind diskutierbar, aber nicht der vereinbarte Vertrag.

Die CSV-Darstellung besteht aus `products.csv`, `product-tags.csv` und `catalog-meta.json`.
Trennzeichen ist Komma, Quote-Zeichen ist `"`. Header sind vorhanden. Alle Werte werden zunächst
als Text gelesen. Tags werden über die Produkt-ID zugeordnet; nicht durch einen selbst gewählten
Trenner in einer CSV-Zelle. Ein leeres Beschreibungsfeld steht hier für eine fehlende Beschreibung.
Diese Festlegung verliert die Unterscheidung zwischen absichtlich leerem und fehlendem Text.

`catalog-ns.xml` enthält dieselben Daten unter dem Default-Namespace `urn:tgm:insy:catalog:1`.
Der Vergleich erfolgt nach Namespace-URI und lokalem Namen, nicht anhand eines konkreten Präfixes.
Die DTD-Grundaufgabe bezieht sich ausdrücklich auf `catalog.xml` ohne Namespace.

Ein verfügbarer Artikel erfüllt `active=true` und `stock>0`. Der Warenwert ergibt sich aus
`price * stock` je Artikel und anschließendem Addieren. Preise unterschiedlicher Einheiten
werden nicht unmittelbar miteinander verglichen, um daraus einen Einkaufsvorteil abzuleiten.
