---
hide:
  - navigation

---

# INSY GK21 Aggregationsfunktionen

## Einführung

Am Beginn des Wintersemesters hast du dich mit dem Abfragen von Daten aus einer relationalen Datenbank beschäftigt. Dies funktioniert mittels `SELECT * FROM table;` (oder dergleichen). Das Ergebnis solch einer Abfrage ist eine Tabelle mit einer Vielzahl an Daten, die als Mensch schwer zu erfassen sind. Aggregationsfunktionen dienen nun dem Zwecke diese Daten zu vereinigen oder zu verdichten. Aggregationsfunktionen liefern immer nur einen einzigen Wert zurück.

## Ziele

Die wichtigsten Aggregationsfunktionen MIN, MAX, AVG, SUM, COUNT und DISTINCT kennenlernen und in Verbindung mit den schon bekannten Befehlen verwenden.


## Kompetenzzuordnung

#### GK Abfragesprachen 

* Aggregationsfunktionen - MIN, MAX, AVG, SUM, COUNT, COUNT DISTINCT; in Kombination mit WHERE

## Voraussetzungen

* *Einfache Abfragen*
* *Datenbanksystem Installation*

## Fragestellungen

Beantworte und dokumentiere folgende Fragestellungen.

### Grundlegend

* Wie werden MIN, MAX, AVG, SUM, COUNT und DISTINCT verwendet?
* An welcher Stelle in einem `SELECT * FROM table;` werden diese Befehle typischerweise verwendet?
* Wie können sie in Kombination mit `WHERE` verwendet werden?
* Können die Befehle auch *im* `WHERE` verwendet werden?
* Was ist der Datentyp der Rückgabewerte dieser Befehle?
* Wie können der Datentyp der Rückgabewerte umgewandelt werden?
* Was passiert wenn diese Befehle auf Spalten mit Text angewandt werden?

## Detaillierte Aufgabenbeschreibung
Bitte versuche alle wichtigen Information kurz und prägnant zu verschriftlichen.

### Grundanforderungen

Im Wintersemester hast du dir eine VM mit MariaDB und der flightdatabase installiert. Schreibe SQL Statements zu
folgenden Aufgaben:

1. Wie lange ist das kürzeste Flugzeug?
    `15.93`
2. Wer ist der erste Passagier im Alphabet?
    `Abbott`
3. Wie schnell ist das schnellste und langsamste Flugzeug?
    `530, 410`
4. Wann wurde das neuste Flugzeugmodel in Service genommen?
    `2004`
5. Wie viele ganze Sitze haben alle Airbus zusammen im Durchschnitt?
    `381`
6. Wie lange sind alle Boing B737 von '67 nebeneinander gestellt?
    `97.94`
7. Wie viele Flugzeuge sind älter als 50 Jahre?
    `16`
8. Wie viele Hersteller haben Flugzeugmodelle die älter sind als 50 Jahre?
    `10`
9. Wie viele Nachnamen von Passagieren haben Duplikate?
    `1144`
10. Ich wollte Wien so schnell wie möglich verlassen. Wann war der erste Flug?
    `2010-05-03 03:25:38`

## Abgabe
Die durchgeführten Tätigkeiten und gewünschten Elemente müssen in einer Dokumentation gemäß der Dokumentationsrichtlinien zusammengefasst werden. Die Fragestellungen sollen mit Quellen ebenfalls in diesem Dokument beantwortet werden.

Nachdem die Dokumentation eingescannt als ein **PDF** File (Microsoft Office Lens [Android](https://play.google.com/store/apps/details?id=com.microsoft.office.officelens&hl=de_AT&gl=US), [iPhone](https://apps.apple.com/at/app/microsoft-office-lens-pdf-scan/id975925059); Online PDF Editor [pdffiller](https://www.pdffiller.com/de/)) auf moodle abgegeben wurde, kann zur Grundkompetenzüberprüfung angetreten werden. Nachdem das bestanden wurde kann zu einem Abgabegespräch für eine bessere Benotung angetreten werden. Bei einem Abgabegespräch sind die laufende Umgebung sowie kurze Kontrollfragen zwecks Verständnisüberprüfung notwendig.

## Bewertung
Gruppengröße: 1 Person
### Grundanforderungen **überwiegend erfüllt**

- [ ] Erfüllen des Moodle Test
- [ ] Abgabe der Dokumentation über Fragenstellung und Aufgaben

### Grundanforderungen **zur Gänze erfüllt**

- [ ] Abgabegespräch über Fragestellungen und Aufgaben

## Quellen
* "Die Aggregationsfunktionen" Aggregationsfunktionen.pdf; zuletzt besucht 2022-12-12;
* "SQL MIN() and MAX() Functions" w3schools.com; zuletzt besucht 2022-12-12; [online](https://www.w3schools.com/sql/sql_min_max.asp)
* "SQL COUNT(), AVG() and SUM() Functions" w3schools.com; zuletzt besucht 2022-12-12; [online](https://www.w3schools.com/sql/sql_count_avg_sum.asp)
* "SQL SELECT DISTINCT Statement" w3schools.com; zuletzt besucht 2022-12-12; [online](https://www.w3schools.com/sql/sql_distinct.asp)
* "12.20.1 Aggregate Function Descriptions" mysql.com/doc; zuletzt besucht 2022-12-12; [online](https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html)
* "Aggregatfunktionen in SQL" dateneule.de; zuletzt besucht 2022-12-12; [online](https://www.dateneule.de/2019/04/29/aggregatfunktionen-in-sql/)

---
**Version** *20230307v1*