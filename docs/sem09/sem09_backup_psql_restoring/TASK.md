# Informationssysteme "Backup and Restore"

## Einführung
Bei dieser Übung soll ein erstelltes Backup in eine Container-basierte Umgebung eingepflegt werden.

## Ziele
Das Ziel dieser Übung ist das Wiederherstellen einer gesicherten Datenbasis für Postgresql in der verwendeten Version. Dabei sind die Verwendung von Docker Compose und Postgresql vorausgesetzt. Es wird die Konfiguration und Verwendung von CLI-Tools trainiert.

## Voraussetzungen
+ Docker Compose
+ Kenntnisse über Shell-Kommandos

## Detailierte Aufgabenstellung
Es ist das Datenbank-Backup-Archiv herunterzuladen und in einen Postgres-Container zu deployen. Es ist eine geeignete Version des Postgres Images zu wählen. Die Zugriffsbeschränkung soll auf das genannte Passwort entsprechend gesetzt werden. Zugangscredentials sollten nicht global lesbar sein, hier soll eine geeignte Möglichkeit gewählt werden (z.B. Environment File).

Die Entpackten DB-Files sollen geeignet in den Container eingebunden werden. Auch die Konfigurationen der Container soll nach einem Update erhalten bleiben. Nach Durchsicht der `restore.sql` und dessen Anpassung, soll die Datenbank und der Namespace kurz beschrieben werden. Welche Befehle sind dabei für eine idempotente Ausführung einer neuerlichen Widerherstellung nützlich?

Um einen einfachen Zugriff zu ermöglichen, soll der Adminer als zusätzlicher Container definiert werden. Welche Netzwerk-Informationen sind dafür notwendig? Wie können das Schema und die Datenbank über den Adminer ausgewählt und verwendet werden?

Es soll die Datenbankstruktur und die Daten analysiert werden. Welche Bedeutung haben die Tabellen, Attribute und deren Relationen? Welche Auswirkungen haben die Funktionen?

## Abgabe
Im Repository soll das `README.md` die notwendigen Schritte beschreiben und eine kurze Auflistung der eingesetzten Kommandos, sowie die Verlinkung zu deren Beschreibungen. Auch das verwendete `docker-compose.yml` soll enthalten sein. Bitte das Datenbank-Backup-File und die entpackten Dateien in das `.gitignore` eintragen, sodass keine irrtümliche Abgabe erfolgt. In der `RESEARCH.md`sollen die Gedanken und Analysen zur Datenbankstruktur festgehalten werden.

Bei der Verwendung von KI-Tools müssen die Prompts im Verzeichnis `prompts/` als Markdown-Files für jedes einzelne Gruppenmitglied und verwendete Tool exportiert werden. Hier soll darauf geachtet werden, dass die Anfrage als auch die Quellen der Antworten ersichtlich sind. Die Ergebnisse sind in der Abgabe ersichtlich und müssen nicht exportiert werden. Die Historie und Verbesserung der Prompts fließt in die Bewertung der Übung ein.

## Mitarbeit
Um eine kontinuierliche Mitarbeit unter Beweis stellen zu können, sind sämtliche Schritte sowie erfahrene Probleme und Einsichten mit einer kurze Erläuterung (Stichworte sind ausreichend) auf einem DIN-A4 Blatt zu protokollieren. Zu Beginn des Protokolls sind Name, Jahrgang, Gruppe/Nummer (github-Repository), Aufgabenbezeichnung und Datum festzuhalten. Das Protokoll ist der Lehrkraft bei der Übungsdurchführung zu jeder Zeit sofort vorzuzeigen. Am Ende der Übung ist dieses abzugeben bzw. sofort von der Lehrkraft zu bewerten, um die Teilnahme am Übungsquiz zu ermöglichen. Nach der Digitalisierung durch die Lehrperson ist eine Rückgabe möglich und auch erwünscht.

## Help, oh I need somebody
### Network is already in use
Wenn das Netzwerk schon in Verwendung ist, hilft dieser Befehl in der Shell:
```bash
docker ps -q | xargs -n 1 docker inspect --format '{{ .Name }} {{range .NetworkSettings.Networks}} {{.IPAddress}}{{end}}' | sed 's#^/##';
```
Oder unter Windows in der Commandline:
```sh
for /f "tokens=*" %i in ('docker network ls -q') do @docker network inspect %i --format "{{.Name}}: {{range .IPAM.Config}}{{.Subnet}}{{end}}"
```

### How to set a network
Im Compose File kann ein eigenes Netzwerk definiert und dann auch den Containern zugeordnet werden kann:
```yaml

services:
  venlab-db:
    (...)
    networks:
      venlab-internal:
        ipv4_address: '172.17.2.10'

networks:
  venlab-internal:
    labels:
      com.docker.compose.network: "venlab-internal"
    driver_opts:
      com.docker.network.bridge.name: "br-venlab-int"
    internal: true
    ipam:
      driver: default
      config:
        - subnet: "172.17.2.0/24"
```

### Classroom Repository
[Hier](https://classroom50.org/TGM-HIT/insy5x-2627/assignments/sem09-backup-and-restore/accept?k=dragon8tract6sample5frail) finden Sie das Abgabe-Repository zum Entwickeln und Commiten Ihrer Lösung.

## Bewertung
Gruppengrösse: 2 Personen
### Grundanforderungen überwiegend erfüllt
- [ ] Analyse des bestehenden Backups
- [ ] Erstellung und Deployment von Docker Container
- [ ] Einbindung der DB-Backupfiles mittels Volumes und Anpassung von `restore.sql`

### Grundanforderungen zur Gänze erfüllt
- [ ] Zugriffskonfiguration
- [ ] Ausführung des Recovery
- [ ] Zugriff auf wiederhergestellte Datenbasis über Adminer

## Quellen
* [Database Backup File](https://nextcloud.borko.at/s/MDKrDHdedLKELCS)
* [Difference between MariaDB and Postgresql](https://aws.amazon.com/compare/the-difference-between-mariadb-and-postgresql/)
* [Postgresql Documentation 'INSERT'](https://www.postgresql.org/docs/current/sql-insert.html)
* [MariaDB Documentation 'INSERT'](https://mariadb.com/docs/server/reference/sql-statements/data-manipulation/inserting-loading-data/insert)
* [Official Docker Image of Postgres](https://hub.docker.com/_/postgres)
* [Official Docker Image of Adminer](https://hub.docker.com/_/adminer/)

---
**Version** *20260929v4*
