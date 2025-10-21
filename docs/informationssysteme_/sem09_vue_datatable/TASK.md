# Informationssysteme "Vue Datatable"

## Einführung
Bei dieser Übung sollen für eine bestehende ReST-Schnittstelle mithilfe eines JS-Frameworks die CRUD Funktionen auf Data-Tables implementiert werden.

## Ziele
Das Ziel dieser Übung ist das Bereitstellen einer grundlegenden Datenmanipulation über eine JS-View. Dabei sollen Werkzeuge zum Einsatz kommen, die das leichte Umsetzen und Bereitstellen beschleunigen. Die grafische Oberfläche soll die bestehenden Resourcen sinnvoll nutzen, und für besondere Funktionen (Business Use Cases) erweiterbar sein.

## Voraussetzungen
+ Docker Compose
+ Kenntnisse über Javascript
+ Funktionstüchtige ReST Schnittstelle aus "ReST Backend"
+ Grundlagen über ReST-API

## Detailierte Aufgabenstellung
Die funktionstüchtige ReST-API aus dem Backend-Beispiel soll als Quelle für eine CRUD-JS-Implementierung herangezogen werden. Die Datenbank-Implementierung sowie die ReST-API soll ins neue `docker-compose.yml` übernommen werden. Als Javascript-Implementierung soll eine leicht erweiterbare und wartbare Lösung gewählt werden.

## Abgabe
Im Repository soll das `README.md` die notwendigen Schritte beschreiben. Auch das verwendete `docker-compose.yml` soll enthalten sein. Bitte alle Binaries und Class-Files in das `.gitignore` eintragen, sodass keine irrtümliche Abgabe erfolgt (besonders das `node-modules` Verzeichnis). Die Source-Code Files, sprich die Implementierung soll im Verzeichnis `frontend/` abgelegt werden.

Bei der Verwendung von KI-Tools müssen die Prompts im Verzeichnis `prompts/` als Markdown-Files exportiert werden. Hier soll darauf geachtet werden, dass die Anfrage als auch die Quellen der Antworten ersichtlich sind.

## Help, oh I need somebody
### What should I use for a Container?
Um einen Container für die Ausführung einer VueJS-Applikation zu definieren, kann folgendes Service als Beispiel herangezogen werden:
```yaml
services:
  frontend:
    image: nginx:stable-alpine
    container_name: frontend
    restart: always
    depends_on:
      - backend
    volumes:
      - './webfrontend:/usr/share/nginx/html'
    ports:
      - '80:80'
    networks:
      world:
      internal:
        ipv4_address: '172.19.2.12'
    environment:
      TZ: Europe/Vienna
```

### Classroom Repository
[Hier](https://classroom.github.com/a/Ul2A_rOk) finden Sie das Abgabe-Repository zum Entwickeln und Commiten Ihrer Lösung.

## Bewertung
Gruppengrösse: 2 Personen
### Grundanforderungen überwiegend erfüllt
- [ ] Datatable für die Tabelle Analysis erstellt
- [ ] Deployment von Frontend-Implementierung ist lauffähig
- [ ] Tabellen Sample, Box, BoxPos und Log sind als Axios Klassen vorgesehen

### Grundanforderungen zur Gänze erfüllt
- [ ] OpenAPI Dokumentation ist für alle implementierten Endpunkte generiert
- [ ] Alle Datenbank-Tabellen sind über die Vue App lesbar erreichbar

## Quellen
* [Vuetify Documentation](https://vuetifyjs.com/en/)
* [Vuetify Basic Data Tables](https://vuetifyjs.com/en/components/data-tables/basics/#usage)
* [Vue.js Documentation](https://vuejs.org/)
* [Axios Documentation](https://axios-http.com/docs)
* [Vue CLI Documentation](https://cli.vuejs.org/)
* ["Vue 3 + Vuetify + Axios" Example](https://github.com/mborko/code-examples/tree/master/js/v-data-table)

---
**Version** *20251021v1*
