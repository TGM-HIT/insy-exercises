---
hide:
  - navigation

---

# INSY GK25 Subselect

## Einführung

Das letzte wichtige Thema bezüglich SQL ist Subselect. Hierbei können ganze SELECT Abfragen verschachtelt werden um so selbst die kompliziertesten Antworten in einer einzigen Abfrage zu liefern.

## Ziele

Subselects/Subquery in Kombination mit den Standardvergleichsoperatoren sowie IN, EXISTS, ANY, ALL anwenden lernen.


## Kompetenzzuordnung

#### GK Abfragesprachen

* Subquerys in SELECT, INSERT, WHERE, UPDATE, DELETE; IN, EXISTS, ANY, ALL;

## Voraussetzungen

* *GROUP BY*

## Theorie

Ein Subselect ist eine SELECT Abfrage verschachtelt in einer größeren Abfrage.

Ein Subselect kann verschachtelt werden im:

* SELECT
* INSERT
* WHERE (am häufigsten)
* UPDATE
* DELETE

Die Operatoren EXISTS, ANY, ALL sowie die Standardvergleichsoperatoren =, <>, !=, >, >=, <, <= können verwendet werden.

Die Teil Abfragen werden auch Inner und Outer query gennant.

Das Inner query wird zuerst ausgeführt, und das Ergebnis wir für das Outer query verwendet.

```sql
SELECT cols FROM table
WHERE expr operator (
    SELECT cols FROM table
);
```

### Beispiel
#### students

| StudentID | Name   |
| --------- | ------ |
| 1         | Luke   |
| 2         | Leia   |
| 3         | Han    |
| 4         | Chewie |

#### marks

| StudentID | marks |
| --------- | ----- |
| 1         | 95    |
| 2         | 71    |
| 3         | 81    |
| 4         | 80    |

Wie können wir alle Studenten ausgeben die mehr Punkte haben als der Student mit der ID = 4? [1]

1. Wie viele Punkte hat der Student mit der ID = 4?

```sql
SELECT marks FROM marks WHERE StudentID = 4;
```

| marks |
| ----- |
| 80    |

2. Welche Studenten haben mehr als 80 Punkte?

```sql
SELECT name FROM students s
INNER JOIN marks m ON s.StudentID=m.StudentID
WHERE marks > 80;
```
Mittels Subquery können die beiden Abfragen zum einem zusammengefügt werden.
```sql
SELECT name FROM students s
INNER JOIN marks m ON s.StudentID=m.StudentID
WHERE marks > (
	SELECT marks FROM marks WHERE StudentID = 4);
```

## IN
Eintrag wird gelistet wenn ein bestimmter Wert auch im Subquery vorkommt.[5]
```sql
SELECT * FROM Customers
WHERE Country IN (SELECT Country FROM Suppliers);
```

## EXISTS
Neben den Standard-Vergleichsoperatoren können noch weitere Funktionen verwendet werden, zB. EXISTS

Dieser gibt TRUE falls das Subquery mindestens einen Eintrag zurück gibt.
Im Subquery wird dazu normalerweise die Original Tabelle mit der Subquery Tabelle im WHERE
des Subquerys verknüpft (ähnlich einem JOIN).[2,3]

### Beispiel
Folgendes Subquery listet alle Lieferanten mit Produkten die teurer sind als 20.

```sql
SELECT SupplierName
FROM Suppliers
WHERE EXISTS 
    (SELECT ProductName FROM Products 
    WHERE Products.SupplierID = Suppliers.supplierID AND Price < 20);
```

## ANY / ALL
Wird ein solcher Vergleichsoperator (=, <>, !=, >, >=, <, <=) mit einem der Schlüsselwörter ANY oder ALL kombiniert, dann ist als rechter Operand
(Subquery) eine Unterabfrage zugelassen, die eine Ergebnismenge zurückliefert (also mehr als nur eine Zeile). Wird auf ANY oder ALL verzichtet und nur 
ein Vergleichsoperator verwendet, so darf der rechte Operand (Subquery) nur eine Unterabfrage sein, die nur einen 
Datensatz zurückliefert. Linker und rechter Operand müssen Ausdrücke mit gleicher Struktur (vereinigungskonform) sein: 
gleiche Anzahl an Spalten, gleiche Datentypen, gleiche Reihenfolge der Spalten.[4,6]

