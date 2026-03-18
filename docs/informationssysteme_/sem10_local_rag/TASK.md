# Informationssysteme "Local RAG"

## Einführung
Bei dieser Übung soll eine lokale Vector-Datenbank mit embedded Modellen aufgebaut werden. Dies soll als Basis für lokale Anfragen dienen.

## Ziele
Das Ziel dieser Übung ist das Bereitstellen einer lokalen Webanwendung, die private Dokumente aus einer Vektordatenbank verwendet, um auf privaten Daten hin die Halluzination zu vermindern. Kurz gesagt, soll das Google NotebookLM auf dem lokalen Rechner nachempfunden werden.

## Voraussetzungen
+ Docker Compose
+ Grundkenntnisse über Large-Language-Modelle
+ Verwendung von Ollama

## Detailierte Aufgabenstellung
NotebookLM von Google ist ein KI-gestütztes Recherche- und Notizwerkzeug, mit dem du deine eigenen Quellen hochlädst und dann gezielt damit arbeiten kannst. Es dient als Recherche‑Assistent, der sich nur auf deine hochgeladenen Dokumente und Links stützt (keine freie Websuche), um Halluzinationen zu reduzieren. Du kannst große Mengen Material (z.B. Papers, Reports, Vorlesungsfolien) strukturieren, zusammenfassen und in einem „Notebook“ organisieren. Du stellst Fragen im Chat und bekommst Antworten mit Quellenangaben, die direkt auf deine Dateien verweisen.

Dieses Tool verlangt jedoch den Zugriff auf persönliche Dokumente. Dies soll mit einem lokalen Retrieval-Augmented Generation (RAG) System nachempfunden werden. Dabei soll ein embedded Modell herangezogen werden, das private Dateien vektorisiert und für lokale Abfragen vorbereitet. 

### Grundlegende Kompetenzen
Es soll ein modularisiertes Projekt erstellt werden, welches die einzelnen Aufgaben in eigenen Modulen erfüllt (z.B. rag-core, rag-dashboard, rag-indexer-service, rag-mcp-server, rag-query-service). Als Vorschlag hierfür wäre die Spring-Boot Version 3.5.11 mit der Spring-AI in Version 1.1.1

Die lokale LLM-Umgebung soll über einen Ollama Docker Container gelöst werden, der die Modelle *llama3.2* und z.B. *nomic-embed-text* zur Verfügung stellen soll.

Das Modul zur Indizierung soll drei bis zehn PDF-Dokumente mit durchschnittlich 20 und mindestens eines mit mehr als 500 Seiten vektorisieren. Zu beachten ist, dass die Vektordatenbank auch Metadaten aufnehmen soll, damit der lokale Chat auch auf die PDF-Dokumente und die referenzierten Seiten hinweisen kann. Als Vektordatenbank wird das `pgvector` Modul der Postgres-DB empfohlen. Bitte hier ebenso einen Container aufsetzen. Eine Web-GUI zur Übersicht der Tabellen und Daten ist empfehlenswert (z.B. Adminer).

### Erweiterte Kompetenzen

## Abgabe
Im Repository soll das `README.md` die notwendigen Schritte beschreiben. Auch das kombinierte `docker-compose.yml` soll enthalten sein. Bitte die Binaries und Class-Files in das `.gitignore` eintragen, sodass keine irrtümliche Abgabe erfolgt (besonders das `node-modules` Verzeichnis). Die Source-Code Files sollen getrennt abgelegt werden. Jegliche Änderungen müssen im `CHANGELOG.md` dokumentiert werden.

Bei der Verwendung von KI-Tools müssen die Chat-Prompts im Verzeichnis `prompts/` als Markdown-Files exportiert werden (Anfrage+Antowrt, ungekürzt). Hier soll darauf geachtet werden, dass die Anfrage als auch die Quellen der Antworten ersichtlich sind. Bei der Verwendung von KI-Coding Agents sind die Befehle zu loggen und im `prompts/Agent-NACHNAME.md` zu speichern.

### Classroom Repository
[Hier](https://classroom.github.com/a/U1K58Vlo) finden Sie das Abgabe-Repository zum Entwickeln und Commiten Ihrer Lösung.

## Help, oh I need somebody

## Bewertung
Gruppengrösse: 3-4 Personen
### Grundanforderungen überwiegend erfüllt
- [ ] Aufsetzen von modularisiertem Projekt
- [ ] Indizierung von PDFs und Erstellung einer Vector-DB
- [ ] Query-Service für Anfragen

### Grundanforderungen zur Gänze erfüllt
- [ ] Web-GUI für Chat mit lokalem Modell
- [ ] Erstellung von Metadaten zur Anzeige der Quellen
- [ ] Optimierung von Chunk-Größe und Indizierungszeit

### Erweiterte Anforderungen überwiegend erfüllt

### Erweiterte Anforderungen zur Gänze erfüllt

## Quellen
* [NotebookLM](https://workspace.google.com/products/notebooklm)

---
**Version** *20260318v2*
