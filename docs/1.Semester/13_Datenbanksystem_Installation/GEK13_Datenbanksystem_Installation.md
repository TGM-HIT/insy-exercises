# INSY GEK13 Datenbanksystem Installation

## Einführung

Damit wir nicht immer auf der flightdatabase arbeiten müssen, vor allem da dort die Rechte sehr eingeschränkt sind, gilt es nun selbst eine Datenbank aufzusetzen. Dazu gibt es mehrere Möglichkeiten, es gibt Pakete wie XAMPP, oder Webservices wie Heroku, welche Datenbanken als Service anbieten. Hier jedoch sehen wir uns zwei realitätsnahe Beispiele an.

## Ziele

Es wird Docker installiert und ein MariaDB Container augesetzt. Dann soll der Datenbank Client Datagrip Verbindung zur Datenbank aufnehmen.


## Kompetenzzuordnung

#### GK Datenbanksystem installieren

* Installation eines relationalen Datenbanksystems (MySQL,  MariaDB) in einer Virtuellen Maschine, Konfiguration Datagrip

## Voraussetzungen

* *GK12 Datenmodellierung* abgeschlossen

## Fragestellungen

Bitte versuche alle wichtigen Informationen kurz und prägnant als Dokumentation laut den Dokumentationsrichtlinien zu verschriftlichen.

### Grundlegend

* Was ist ein Container?
* Wo ist der Unterschied zu einer VM?
* Was sind die Vor- und Nachteile?
* Wie installiert man sich einen Container?
* Wie bekommt man Daten/Verbindung in/aus dem Container?
* Was ist ein Docker Compose file?

### Erweitert

* Was ist der Unterschied zwischen Ubuntu und Ubuntu Server?
* Was ist Ubuntu LTS?
* Was ist SSH?

TIPP: in den Quellen findest du die Antworten zu all diesen Fragen mit nur einem Klick.

## Detaillierte Aufgabenbeschreibung
### Grundanforderungen

Nachdem du die Fragestellungen ausgearbeitet hast, siehe dir folgende Aufgabenstellungen an.

### Mariadb Container Installation