```sql
   -- Welche Kunden aus Köln tätigen mehr Umsatz als irgendein Kunde aus Bonn?
   -- Kölner mit wenigstens so viel Umsatz wie der "geringste" Bonner.
   SELECT * 
     FROM Kunden
    WHERE Ort = 'Köln'
      AND Umsatz >= ANY (SELECT * 
                           FROM Kunden
                          WHERE Ort = 'Bonn');

   -- Welche Kunden aus Köln tätigen mehr Umsatz als alle Kunden aus Bonn?
   -- Kölner mit mehr Umsatz wie der "meiste" Bonner.
   SELECT * 
     FROM Kunden
    WHERE Ort = 'Köln'
      AND Umsatz >= ALL (SELECT * 
                           FROM Kunden
                          WHERE Ort = 'Bonn');
```

## Fragestellungen

Beantworte und dokumentiere folgende Fragestellungen.

### Grundlegend

* Wo in einem SQL Query können Subselects vorkommen?
* In Kombination welcher Befehle treten diese öfters auf?
* Wie funktionieren diese Befehle?

## Detaillierte Aufgabenbeschreibung

Bitte versuche alle wichtigen Information kurz und prägnant zu verschriftlichen.

### Grundanforderungen

Im Wintersemester hast du dir eine VM mit MariaDB und der flightdatabase installiert. Löse folgende Aufgaben.

1. **BikeStore** Liste alle Kunden, welche einen Store in ihrer Stadt haben.

| customer\_id | first\_name | last\_name | phone | email                      | street               | city    | state | zip\_code |
| :----------- | :---------- | :--------- | :---- | :------------------------- | :------------------- | :------ | :---- | :-------- |
| 68           | Jayne       | Kirkland   | null  | jayne.kirkland@hotmail.com | 7800 Second Lane     | Rowlett | TX    | 75088     |
| 79           | Ashanti     | Parks      | null  | ashanti.parks@hotmail.com  | 846 N. Helen St.     | Baldwin | NY    | 11510     |
| 160          | Omer        | Estrada    | null  | omer.estrada@gmail.com     | 9 Honey Creek Street | Rowlett | TX    | 75088     |

*20 rows*

2. Gib alle Flugzeugtypen, deren Hersteller und Höchstgeschwindigkeit aus, welche schneller fliegen können als die durchschnittliche Höchstgeschwindigkeit aller Flugzeugtypen.

| type     | manufacturer | maxspeed |
| :------- | :----------- | :------- |
| A330-300 | Airbus       | 500      |
| A340-200 | Airbus       | 500      |
| A380-800 | Airbus       | 507      |

*10 rows*

3. Gib jene Flugzeuge aus, welche von BZE gestartet sind.

| id   | manufacturer | type         | lengthoverall | span  | maxspeed | initialserviceyear | maxseats | seatsperrow |
| :--- | :----------- | :----------- | :------------ | :---- | :------- | :----------------- | :------- | :---------- |
| 44   | Boeing       | B757-300     | 54.43         | 38.05 | 505      | 1999               | 289      | 6           |
| 64   | Beechcraft   | Beechje 400A | null          | 13.25 | null     | 1993               | 9        | 2           |

4. Liste alle Boeing Maschinen auf, die älter sind, als zumindest eine Airbus Maschine.

| id   | manufacturer | type        | lengthoverall | span  | maxspeed | initialserviceyear | maxseats | seatsperrow |
| :--- | :----------- | :---------- | :------------ | :---- | :------- | :----------------- | :------- | :---------- |
| 34   | Boeing       | B707-320C   | 46.66         | 44.42 | 521      | 1962               | 219      | 6           |
| 35   | Boeing       | B717-200    | 37.8          | 28.4  | null     | 1999               | 110      | 5           |
| 36   | Boeing       | B727-200Adv | 46.68         | 32.92 | 530      | 1970               | 189      | 6           |

*14 rows*

