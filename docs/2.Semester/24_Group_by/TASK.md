---
hide:
  - navigation

---

# INSY GK24 GROUP BY

## Einführung

Mittels GROUP BY können, wie der Name schon sagt, große Datensätze nach gleichen Werten gruppiert werden, um Informationen zu aggregieren. Vor allem in Kombination mit den schon bekannten Aggregationsfunktionen können so komplizierte Fragestellungen beantwortet werden.

## Ziele

GROUP BY kennen und verwenden lernen, auch in Kombination mit JOIN und Aggregationsfunktionen. HAVING verwenden und den Unterschied zu WHERE verstehen.


## Kompetenzzuordnung

#### GK Abfragesprachen

* GROUP BY, HAVING (vs. WHERE), mit Aggregationsfunktionen und JOIN

## Voraussetzungen

* *UNION*

## Fragestellungen

Beantworte und dokumentiere folgende Fragestellungen.

### Grundlegend

* Erkläre die Funktionsweise von GROUP BY anhand eines Beispiels.
* Welche Fragestellungen können mit GROUP BY beantwortet werden (Beispiel)?
* Wie ist HAVING zu verwenden? Kann WHERE stattdessen verwendet werden?
* An welcher Stelle in einer SELECT SQL Abfrage steht das GROUP BY und HAVING?
* Wie können Aggregationsfunktionen mit GROUP BY verwendet werden?

## Detaillierte Aufgabenbeschreibung

Bitte versuche alle wichtigen Information kurz und prägnant zu verschriftlichen.

### Grundanforderungen

Im Wintersemester hast du dir eine VM mit MariaDB und der flightdatabase installiert. Löse folgende Aufgaben.

1. Wie viele Fluglinien hat jedes Land? Sortiere nach der Anzahl, die meisten zuerst.
```
165 rows
name,count(id)
United States,103
Romania,35
Canada,23
...
```
2. Wie viele Flugzeugtypen hat jeder Flugzeughersteller erzeugt. Zeige nur Hersteller mit mindestens 2 produzierten Maschinen. Sortiere nach der Anzahl, die meisten zuerst.
```
6 rows
manufacturer,count
Boeing,14
Airbus,11
McDonald Douglas,3
...
```
3. Gib die schnellste und langsamste Geschwindigkeit jedes Flugzeugherstellers aus. Sortiere nach der Schnellsten Geschwindigkeit.
```
19 rows
manufacturer,max,min
Boeing,530,488
Airbus,507,480
McDonald Douglas,503,503
...
```
4. Gib die Durchschnittslänge der produzierten Flugzeuge jedes Herstellers aus. Zeige nur Hersteller mit Durchschnittslängen länger als 20m. Sortiere nach der längsten Durchschnittslänge.
```
10 rows
manufacturer,avg
Airbus,55.832818181818176
McDonald Douglas,49.676666666666655
Boeing,45.84142857142857
...
```
5. Gib die Städte und ihre Anzahl an Flughäfen aus, aber nur wenn sie mehr als einen haben. Sortiere nach der Anzahl, die meisten zuerst.
```
529 rows
city,count
Paris,15
Houston,13
Los Angeles,11
...
```
6. Gib die Länder und deren Anzahl an Städten mit Flughäfen aus. Sortiere nach der Anzahl, die meisten zuerst.
```
231 rows
country,count
US,2341
AU,623
CA,546
...
```
7. Gib die Fluglinien aus, und die Summe ihrer Transportierten Passagiere. Sortiere nach der Anzahl, die meisten zuerst.
```
167 rows
airline,count
UP,42
LH,30
JX,27
...
```
8. Gib die Fluglinien aus und die Summe der verwendeten Flugzeugtypen. Sortiere nach der Anzahl, die meisten zuerst.
```
168 rows
name,count
Hong Kong Express Airways,3
Austrian Arrows,2
Travel Service,2
...
```
9. **movie** Gib die Anzahl der Filme pro Erscheinungsjahr aus. Sortiere nach der Anzahl, die meisten zuerst.
```
22 rows
mov_year,count
1997,4
2001,2
1999,2
...
```
10. **movie** Gib die Anzahl der Filme pro Sprache aus. Sortiere nach der Anzahl, die meisten zuerst.
```
mov_lang,count
English,25
Japanese,3
```
11. **movie** Gib die Durchschnittliche Bewertung pro Erscheinungsjahr sowie die Anzahl an Bewertungen aus. Sortiere nach der höchsten Bewertung.
```
15 rows
mov_year,avg,count
1958,8.400000,1
1986,8.400000,1
1962,8.300000,1
...
```
12. **movie** Gib die Anzahl der Filme pro Genre aus. Sortiere nach der Anzahl, die meisten zuerst.
```
12 rows
gen_title,count
Drama,4
Mystery,3
Adventure,2
...
```

## Abgabe
Die durchgeführten Tätigkeiten und gewünschten Elemente müssen in einer Dokumentation gemäß der Dokumentationsrichtlinien zusammengefasst werden. Die Fragestellungen sollen mit Quellen ebenfalls in diesem Dokument beantwortet werden.

Nachdem die Dokumentation eingescannt als ein **PDF** File (Microsoft Office Lens [Android](https://play.google.com/store/apps/details?id=com.microsoft.office.officelens&hl=de_AT&gl=US), [iPhone](https://apps.apple.com/at/app/microsoft-office-lens-pdf-scan/id975925059); Online PDF Editor [pdffiller](https://www.pdffiller.com/de/)) auf moodle abgegeben wurde, kann zur Grundkompetenzüberprüfung angetreten werden. Nachdem das bestanden wurde kann zu einem Abgabegespräch für eine bessere Benotung angetreten werden. Bei einem Abgabegespräch sind die laufende Umgebung sowie kurze Kontrollfragen zwecks Verständnisüberprüfung notwendig.

## Bewertung
Gruppengrösse: 1 Person

### Grundanforderungen **überwiegend erfüllt**

- [ ] Erfüllen des Moodle Test
- [ ] Abgabe der Dokumentation über Fragenstellung und Aufgaben

### Grundanforderungen **zur Gänze erfüllt**

- [ ] Abgabegespräch über Fragestellungen und Aufgaben

## Quellen
[1] „SQL GROUP BY Statement“. https://www.w3schools.com/sql/sql_groupby.asp (zugegriffen 27. Dezember 2022).  
[2] „SQL HAVING Clause“. https://www.w3schools.com/sql/sql_having.asp (zugegriffen 27. Dezember 2022).


---
**Version** *20230307v1*