Nachdem [Docker Desktop](https://www.docker.com/) installiert ist und der Balken in der unteren linken Ecke grün ist, können Container installiert werden.

Erstelle dazu in deinem Benutzer Ordner (~) einen neuen Ordner namens `mariadb`. Erstelle darin ein `compose.yml` mit folgendem [Inhalt](https://raw.githubusercontent.com/dominikhoebert/docker-projects/master/mariadb/compose.yml). Stelle sicher, dass dieser Ordner **nicht** in einem Cloudspeicher (wie OneDrive oder Dropbox) liegt (Grund: Cloudspeicher lagern manchmal Daten in die Cloud aus, dann funktioniert unser Container nicht mehr).

Konfiguriere nun das compose file: ändere das `MARIADB_ROOT_PASSWORD` (Passwort Manager!) da sonst jeder mit deiner IP Adresse auf deine Datenbank zugreifen kann. Weiters werden mit diesem compose file nicht nur ein mariadb Container gestartet sondern auch eine Nummer an Web IDEs. Probiere zumindest einen davon aus. Die anderen können mit `#` auskommentiert werden.

Mit einem Terminal soll zu dem Ordner navigiert werden (`cd`).
Dann soll folgender Befehl ausgeführt werden:

```bash
docker-compose up -d
```

Dies ladet die Container herunter, installiert und startet diese.
Nun kann die Web IDE über [localhost:PORT](http://localhost:PORT/) aufgerufen werden (Adminer: 8081; WhoDB: 8082; usw.)
Melde dich an mit System: MySQL; Server: *mariadb* ; und deinen gewählten DB Credetials (Standard User: *root* ; Password: *example*)
Mache dich mit der IDE vertraut.

Um in den Container mittels Bash zu gelangen führe im Terminal aus:

```bash
docker exec -ti db /bin/sh
```

Dann kann MariaDB Kommandozeile aufgerufen werden:

```bash
mariadb -u root -p
```

### Download Client

[Jet Brains Datagrip](https://www.jetbrains.com/datagrip/download/#section=windows) (Use your Student Login for Full Version)

### Datagrip konfiguration

Nun wollen wir nicht ständig in der MariaDB Command Line arbeiten sondern eine IDE verwenden. Folge der Anleitung um Datagrip mit MariaDB zu verbinden.

* Klicke oben links bei Database auf das kleine + Symbol
* Data Source
* MariaDB
* Wähle einen passenden Namen
* Host: localhost
* User und pw: root/example (außer es wurde geändert im docker-compose)
* eventuell Driver update
* Test Connection
* OK

Mache dich nun mit der Benutzeroberfläche vertraut. Versuche einfache Befehle auszuführen.

### Sample Database einbinden

Bis auf Systemrelevante Datenbanken ist unsere DB leer. Das wollen wir ändern.

* [Download Sample Databases](https://download-directory.github.io/?url=https%3A%2F%2Fgithub.com%2FTGM-HIT%2Finsy-exercises%2Ftree%2Fmain%2Fdocs%2F1.Semester%2F13_Datenbanksystem_Installation%2FSample_databases)
* Zeige dir das SQL File rechts im Fileexplorer an
* markiere alle SQLs, dann Rechtsklick
* Run...
* Target data source: Wähle die Zieldatenbank falls noch nicht ausgewählt
* Run
* Links bei der Connection klicke auf die Zahl --> Alle Anzeigen

Du solltest nun mehrere Datenbanken sehen. Mache dich mit ihnen vertraut.

Tipp: Rechtsklick auf eine DB -> Show Diagramm

### Erweitert

Installiere einen MariaDB Server (nativ, ohne Docker) in einer Linux Server VM (ohne GUI). Verwende SSH. Konfiguriere alles entsprechend und verbinde Datagrip zur DB.

## Abgabe
Die durchgeführten Tätigkeiten und gewünschten Elemente müssen in einer Dokumentation gemäß der Dokumentationsrichtlinien zusammengefasst werden. Die Fragestellungen sollen mit Quellen ebenfalls in diesem Dokument bearbeitet werden.

Bei einem Abgabegespräch sind die laufende Umgebung sowie kurze Kontrollfragen zwecks Verständnisüberprüfung notwendig. Vor diesem Gespräch ist die Dokumentation eingescannt als ein **PDF** File auf moodle abzugeben. (Microsoft Office Lens [Android](https://play.google.com/store/apps/details?id=com.microsoft.office.officelens&hl=de_AT&gl=US), [iPhone](https://apps.apple.com/at/app/microsoft-office-lens-pdf-scan/id975925059); Online PDF Editor [pdffiller](https://www.pdffiller.com/de/))

## Bewertung
Gruppengröße: 1 Person
### Grundanforderungen **überwiegend erfüllt**
- [ ] MariaDB oder MySQL Container installiert
- [ ] Datagrip Verbindung zur Datenbank im Container hergestellt
### Grundanforderungen **zur  Gänze erfüllt**
- [ ] Sample Databases angelegt
- [ ] Fragestellungen beantwortet
- [ ] Kann einfache Befehle in Datagrip ausführen
### Erweiterte Anforderungen **überwiegend erfüllt**

- [ ] Ubuntu Server installiert
- [ ] MariaDB installiert und konfiguriert
- [ ] Datagrip installiert
- [ ] Datagrip Verbindung zur DB

### Erweiterte Anforderungen **zur  Gänze erfüllt**

- [ ] Fragestellungen beantwortet

## Quellen
- "Microsoft Office Lens";  [Android](https://play.google.com/store/apps/details?id=com.microsoft.office.officelens&hl=de_AT&gl=US), [iPhone](https://apps.apple.com/at/app/microsoft-office-lens-pdf-scan/id975925059)
- "Online PDF Editor"; zuletzt besucht 2021-08-06; [pdffiller](https://www.pdffiller.com/de/)
- "flightdatabase"; tgm Projekteserver; [flightdatabase](https://projekte.tgm.ac.at/phpmyadmin/index.php) (user: *flightdata* pw: *IbelieveIcanfly*)
- "SQL Tutorial"; w3cschools; zuletzt besucht 2022-08-01; [w3cschools.com](https://www.w3schools.com/sql/)
- "Ubuntu Desktop vs. Ubuntu Server: What’s the Difference?"; makeuseof; 2021-12-27; zuletzt besucht 2022-08-04; [online](https://www.makeuseof.com/tag/difference-ubuntu-desktop-ubuntu-server/)
- "Definition Secure Shell (SSH)"; computerweekly; Peter Loshin; zuletzt besucht 2022-08-04; [online](https://www.computerweekly.com/de/definition/Secure-Shell-SSH)
- "Get Ubuntu Server"; Ubuntu; zuletzt besucht 2022-08-04;  [online](https://ubuntu.com/download/server)
- "Installieren von MariaDB unter Ubuntu 20.04"; digitalocean; Mark Drake and Brian Boucheron; 2020-06-12; zuletzt besucht 2022-08-04; [online](https://www.digitalocean.com/community/tutorials/how-to-install-mariadb-on-ubuntu-20-04-de)
- "Download DataGrip"; jetbrains; zuletzt besucht 2022-08-04; [online](https://www.jetbrains.com/datagrip/download/#section=windows)
- "How to Allow Remote Connections to MySQL"; phoenixnap; 2020-03-26; zuletzt besucht 2022-08-04; [online](https://phoenixnap.com/kb/mysql-remote-connection)
- "Configuring MariaDB for Remote Client Access"; mariadb; zuletzt besucht 2022-08-04; [online](https://mariadb.com/kb/en/configuring-mariadb-for-remote-client-access/)
- "How To Create a New User and Grant Permissions in MySQL"; digitalocean; 2012-06-12; updated 2022-03-18; zuletzt besucht 2022-08-04; [online](https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql)
- "How to Create MySQL Users Accounts and Grant Privileges"; linuxize; 2020-05-30; zuletzt besucht 2022-08-04; [online](https://linuxize.com/post/how-to-create-mysql-user-accounts-and-grant-privileges/)
- "MobaXterm";mobaxterm; zuletzt besucht 2022-08-04; [online](https://mobaxterm.mobatek.net/)
- "iTerm2"; iterm2; zuletzt besucht 2022-08-04; [online](https://iterm2.com/)
- "SampleDatabase"; GitHub; Dominik Höbert; zuletzt besucht 2024-08-12; [online](https://download-directory.github.io/?url=https%3A%2F%2Fgithub.com%2FTGM-HIT%2Finsy-exercises%2Ftree%2Fmain%2Fdocs%2F1.Semester%2F13_Datenbanksystem_Installation%2FSample_databases)

---
**Version** *20240812v3*