5. Liste alle Boeing Maschinen auf, die älter sind, als alle Airbus Maschinen.

| id   | manufacturer | type        | lengthoverall | span  | maxspeed | initialserviceyear | maxseats | seatsperrow |
| :--- | :----------- | :---------- | :------------ | :---- | :------- | :----------------- | :------- | :---------- |
| 34   | Boeing       | B707-320C   | 46.66         | 44.42 | 521      | 1962               | 219      | 6           |
| 36   | Boeing       | B727-200Adv | 46.68         | 32.92 | 530      | 1970               | 189      | 6           |
| 37   | Boeing       | B737-200    | 30.53         | 28.35 | 488      | 1967               | 130      | 6           |

*5 rows*

### hr

6. Schreibe eine Abfrage, die alle Mitarbeiter anzeigt (Vor- und Nachname), die mehr verdienen als Mitarbeiter mit ID 163.

| first\_name | last\_name |
| :---------- | :--------- |
| Steven      | King       |
| Neena       | Kochhar    |
| Lex         | De Haan    |

*20 rows*

7. Schreibe eine Abfrage die alle Mitarbeiter anzeigt (Vor- und Nachname, Gehalt, Department, und Job ID) die die selbe Tätigkeit wie Mitarbeiter 169 innehaben.

| first\_name | last\_name | salary   | department\_id | job\_id |
| :---------- | :--------- | :------- | :------------- | :------ |
| Peter       | Tucker     | 10000.00 | 80             | SA\_REP |
| David       | Bernstein  | 9500.00  | 80             | SA\_REP |
| Peter       | Hall       | 9000.00  | 80             | SA\_REP |

*30 rows*

8. Schreibe eine Abfrage, die alle Mitarbeiter anzeigt (Vor- und Nachname, Gehalt, Department), die am wenigsten in ihrer Abteilung verdienen.

| first\_name | last\_name | salary   | department\_id |
| :---------- | :--------- | :------- | :------------- |
| Neena       | Kochhar    | 17000.00 | 90             |
| Lex         | De Haan    | 17000.00 | 90             |
| Bruce       | Ernst      | 6000.00  | 60             |

*23 rows*

9. Gib alle Mitarbeiter aus (ID, Vor- und Nachname) die mehr als das Durchschnittsgehalt verdienen.

| employee\_id | first\_name | last\_name |
| :----------- | :---------- | :--------- |
| 100          | Steven      | King       |
| 101          | Neena       | Kochhar    |
| 102          | Lex         | De Haan    |

*51 rows*

10. Gib alle Mitarbeiter (Vor- und Nachname, ID, Gehalt) aus, dessen Manager Payam ist.

| first\_name | last\_name | employee\_id | salary  |
| :---------- | :--------- | :----------- | :------ |
| Jason       | Mallin     | 133          | 3300.00 |
| Michael     | Rogers     | 134          | 2900.00 |
| Ki          | Gee        | 135          | 2400.00 |

*8 rows*

11. Gib alle Mitarbeiter (Vor- und Nachname, Department, Job ID) der Finanz Abteilung aus.

| department\_id | first\_name | last\_name | job\_id     | department\_name |
| :------------- | :---------- | :--------- | :---------- | :--------------- |
| 100            | Nancy       | Greenberg  | FI\_MGR     | Finance          |
| 100            | Daniel      | Faviet     | FI\_ACCOUNT | Finance          |
| 100            | John        | Chen       | FI\_ACCOUNT | Finance          |

*6 rows*

12. Gib alle Informationen zum Mitarbeiter mit dem Gehalt von 3000 und dessen Manager ID 121 ist. Versuche ein Subquery zu verwenden.

| employee\_id | first\_name | last\_name | email   | phone\_number | hire\_date | job\_id   | salary  | commission\_pct | manager\_id | department\_id |
| :----------- | :---------- | :--------- | :------ | :------------ | :--------- | :-------- | :------ | :-------------- | :---------- | :------------- |
| 187          | Anthony     | Cabrio     | ACABRIO | 650.509.4876  | 2007-02-07 | SH\_CLERK | 3000.00 | 0.00            | 121         | 50             |


