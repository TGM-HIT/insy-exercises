# Informationssysteme "Backup - Restoring postgres Database"

## Einführung
Bei dieser Übung soll ein erstelltes Backup in eine Container-basierte Umgebung eingepflegt werden.

## Ziele
Das Ziel dieser Übung ist das Wiederherstellen einer gesicherten Datenbasis für Postgresql. Dabei sind die Verwendung von Docker Compose und Postgresql vorausgesetzt. Es wird die Konfiguration und Verwendung von CLI-Tools trainiert.

## Voraussetzungen
+ Docker Compose
+ Kenntnisse über Shell-Kommandos

## Detailierte Aufgabenstellung
Es ist das Datenbank-Backup-Archiv herunterzuladen und in einen Postgres-Container zu deployen. Es ist eine geeignete Version des Postgres Images zu wählen. Die Zugriffsbeschränkung soll auf das genannte Passwort entsprechend gesetzt werden. Zugangscredentials sollten nicht global lesbar sein, hier soll eine geeignte Möglichkeit gewählt werden (z.B. Environment File).

Die Entpackten DB-Files sollen geeignet in den Container eingebunden werden. Nach Durchsicht der `restore.sql` und dessen Anpassung, soll die Datenbank und der Namespace kurz beschrieben werden. Welche Befehle sind dabei für eine idempotente Ausführung nützlich?

Um einen einfachen Zugriff zu ermöglichen, soll der Adminer als zusätzlicher Container definiert werden. Welche Netzwerk-Informationen sind dafür notwendig? Wie können das Schema und die Datenbank über den Adminer ausgewählt und verwendet werden? Es soll die Datenbankstruktur und die Daten kurz analysiert werden.

## Abgabe
Im Repository soll das `README.md` die notwendigen Schritte beschreiben und eine kurze Beschreibung der wiederhergestellten Datenbank enthalten. Auch das verwendete `docker-compose.yml` soll enthalten sein. Bitte das Datenbank-Backup-File und die entpackten Dateien in das `.gitignore` eintragen, sodass keine irrtümliche Abgabe erfolgt.

## Help, oh I need somebody
### Network is already in use
Wenn das Netzwerk schon in Verwendung ist, hilft dieser Command:
`docker ps -q | xargs -n 1 docker inspect --format '{{ .Name }} {{range .NetworkSettings.Networks}} {{.IPAddress}}{{end}}' | sed 's#^/##';`

### Classroom Repository
[Hier](https://classroom.github.com/a/356savRb) finden Sie das Abgabe-Repository zum Entwickeln und Commiten Ihrer Lösung.

## Bewertung
Gruppengrösse: 2 Personen
### Grundanforderungen überwiegend erfüllt
- [ ] Analyse des bestehenden Backups
- [ ] Erstellung und Deployment von Docker Container
- [ ] Einbindung der DB-Backupfiles und Anpassung von `restore.sql`

### Grundanforderungen zur Gänze erfüllt
- [ ] Zugriffskonfiguration
- [ ] Ausführung des Recovery
- [ ] Zugriff auf wiederhergestellte Datenbasis über Adminer

## Quellen
* [Database Backup File](https://nextcloud.borko.at/s/iQteczRt47mBWd2)
* [Difference between MariaDB and Postgresql](https://aws.amazon.com/compare/the-difference-between-mariadb-and-postgresql/)
* [Postgresql Documentation 'INSERT'](https://www.postgresql.org/docs/current/sql-insert.html)
* [MariaDB Documentation 'INSERT'](https://mariadb.com/docs/server/reference/sql-statements/data-manipulation/inserting-loading-data/insert)
* [Adminer](https://hub.docker.com/_/adminer/)

---
**Version** *20251001v3*
