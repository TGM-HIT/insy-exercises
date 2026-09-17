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

Das Query-Service soll den ChatController implementieren, der in Zukunft austauschbar sein soll. Dieser wird von dem Dashboard verwendet, um die Anfrage der Benutzer an das lokale System zu stellen. Das Dashboard ist eine Web-GUI, die eine Chateingabe verarbeitet, die Ausgabe und die Quellen ausgibt.

Um die verwendeten Dokumente referenzieren zu können, müssen beim Vektorisieren der Inhalte auch die Metadaten gespeichert werden. Dabei sollen folgende Attribute aufgenommen werden:

```sql
CREATE TABLE IF NOT EXISTS public.document_metadata (
  id BIGSERIAL PRIMARY KEY,
  file_name TEXT,
  source_path TEXT,
  pdf_title TEXT,
  pdf_author TEXT,
  pdf_subject TEXT,
  pdf_keywords TEXT,
  creation_ts TIMESTAMPTZ,
  modification_ts TIMESTAMPTZ,
  total_pages INT
);

CREATE TABLE public.vector_store (
  id TEXT PRIMARY KEY,
  content TEXT,
  metadata JSONB,
  embedding vector(768) NOT NULL
);

CREATE TABLE public.vector_store_document_chunk (
  vector_id TEXT NOT NULL REFERENCES public.vector_store(id) ON DELETE CASCADE,
  document_id BIGINT NOT NULL REFERENCES public.document_metadata(id) ON DELETE CASCADE,
  chunk_index INT,
  page_number INT,
  total_chunks INT,
  PRIMARY KEY (vector_id, document_id)
);
```
Es sind die notwendigen Indizes hier nicht angeführt. Bitte diese entsprechend zu setzen!

Ein wichtiger Teil der Übung ist die Optimierung der Dimension und der Chunk-Größe. Ein Vorschlag für die Applikations Konfiguration wird hier gegeben:

```yml
  ai:
    vectorstore:
      pgvector:
        table-name: vector_store
        dimensions: 768
    ollama:
      base-url: http://localhost:11434
      chat:
        options:
          model: llama3.2
      embedding:
        options:
          model: nomic-embed-text
          num-ctx: 8192
```

### Erweiterte Kompetenzen
Als erste erweiterte Aufgaben sollen verschiedene Modelle miteinander verglichen werden. Als Verlgeich kann zum Beispiel *mxbai-embed-large-v1* herangezogen werden. Auch *llama3.2* kann durch DeepSeek oder Mistral ersetzt werden. Es soll auf jeden Fall der Unterschied festgehalten werden, welcher durch einen Benchmark verglichen werden soll. Dabei ist die Datenmenge, Last und die Response essentiell.

Eine zusätzliche Erweiterung ist die Verwendung von einer anderen Vektordatenbank (z.B. Qdrant). Welche Auswirkungen hat dies auf die Erstellung und Abfrage? Das Benchmark soll dahingehend erweitert werden.

Die Verwaltung der persönlichen Dokumente ist bislang nich weiter beachtet worden. Hier soll nun die Verwaltung der Dokumente über die GUI möglich sein. Auch ein leichtes Hinzufügen von Dokumenten soll ermöglicht werden.

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
- [ ] ein weiteres Modell vektorisieren
- [ ] Benchmark zu Vektoren, Datenmenge, Geschwindigkeit, Last und Response

### Erweiterte Anforderungen zur Gänze erfüllt
- [ ] eine weitere Vektordatenbank verwenden
- [ ] Benchmarking (aus der EKü mit Vergleich der beiden VektorDBs)
- [ ] Integration der Verwaltung der Dokumente in der GUI (Vorschlag mit Documentstore, z.B. MinIO)

## Quellen
* [NotebookLM](https://workspace.google.com/products/notebooklm)
* [SYT Theorie - Dezentrale Systeme](https://elearning.tgm.ac.at/course/view.php?id=199#coursecontentcollapse9)
* "Energy Efficiency across Programming Languages" [acm.org](https://dl.acm.org/doi/epdf/10.1145/3136014.3136031)

---
**Version** *20260325v3*