13. Gib alle Informationen des Mitarbeiters mit einer der folgenden IDs aus: 134, 159, 183.

| employee\_id | first\_name | last\_name | email   | phone\_number      | hire\_date | job\_id   | salary  | commission\_pct | manager\_id | department\_id |
| :----------- | :---------- | :--------- | :------ | :----------------- | :--------- | :-------- | :------ | :-------------- | :---------- | :------------- |
| 134          | Michael     | Rogers     | MROGERS | 650.127.1834       | 2006-08-26 | ST\_CLERK | 2900.00 | 0.00            | 122         | 50             |
| 159          | Lindsey     | Smith      | LSMITH  | 011.44.1345.729268 | 2005-03-10 | SA\_REP   | 8000.00 | 0.30            | 146         | 80             |
| 183          | Girard      | Geoni      | GGEONI  | 650.507.9879       | 2008-02-03 | SH\_CLERK | 2800.00 | 0.00            | 120         | 50             |


14. Gib alle Informationen zu den Mitarbeitern aus dessen Gehalt zwischen 1000 und 3000 liegt.

| employee\_id | first\_name | last\_name | email   | phone\_number | hire\_date | job\_id   | salary  | commission\_pct | manager\_id | department\_id |
| :----------- | :---------- | :--------- | :------ | :------------ | :--------- | :-------- | :------ | :-------------- | :---------- | :------------- |
| 116          | Shelli      | Baida      | SBAIDA  | 515.127.4563  | 2005-12-24 | PU\_CLERK | 2900.00 | 0.00            | 114         | 30             |
| 117          | Sigal       | Tobias     | STOBIAS | 515.127.4564  | 2005-07-24 | PU\_CLERK | 2800.00 | 0.00            | 114         | 30             |
| 118          | Guy         | Himuro     | GHIMURO | 515.127.4565  | 2006-11-15 | PU\_CLERK | 2600.00 | 0.00            | 114         | 30             |

*26 rows*

15. Gib alle Informationen zu den Mitarbeitern aus, dessen Gehalt zwischen dem kleinsten Gehalt und 2500 liegt.

| employee\_id | first\_name | last\_name | email    | phone\_number | hire\_date | job\_id   | salary  | commission\_pct | manager\_id | department\_id |
| :----------- | :---------- | :--------- | :------- | :------------ | :--------- | :-------- | :------ | :-------------- | :---------- | :------------- |
| 119          | Karen       | Colmenares | KCOLMENA | 515.127.4566  | 2007-08-10 | PU\_CLERK | 2500.00 | 0.00            | 114         | 30             |
| 127          | James       | Landry     | JLANDRY  | 650.124.1334  | 2007-01-14 | ST\_CLERK | 2400.00 | 0.00            | 120         | 50             |
| 128          | Steven      | Markle     | SMARKLE  | 650.124.1434  | 2008-03-08 | ST\_CLERK | 2200.00 | 0.00            | 120         | 50             |

*11 rows*

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
[1] "SQL Subqueries" w3crecource; zuletzt besucht am 2021-05-09; [online](https://www.w3resource.com/sql/subqueries/understanding-sql-subqueries.php)  
[2] "13.2.10.6. EXISTS und NOT EXISTS" MySQL 5.7 Reference Manual; zuletzt besucht am 2021-05-09; [online](https://dev.mysql.com/doc/refman/5.7/en/exists-and-not-exists-subqueries.html)  
[3] "SQL EXISTS Operator" w3schools; zuletzt besucht am 2021-05-09; [online](https://www.w3schools.com/sql/sql_exists.asp)  
[4] "SQL ANY and ALL Operators" w3schools; zuletzt besucht am 2021-05-09; [online](https://www.w3schools.com/sql/sql_any_all.asp)  
[5] "SQL IN Operator" w3schools; zuletzt besucht am 2021-05-09; [online](https://www.w3schools.com/sql/sql_in.asp)  
[6] "ANY- / ALL-Operator" Datenbanken Online Lexikon TH Köln, Campus Gummersbach; zuletzt besucht am 2021-05-09; [online](https://wikis.gm.fh-koeln.de/Datenbanken/ANY-ALL)

---
**Version** *20230307v1*
