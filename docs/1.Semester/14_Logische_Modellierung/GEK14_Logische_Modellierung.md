---
hide:
  - navigation
---

# GEK14 Logische Modellierung

## Einführung

Das ERD ist für nicht technische Personen sehr anschaulich, um dieses jedoch in ein vollständiges logisches Datenbankmodell umwandeln zu können ist noch ein weiterer Schritt notwendig.

## Ziele

Es wird versucht ein ERD mittels wenigen Regeln in ein vollständiges Relationenmodell umzuwandeln. Das Relationenmodell kann dann einfach in ein SQL Create-Script überführt werden.


## Kompetenzzuordnung

#### GK Datenbankmodellierung

* Logische Modellierung, Relationenmodell 
* Create Script, DROP, INSERT INTO, UPDATE, DELETE

## Voraussetzungen

* *GK13 Datenbank Installation* abgeschlossen

## Fragestellungen

Bitte versuche alle wichtigen Informationen kurz und prägnant als Dokumentation laut den Dokumentationsrichtlinien zu verschriftlichen.

Verwende folgende Quellen:

* "Datenmodellierung 3 - RM"; GitHub; Erhard List; zuletzt besucht 2024-08-12; [online](https://github.com/TGM-HIT/insy-exercises/blob/main/docs/1.Semester/14_Logische_Modellierung/Datenmodellierung%203%20-%20RM.pdf)
* "Data definition language"; GitHub; Dominik Höbert; zuletzt besucht 2024-08-12; [online](https://github.com/TGM-HIT/insy-exercises/blob/main/docs/1.Semester/14_Logische_Modellierung/Data%20definition%20language.pdf)

### Grundlegend

* Was sagt ein Relationenmodell aus?
* Welche Eigenschaften hat ein Relationenmodell?
* Was ist der Unterschied zwischen Primär- und Fremdschlüssel?
* Was ist DDL?
* Wie funktionieren CREATE, DROP, INSERT INTO, UPDATE und DELETE?

### Erweitert

* Wie funktionieren foreign key Constraints in SQL?
* Wie funktionieren ON UPDATE und ON DELETE?
* Welches Problem können diese lösen?

TIPP: in den Quellen findest du die Antworten zu all diesen Fragen mit nur einem Klick.

## Detaillierte Aufgabenbeschreibung

Nachdem du die Fragestellungen ausgearbeitet hast, bearbeite folgende Aufgabenstellungen.

### Grundanforderungen

Erstelle aus dem ERD aus *GEK12 Datenmodellierung* Landwirtschaftsbetrieb ein RM und in weiterer Folge ein SQL Create-Script. Das Skript soll keine Fehler werfen, auch nicht bei wiederholten ausführen, sollte das Ergebnis immer das selbe sein. Füge testweise halbwegs sinnvolle Werte in jede Tabelle ein.

??? "Beispiel RM"

    sportler(**nr**, name)  
    wettbewerb(**name**, datum, art)  
    teilnahme(***snr: sportler.nr, wnr: wettbewerb.name***, platz)

??? "Beispiel Create Script"

    ```sql
    DROP DATABASE IF EXISTS test_db;
    CREATE DATABASE test_db;
    USE test_db;
    
    CREATE TABLE person(
      id int,
      vorname VARCHAR(50),
      nachname VARCHAR(50),
      tel VARCHAR(50)
    );
    
    INSERT INTO person(id, vorname, nachname) VALUES
    (3, 'dominik', 'hoebert');
    ```

<a href="https://github.com/TGM-HIT/insy-exercises/tree/main/docs/1.Semester/14_Logische_Modellierung/exercises" target="_blank">Weiterführende Übungen</a>


### Erweitert

Versuche sinnvolle foreign key Constraints in das Datenbankschema einzubauen.

## Abgabe
Die durchgeführten Tätigkeiten und gewünschten Elemente müssen in einer Dokumentation gemäß der Dokumentationsrichtlinien zusammengefasst werden. Die Fragestellungen sollen mit Quellen ebenfalls in diesem Dokument bearbeitet werden.

Bei einem Abgabegespräch sind die laufende Umgebung sowie kurze Kontrollfragen zwecks Verständnisüberprüfung notwendig. Vor diesem Gespräch ist die Dokumentation eingescannt als ein **PDF** File auf moodle abzugeben. (Microsoft Office Lens [Android](https://play.google.com/store/apps/details?id=com.microsoft.office.officelens&hl=de_AT&gl=US), [iPhone](https://apps.apple.com/at/app/microsoft-office-lens-pdf-scan/id975925059); Online PDF Editor [pdffiller](https://www.pdffiller.com/de/))

## Bewertung
Gruppengröße: 1 Person
### Grundanforderungen **überwiegend erfüllt**
- [ ] Erfüllen des Moodle Test
- [ ] Abgabe der Dokumentation über Fragenstellung und Aufgaben
### Grundanforderungen **zur Gänze erfüllt**
- [ ] Abgabegespräch über Fragestellungen und Aufgaben
### Erweiterte Anforderungen **überwiegend erfüllt**

- [ ] Abgabegespräch über Fragestellungen

### Erweiterte Anforderungen **zur Gänze erfüllt**

- [ ] Aufgabenstellung erfüllt

## Quellen
* "Microsoft Office Lens";  [Android](https://play.google.com/store/apps/details?id=com.microsoft.office.officelens&hl=de_AT&gl=US), [iPhone](https://apps.apple.com/at/app/microsoft-office-lens-pdf-scan/id975925059)
* "Online PDF Editor"; zuletzt besucht 2021-08-06; [pdffiller](https://www.pdffiller.com/de/)
* "flightdatabase"; tgm Projekteserver; [flightdatabase](https://projekte.tgm.ac.at/phpmyadmin/index.php) (user: *flightdata* pw: *IbelieveIcanfly*)
* "SQL Tutorial"; w3cschools; zuletzt besucht 2022-08-01; [w3cschools.com](https://www.w3schools.com/sql/)
* "Datenmodellierung 3 - RM"; GitHub; Erhard List; zuletzt besucht 2024-08-12; [online](https://github.com/TGM-HIT/insy-exercises/blob/main/docs/1.Semester/14_Logische_Modellierung/Datenmodellierung%203%20-%20RM.pdf)
* "Data definition language"; GitHub; Dominik Höbert; zuletzt besucht 2024-08-12; [online](https://github.com/TGM-HIT/insy-exercises/blob/main/docs/1.Semester/14_Logische_Modellierung/Data%20definition%20language.pdf)
* "SQL UPDATE Statement"; w3cschools; zuletzt besucht 2022-08-04; [online](https://www.w3schools.com/sql/sql_update.asp)
* "SQL DELETE Statement"; w3cschools; zuletzt besucht 2022-08-04; [online](https://www.w3schools.com/sql/sql_delete.asp)
* "FOREIGN KEY Constraints"; MySQL 8.0 Reference Manual; zuletzt besucht 2022-11-08; [online](https://dev.mysql.com/doc/refman/8.0/en/create-table-foreign-keys.html)

---
**Version** *20240812v2*
