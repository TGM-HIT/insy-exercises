---
hide:
  - navigation
---

# GK11 Einfache Abfragen

## Einführung

Es gibt unterschiedliche Methoden um Daten zu speichern, bis jetzt hast du diese jedoch zumeist in Dateien auf einer Festplatte oder in einem Cloudstorage verwahrt. Für Webanwendungen oder maschinelle Weiterverarbeitung eignet sich dies eher schlecht, dafür werden zu meist Datenbanken verwendet. In Informationssysteme der 3. Klasse beschäftigen wir uns vor allem mit den relationalen Datenbanken.

## Ziele

Es wird sich mit den wichtigsten neuen Fachbegriffe und die Anwendungsfälle der relationalen Datenbanken beschäftigt. Außerdem werden einfache Abfragen auf die Datenbank ausgeführt.


## Kompetenzzuordnung

#### GK Datenbanksysteme

* Einführung Datenbanksysteme, Anwendungsfälle, einfache  Abfragen (SELECT, ORDER BY, LIMIT, LIKE) 

## Voraussetzungen

* Beherrschen einer Programmiersprache

## Fragestellungen

Bitte versuche alle wichtigen Informationen kurz und prägnant als Dokumentation laut den Dokumentationsrichtlinien zu verschriftlichen. Die meisten Antworten solltest du in den Quellen finden können.

### Grundlegend

* Was ist eine Datenbank und wo wird sie verwendet? Nenne Beispiele
* Was ist eine relationale Datenbank? Wodurch zeichnet sich diese aus?
* Was ist ein Datenbankmanagementsystem?
* Welche anderen Fachbegriffe musst du zu relationalen Datenbanken noch kennen?
* Wie werden zusammengehörige Daten gespeichert, wie werden gleichartige Daten gespeichert?
* Warum sollte man statt einer DB nicht Excel verwenden?
* Was ist SQL? Ist SQL Case Sensitive? Wie können Namen (für Tabellen und Datenbanken) gekennzeichnet werden?
* Wie funktionieren folgende SQL Befehle: *SELECT, DISTINCT, WHERE, AND, OR, NOT, BETWEEN, ORDER BY, LIKE, LIMIT, AS*?

TIPP: in den Quellen findest du die Antworten zu all diesen Fragen mit nur einem Klick.

## Detaillierte Aufgabenbeschreibung
### Grundanforderungen

