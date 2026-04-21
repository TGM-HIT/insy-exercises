### Repository-Name: []() 

### Bewertung
Gruppengrösse: 3-4 Personen
#### Grundanforderungen überwiegend erfüllt
- [ ] Aufsetzen von modularisiertem Projekt
    * Erstellung der geforderten Module (z.B. rag-core, rag-dashboard, rag-indexer-service)
    * Bereitstellung der lokalen Umgebung (Ollama, pgvector) über eine docker-compose.yml
    * Korrekte Konfiguration des Frameworks (z.B. Spring Boot mit Spring AI).
- [ ] Indizierung von PDFs und Erstellung einer Vector-DB
    * Einlesen und Verarbeiten von 3 bis 10 PDF-Dokumenten (mindestens eines mit >500 Seiten)
    * Vektorisierung der Textinhalte mit einem Embedding-Modell (z.B. nomic-embed-text)
    * Erfolgreiche Speicherung der Vektoren in der Datenbank (Tabelle vector_store)
- [ ] Query-Service für Anfragen
    * Implementierung eines austauschbaren ChatControllers
    * Anbindung an das lokale LLM (z.B. llama3.2) über Ollama
    * Erfolgreiche Beantwortung von Testanfragen basierend auf den indizierten Dokumenten

#### Grundanforderungen zur Gänze erfüllt
- [ ] Web-GUI für Chat mit lokalem Modell
    * Bereitstellung einer Weboberfläche (Dashboard) für die Benutzereingabe
    * Darstellung des Chatverlaufs (Frage des Nutzers und Antwort des Modells)
- [ ] Erstellung von Metadaten zur Anzeige der Quellen
    * Befüllen der Tabellen document_metadata und vector_store_document_chunk beim Indizieren
    * Auslesen und übersichtliche Anzeige der verwendeten Quellen (Dateiname, Seite) in der Chat-GUI
- [ ] Optimierung von Chunk-Größe und Indizierungszeit
    * Anpassung und Dokumentation der gewählten Chunk-Größen
    * Setzen der notwendigen Datenbank-Indizes zur Beschleunigung der Abfragen
    * Sinnvolle Konfiguration der Embedding-Parameter (z.B. Dimensionen, num-ctx)

#### Erweiterte Anforderungen überwiegend erfüllt
- [ ] ein weiteres Modell vektorisieren
    * Austausch des Embedding-Modells (z.B. mxbai-embed-large-v1) oder des LLMs (z.B. DeepSeek, Mistral)
    * Anpassung der Applikationskonfiguration an das neue Modell
- [ ] Benchmark zu Vektoren, Datenmenge, Geschwindigkeit, Last und Response
    * Messung der Indizierungsdauer und Speichergröße bei unterschiedlichen Modellen/Datenmengen
    * Messung der Antwortzeiten (Response Time) und Systemlast bei Chat-Anfragen
    * Dokumentation der Ergebnisse und Erkenntnisse

#### Erweiterte Anforderungen zur Gänze erfüllt
- [ ] eine weitere Vektordatenbank verwenden
    * Integration einer alternativen Vektordatenbank (z.B. Qdrant) in das Projekt
    * Anpassung der Services, sodass zwischen den Datenbanken gewechselt werden kann
- [ ] Benchmarking (aus der EKü mit Vergleich der beiden VektorDBs)
    * Erweiterung der Benchmarks um den direkten Vergleich zwischen pgvector und der neuen Datenbank (z.B. Qdrant)
    * Gegenüberstellung der Auswirkungen auf Erstellungszeit und Abfragegeschwindigkeit
- [ ] Integration der Verwaltung der Dokumente in der GUI (Vorschlag mit Documentstore, z.B. MinIO)
    * Implementierung einer Upload-Funktion für neue PDF-Dokumente über das Dashboard
    * Übersichtliche Darstellung der bereits indizierten Dokumente in der GUI
    * Optionale Anbindung eines Documentstores (z.B. MinIO) zur physischen Ablage der Dateien


### Kommentare zu Grundkompetenzen
* Wenn Gruppengröße definiert ist, bitte daran halten (2!=3)
* Zugriff auf Web-Dashboard nicht beschrieben/möglich
* Änderungen in `CHANGELOG.md` dokumentieren
* Commit Messages verbesserungswürdig
* Commits nicht gleichverteilt auf alle Gruppenmitglieder
* Kommandos in `README.md` entsprechend formatieren
* Arbeitsschritte nicht ausreichend dokumentiert
* Bitte keine kompletten Listings der enthaltenen Dateien in der README einbetten, nur wichtige Auszüge verwenden
* Quellen bei der Ausarbeitung fehlen bzw. sind nicht nach IEEE-Standard referenziert (z.B. [1] [Titel; Author; Ort; zuletzt abgerufen am 2019-04-09; online](http://link)
* Prompts (und deren vollständigen Ergebnisse) sind von **allen** Gruppenmitgliedern in einem Verzeichnis als Markdown-Dateien abzugeben
* Generierte Abgaben ohne Prompts werden von mir nicht mehr bewertet! Bereiten Sie sich auf ein Prüfungsgespräch vor!

