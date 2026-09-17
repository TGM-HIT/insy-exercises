---
hide:
  - navigation
---

# EK17 InfluxDB

## Einführung

Neben relationalen Datanbanken exisiteren noch eine Vielzahl an anderen Systemen welche für bestimmte Anwendungen geeigneter sind. InfluxDB ist eine timeseries database, besonders geeignet für z.B. Sensorwerte mit Zeitstempel.

## Ziele

InfluxDB kennen lernen und eine sinnvolle monitoring Application mit Docker aufsetzten


## Kompetenzzuordnung

#### EK Datenmodelle

* Alternativen zu relationalen Datenmodellen

## Voraussetzungen

* Datenbanksystem mit Docker installieren

## Fragestellungen

Bitte versuche alle wichtigen Informationen kurz und prägnant als Dokumentation laut den Dokumentationsrichtlinien zu verschriftlichen.

### Grundlegend

* Was für eine Art von Datenbank ist InfluxDB?
* Für welche Anwendungen ist sie besonders geeinet?

TIPP: in den Quellen findest du die Antworten zu all diesen Fragen mit nur einem Klick.

## Detaillierte Aufgabenbeschreibung

Bearbeite folgende Aufgabenstellungen nachdem du die Fragestellungen beantwortet hast.

Erstelle dir eine System Dashboard über deine System Recourcen deines Rechners. Nutze dazu Telegraf [5,6,7] um deinen Rechner zu überwachen und die Daten an InfluxDB [1,3,5]. InfluxDB stellt auch eine praktische Weboberfläche zum erstellen von Dashboards zur Verfügung. Verwende für das Dashboard soll aber Grafana [2,4,6] verwendet werden.

Folgendes [Docker Projekt](https://github.com/dominikhoebert/docker-projects/tree/master/system-monitoring) kann dazu verwendet werden.

Erstelle ein Dashboard mit mindestens 3 Graphen.

Binde dann dieses [vorgefertigte Dashboard](https://grafana.com/grafana/dashboards/15650-telegraf-influxdb-2-0-flux/) ein.

## Fragestellungen

- Erkläre die verwendeten Services
- Welche Files wurden im Projekt zur Verfügung gestellt und wozu dienen sie?
- Welche Sicherheitstechnischen Schwachstellen hat das System jetzt, da die Dateien nicht verändert wurden?
- Wie sollten die Files verändert werden um das System abzusichern?
- Warum funktionieren manche Graphen im vorgefertigten Dashboard nicht?

## Abgabe
Die durchgeführten Tätigkeiten und gewünschten Elemente müssen in einer Dokumentation gemäß der Dokumentationsrichtlinien zusammengefasst werden. Die Fragestellungen sollen mit Quellen ebenfalls in diesem Dokument bearbeitet werden.

Bei einem Abgabegespräch sind die laufende Umgebung sowie kurze Kontrollfragen zwecks Verständnisüberprüfung notwendig. Vor diesem Gespräch ist die Dokumentation eingescannt als ein **PDF** File auf moodle abzugeben. (Microsoft Office Lens [Android](https://play.google.com/store/apps/details?id=com.microsoft.office.officelens&hl=de_AT&gl=US), [iPhone](https://apps.apple.com/at/app/microsoft-office-lens-pdf-scan/id975925059); Online PDF Editor [pdffiller](https://www.pdffiller.com/de/))

## Bewertung
Gruppengröße: 1 Person
### **überwiegend erfüllt**
- [ ] InfluxDB installiert und verwendbar
- [ ] Telegraf speichert Daten in InfluxDB
### **zur Gänze erfüllt**
- [ ] Ansprechendes Dashboard erstellt
- [ ] Vorgefertigtes Dashboard eingebunden
## Quellen
* "Microsoft Office Lens";  [Android](https://play.google.com/store/apps/details?id=com.microsoft.office.officelens&hl=de_AT&gl=US), [iPhone](https://apps.apple.com/at/app/microsoft-office-lens-pdf-scan/id975925059)

* "Online PDF Editor"; zuletzt besucht 2021-08-06; [pdffiller](https://www.pdffiller.com/de/)

[1] „Downloads“. https://portal.influxdata.com/downloads/ (zugegriffen 5. September 2023).  
[2] „grafana/grafana - Docker Image | Docker Hub“. https://hub.docker.com/r/grafana/grafana (zugegriffen 5. September 2023).  
[3] „influxdb - Official Image | Docker Hub“. https://hub.docker.com/_/influxdb/ (zugegriffen 5. September 2023).  
[4] „Run Grafana Docker image | Grafana documentation“, Grafana Labs. https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/ (zugegriffen 5. September 2023).  
[5] „Running InfluxDB 2.0 and Telegraf Using Docker | InfluxData“. https://www.influxdata.com/blog/running-influxdb-2-0-and-telegraf-using-docker/ (zugegriffen 5. September 2023).  
[6] „Setting up Grafana with InfluxDB for Server Monitoring | by James Ralph | Medium“. https://medium.com/@james.ralph8555/setting-up-grafana-with-influxdb-for-server-monitoring-7b16c1d0ba0c (zugegriffen 5. September 2023).  
[7] „telegraf - Official Image | Docker Hub“. https://hub.docker.com/_/telegraf (zugegriffen 5. September 2023).

---
**Version** *20240811v2*