Arbeite dich in SQL ein indem du [SQL Island](https://sql-island.informatik.uni-kl.de/) spielst. Gib deinen richtigen Namen im Spiel an, du erhältst ein Zertifikat am Ende, welches du in deine Dokumentation einbindest.

Nachdem du die Fragestellungen ausgearbeitet hast, löse folgende Aufgabenstellungen in der [flightdatabase](https://projekte.tgm.ac.at/phpmyadmin/index.php) (user: *insyread* pw: *insystudent* Projekteserver NEU). Versuche dabei dich mit der Benutzeroberfläche von phpmyadmin auseinanderzusetzten. Probiere alles aus, du kannst nichts kaputt machen. Solltest du dich nicht auskennen, frage deine Lehrperson.

Porbiere folgenden SQL Statements aus:

```sql
#Was ist das kürzeste SQL auf eine Tabelle? * steht als Platzhalter für alle Spalten
SELECT * FROM planes;

#Statt dem * können auch nur bestimmte Spalten ausgegeben werden.
SELECT manufacturer, type FROM planes

#Ist SQL Case-Sensitive?
#Befehle nicht, Tabellennamen, Spaltennamen, Werte schon
#Befehle zur übersichtlichkeit CAPS
SELECT * FROM planes

#Wie können Werte gefiltert werden?
SELECT * FROM planes WHERE id >= 50
SELECT * FROM planes WHERE manufacturer='Airbus'

#Wie filtern wir leere Werte/Zellen?
SELECT * FROM `planes` WHERE maxspeed IS  NULL
SELECT * FROM `planes` WHERE maxspeed IS NOT NULL

#Gib alle Flugzeuge aus mit einer Maxspeed zwischen 400 und 500.
SELECT * FROM `planes` WHERE maxspeed > 400 AND maxspeed < 500
SELECT * FROM `planes` WHERE maxspeed BETWEEN 400 AND 500

#Gib alle Flugzeuge aus mit einer Maxspeed kleiner als 400 oder größer 500.
SELECT * FROM `planes` WHERE maxspeed < 400 OR maxspeed > 500

#Gib alle Airbus oder Boeing Flugzeuge aus mit einer Maxspeed kleiner als 500.
#Berechnungen können im SELECT durchgeführt werden.
#AS lässt Spalten umbenennen.
SELECT *, 500-maxspeed AS Differenz FROM `planes` WHERE maxspeed < 500 AND (manufacturer='Airbus' OR manufacturer='Boeing')

#Gib alle Flugzeuge aus von einem Hersteller der mit B beginnt.
#% wildcard für beliebig viele beliebige Zeichen
#_ ein beliebiges Zeichen
SELECT * FROM planes WHERE manufacturer LIKE 'B%'

#Wie viele Einträge hat diese Tabelle?
SELECT COUNT(*) FROM planes
```

Schreibe SQL Statements für folgende Aufgaben:

1. Zeige Vorname und Nachname aller Passagiere, die auf einem Sitz „F“ sitzen und sortiere nach dem Nachnamen.
2. Zeige alle Flugzeuge, die nach 2000 auf den Markt gekommen sind und länger als 73m sind.
3. Zeige Flugzeuge, die breiter als lang sind.
4. Flugzeuge, die mehr als 30 Sitzreihen haben. Gib zusätzlich aus, wie viele Sitzplätze sie mehr als 30 haben.
5. Passagiere, die in Reihe 5-15 sitzen und ein „e“ im Vornamen haben.

Weitere [Übungen](https://github.com/TGM-HIT/insy-exercises/raw/main/docs/1.%20Semester/GK11%20Einfache%20Abfragen/Flightdata%20%C3%9Cbung.xlsx) (nicht erforderlich für Bewertung, eventuell hilfreich für die Moodle Überprüfung) ([Lösungen](https://github.com/TGM-HIT/insy-exercises/raw/main/docs/1.%20Semester/GK11%20Einfache%20Abfragen/Flightdata%20%C3%9Cbung%20L%C3%B6sung.xlsx)).

## Abgabe
Die durchgeführten Tätigkeiten und gewünschten Elemente müssen in einer Dokumentation gemäß der Dokumentationsrichtlinie.md zusammengefasst werden. Die Fragestellungen sollen mit Quellen ebenfalls in diesem Dokument bearbeitet werden.

Bei einem Abgabegespräch sind die laufende Umgebung sowie kurze Kontrollfragen zwecks Verständnisüberprüfung notwendig. Vor diesem Gespräch ist die Dokumentation eingescannt als ein **PDF** File auf moodle abzugeben. (Microsoft Office Lens [Android](https://play.google.com/store/apps/details?id=com.microsoft.office.officelens&hl=de_AT&gl=US), [iPhone](https://apps.apple.com/at/app/microsoft-office-lens-pdf-scan/id975925059); Online PDF Editor [pdffiller](https://www.pdffiller.com/de/))

## Bewertung
Gruppengröße: 1 Person
### Grundanforderungen **überwiegend erfüllt**
- [ ] Erfüllen des Moodle Test
- [ ] Abgabe der Dokumentation über Fragenstellung und Aufgaben
### Grundanforderungen **zur Gänze erfüllt**

- [ ] SQL Island Zertifikat erhalten
- [ ] Abgabegespräch über Fragestellungen und Aufgaben

## Quellen
* "Microsoft Office Lens";  [Android](https://play.google.com/store/apps/details?id=com.microsoft.office.officelens&hl=de_AT&gl=US), [iPhone](https://apps.apple.com/at/app/microsoft-office-lens-pdf-scan/id975925059)
* "Online PDF Editor"; zuletzt besucht 2021-08-06; [pdffiller](https://www.pdffiller.com/de/)
* "flightdatabase"; tgm Projekteserver; [flightdatabase](https://projekte.tgm.ac.at/phpmyadmin/index.php) (user: *flightdata* pw: *IbelieveIcanfly*)
* "Flightdata Schema"; GitHub, zuletzt besucht 2024-08-11; [online](https://github.com/TGM-HIT/insy-exercises/blob/main/docs/1.%20Semester/GK11%20Einfache%20Abfragen/FlightDataStructure.pdf)
* "SQL Tutorial"; w3cschools; zuletzt besucht 2022-08-01; [w3cschools.com](https://www.w3schools.com/sql/)
* "phpMyAdmin Tutorial"; tutorialspoint; zuletzt besucht 2022-08-01; [online](https://www.tutorialspoint.com/phpmyadmin/index.htm)
* "SQL Island"; Technische Universität Kaiserslautern; zuletzt besucht 2022-08-01; [online](https://sql-island.informatik.uni-kl.de/)
* "Was sind Datenbanken? - einfach erklärt!"; Code Construct; 2019-06-09; zuletzt besucht 2022-08-01; [youtube](https://www.youtube.com/watch?v=O2AIbuNOTDo)
* "Was ist ein Relationales Datenbankmodell? - einfach erklärt!"; Code Construct; 2020-05-23; zuletzt besucht 2022-08-01; [youtube](https://www.youtube.com/watch?v=oFcAQqKucL0)
* "Introduction to SQL"; w3cschools; zuletzt besucht 2022-08-01; [w3cschools.com](https://www.w3schools.com/sql/sql_intro.asp)
* "SQL SELECT Statement"; w3cschools; zuletzt besucht 2022-08-01; [w3cschools.com](https://www.w3schools.com/sql/sql_select.asp)
* "SQL SELECT DISTINCT Statement"; w3cschools; zuletzt besucht 2022-08-01; [w3cschools.com](https://www.w3schools.com/sql/sql_distinct.asp)
* "SQL WHERE Clause"; w3cschools; zuletzt besucht 2022-08-01; [w3cschools.com](https://www.w3schools.com/sql/sql_where.asp)
* "SQL AND, OR and NOT Operators"; w3cschools; zuletzt besucht 2022-08-01; [w3cschools.com](https://www.w3schools.com/sql/sql_and_or.asp)
* "SQL ORDER BY Keyword"; w3cschools; zuletzt besucht 2022-08-01; [w3cschools.com](https://www.w3schools.com/sql/sql_orderby.asp)
* "SQL LIKE Operator"; w3cschools; zuletzt besucht 2022-08-01; [w3cschools.com](https://www.w3schools.com/sql/sql_like.asp)
* "SQL Wildcards"; w3cschools; zuletzt besucht 2022-08-01; [w3cschools.com](https://www.w3schools.com/sql/sql_wildcards.asp)
* "SQL TOP, LIMIT, FETCH FIRST or ROWNUM Clause"; w3cschools; zuletzt besucht 2022-08-01; [w3cschools.com](https://www.w3schools.com/sql/sql_top.asp)

---
**Version** *20240811v2*