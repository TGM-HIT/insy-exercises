---
hide:
  - navigation

---

# INSY GK23 UNION

## Einführung

Es gibt noch eine zweite Variante wie Tabellen verbunden werden können, und zwar mittels UNION. Dieser Befehl dient aber dazu andere Probleme zu lösen. JOIN erweitert eine Tabelle links oder rechts um mehr Spalten, UNION dagegen fügt mehr Datensätze unten an.

## Ziele

UNION und dessen Verwandte UNION ALL, INTERSECT, EXCEPT kennen und verwenden lernen und von JOIN unterscheiden.


## Kompetenzzuordnung

#### GK Abfragesprachen 

* Unterschied zu JOIN; UNION, UNION ALL, INTERSECT, EXCEPT

## Voraussetzungen

* *JOIN*

## Fragestellungen

Beantworte und dokumentiere folgende Fragestellungen.

### Grundlegend

* Wann ist UNION zu verwenden und wann JOIN? Nenne Beispiele.
* Was sind die Voraussetzungen um UNION verwenden zu können?
* Was ist der Unterschied zwischen UNION und UNION ALL?
* Wozu verwendet man INTERSECT?
* Wozu verwendet man EXCEPT?

## Detaillierte Aufgabenbeschreibung
Bitte versuche alle wichtigen Information kurz und prägnant zu verschriftlichen.

### Grundanforderungen

Im Wintersemester hast du dir eine VM mit MariaDB und mehreren Datenbanken installiert. Löse folgende Aufgaben.

*Vorbereitung 1:* Gib alle Flughäfen aus, in denen Flugzeuge Landen. Sortiere nach Namen. Wie viele sind es? `190`

*Vorbereitung 2:* Gib alle Flughäfen aus, in denen Flugzeuge Starten. Sortiere nach Namen. Wie viele sind es? `190`

1. Gib alle Flughäfen aus, in denen Flugzeuge Starten oder Landen. Sortiere nach Namen. Wie viele sind es? `352`   
2. Gib alle Flughäfen aus, in denen Flugzeuge Starten oder Landen. Zeige auch Doppelte. Sortiere nach Namen. Wie viele sind es? `380`
3. Gibt nur die Flughäfen aus, wo Flüge Starten und Landen. Sortiere nach Namen. Wie viele sind es? `6`
4. Gibt nur die Flughäfen aus, wo Flüge Landen ohne die wo Flüge Starten. Sortiere nach Namen. Wie viele sind es? `176`
5. Gib alle Länder aus, welche sowohl Flughäfen, als auch Fluglinien haben. Sortiere nach Namen. `165 rows`
```
165 rows
name
United Arab Emirates
United Arab Emirates
United Arab Emirates
...
```
6. **BikeStore** Gib Vorname und Nachname aller Kunden und Mitarbeiter aus. Sortiere nach Nachnamen.
```
1454 rows
first_name,last_name
Ester,Acevedo
Jamika,Acevedo
Penny,Acevedo
...
```
7. **BikeStore** Gib die Telefonnummern aller Mitarbeiter, Kunden und Shops aus. 
```
191 rows
phone
(831) 555-5554
(831) 555-5555
(831) 555-5556
...
```
8. **BikeStore** Gib Vorname und Nachname aller Kunden aus, die einen Shop in ihrer Stadt haben.
```
20 rows
first_name,last_name
Jayne,Kirkland
Ashanti,Parks
Omer,Estrada
...
```
9. **soccer** Gib die Namen aller Schiedsrichter und Assistentsschiedsricher aus. `56 rows`
```
56 rows
Name
Anton Averyanov
Bahattin Duran
Bjorn Kuipers
...
```
10. **northwind** Gib Vorname, Nachname und Stadt aller Lieferanten (Suppliers), Angestellten und Kunden aus. Gib in einer zusätzlichen Spalte den Typ aus (Lieferant, Angestellter, Kunde). Sortiere nach der Stadt.
```
48 rows
Typ,first_name,last_name,city
Lieferant,Naoki,Sato,null
Lieferant,Madeleine,Kelley,null
Lieferant,Cornelia,Weiler,null
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
[1] rwestMSFT, „EXCEPT and INTERSECT (Transact-SQL) - SQL Server“. https://learn.microsoft.com/en-us/sql/t-sql/language-elements/set-operators-except-and-intersect-transact-sql (zugegriffen 27. Dezember 2022).   
[2] „SQL - EXCEPT Clause“. https://www.tutorialspoint.com/sql/sql-except-clause.htm# (zugegriffen 27. Dezember 2022).   
[3] „SQL - INTERSECT Clause“. https://www.tutorialspoint.com/sql/sql-intersect-clause.htm (zugegriffen 27. Dezember 2022).   
[4] „SQL UNION Operator“. https://www.w3schools.com/sql/sql_union.asp (zugegriffen 27. Dezember 2022).


---
**Version** *20230307v1*