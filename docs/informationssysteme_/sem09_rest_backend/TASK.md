# Informationssysteme "ReST Backend"

## Einführung
Bei dieser Übung sollen für eine bestehende Datenbank mittels einer ReST-API die CRUD Funktionen implementiert werden.

## Ziele
Das Ziel dieser Übung ist das Bereitstellen einer grundlegenden Datenmanipulation über eine ReST-API. Dabei sollen Werkzeuge zum Einsatz kommen, die das leichte Umsetzen und Bereitstellen beschleunigen. Die Schnittstelle soll für eine grafische Oberfläche angedacht werden, auch besondere Funktionen (Business Use Cases) werden in Zukunft umgesetzt.

## Voraussetzungen
+ Docker Compose
+ Kenntnisse über Shell-Kommandos
+ Funktionstüchtiger Restore der Datenbank aus "Backup - Restoring postgres Database"
+ ORM Kenntnisse
+ Grundlagen über ReST-API

## Detailierte Aufgabenstellung
Die funktionstüchtige Datenbank aus dem Backup-Beispiel soll als Quelle für eine CRUD-Backend-Implementierung herangezogen werden. Die Datenbank-Implementierung soll ins neue `docker-compose.yml` übernommen werden. Als Backend-Implementierung soll eine leicht erweiterbare und wartbare Lösung gewählt werden. Die ReST-API der CRUD Befehle soll auch als Dokumentation erstellt werden und im System eingebunden sein.

## Abgabe
Im Repository soll das `README.md` die notwendigen Schritte beschreiben und einen Export der implementierten ReST-API (OpenAPI) in einem Markdown enthalten. Auch das verwendete `docker-compose.yml` soll enthalten sein. Bitte alle Binaries und Class-Files in das `.gitignore` eintragen, sodass keine irrtümliche Abgabe erfolgt. Die Source-Code Files, sprich die Implementierung soll im Verzeichnis `backend/` abgelegt werden.

Bei der Verwendung von KI-Tools müssen die Prompts im Verzeichnis `prompts/` als Markdown-Files exportiert werden. Hier soll darauf geachtet werden, dass die Anfrage als auch die Quellen der Antworten ersichtlich sind.

## Help, oh I need somebody
### What should I use for a JAR?
Um ein Docker-Image für die Ausführung einer Java-Applikation zu definieren, kann folgendes Dockerfile als Beispiel herangezogen werden:
```sh
FROM amazoncorretto:25-alpine-jdk
LABEL version="1.0"
RUN apk add --no-cache tzdata fontconfig freetype font-noto ttf-liberation busybox-extras curl
ENV TZ=Europe/Vienna
ENTRYPOINT ["java","-Xms1024M","-Xmx2048M","-jar","/jar/backend.jar"]
```

### Network is already in use
Wenn das Netzwerk schon in Verwendung ist, hilft dieser Befehl in der Shell:
```bash
docker ps -q | xargs -n 1 docker inspect --format '{{ .Name }} {{range .NetworkSettings.Networks}} {{.IPAddress}}{{end}}' | sed 's#^/##';
```
Oder unter Windows in der Commandline:
```sh
for /f "tokens=*" %i in ('docker network ls -q') do @docker network inspect %i --format "{{.Name}}: {{range .IPAM.Config}}{{.Subnet}}{{end}}"
```

### Classroom Repository
[Hier](https://classroom.github.com/a/3oEvnmk5) finden Sie das Abgabe-Repository zum Entwickeln und Commiten Ihrer Lösung.

## Bewertung
Gruppengrösse: 2-3 Personen
### Grundanforderungen überwiegend erfüllt
- [ ] CRUD-ReST-API für die Tabelle Analysis erstellt
- [ ] Deployment von Backend-Implementierung ist lauffähig
- [ ] Tabellen Sample, Box, BoxPos und Log sind teilweise umgesetzt 

### Grundanforderungen zur Gänze erfüllt
- [ ] OpenAPI Dokumentation ist für alle implementierten Endpunkte generiert
- [ ] Alle Datenbank-Tabellen sind über die ReST Schnittstelle lesbar erreichbar

## Quellen
* [Building REST services with Spring](https://spring.io/guides/tutorials/rest)
* [OpenAPI Specification - Swagger](https://swagger.io/resources/open-api/)
* [JPA Buddy](https://www.jetbrains.com/help/idea/jpa-buddy.html)
* [API-First Development | Build Spring Boot Application With Swagger Codegen and JPA Buddy](https://jpa-buddy.com/guides/api-first-development-build-spring-boot-application/)

---
**Version** *20251007v2*
