Ein Automobilhersteller will den Verkauf und die Produktion
seiner Modelle mit Hilfe einer relationalen Datenbank
verwalten. Eine Analyse der Betriebsabläufe ergibt
die folgende grundlegende Informationsstruktur:
1. Ein Kunde (Autohaus) kann verschiedene Modelle
bestellen, ein Modell kann von mehreren Kunden
bestellt werden.
2. Jede Kundenbestellung (Auftrag) kann mehrere Auftragspositionen
(Modelle) umfassen. Außerdem sind
auftragsbezogen Auftragsdatum, Rechnungsdatum,
Zahlungseingang, Bestellmenge und Liefertermin zu
erfassen. Wobei Mengen und Liefertermin von Auftragsposition
zu Auftragsposition unterschiedlich
sein können. Die Rechnungsstellung soll auftragsbezogen
erfolgen.
3. Ein Modell besteht aus verschiedenen Bauteilen unterschiedlicher
Stückzahl.
4. Ein Bauteil kann bei verschiedenen Zulieferfirmen
gefertigt werden, jede Zulieferfirma kann verschiedene
Bauteile liefern. Bauteil-Kosten, Lieferzeit und
Qualität variieren zwischen den verschiedenen Zulieferfirmen.

Dabei sollen mindestens die folgenden Attribute der Entitäten
verwaltet werden:
Kunden: Name, Straße, PLZ, Ort, Tel, Fax, E-Mail
Modell: Modell-Nr, Modell-Bez, Baujahr, Modell-Preis;
Bauteile: Bauteil-Nr, Bauteil-Funktion, Bauteil-Kosten,
Lieferzeit, Qualitätsklasse
Zulieferfirma: Name, Straße, PLZ, Ort, Tel, Fax, E-Mail,
Internetadresse
1. Entwerfen Sie das semantische Datenmodell in Form
eines Entity-Relationship-Diagramms, das auch die
Kardinalitätstypen der Assoziationen enthält.
2. Konstruieren Sie auf der Grundlage des ERDs
schrittweise ein logisches relationales Datenbankmodell.
Legen Sie in jeder Relation einen Primärschlüssel
und alle geforderten Attribute an! Lösen Sie evtl.
vorkommende komplexe Beziehungen auf! Erfassen
Sie dabei weitere erforderliche Attribute! Legen Sie in
den Zuordnungstabellen zusammengesetzte Primärschlüssel
an! Markieren Sie die Primär- und Fremdschlüssel
in den Relationen!