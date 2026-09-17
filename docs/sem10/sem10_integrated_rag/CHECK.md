### Repository-Name: []() 

### Bewertung
Gruppengrösse: 3-4 Personen
#### Erweiterung überwiegend erfüllt
- [ ] Codebasis wird zusätzlich zu PDFs indexiert
    * `CodeIndexService` liest rekursiv Quelldateien ein (Dateitypen: java, py, ts, js, vue, yml, yaml, xml, sql, md, html, css, json, etc.)
    * Build-Artefakte (.git, node_modules, target, build, dist, etc.) werden beim Einlesen übersprungen
    * Re-Indizierung unterstützt: alte Chunks/Vektoren werden vor Neuindizierung automatisch gelöscht
    * `CodeIndexController` stellt `POST /api/index/code/directory` und `DELETE /api/index/code/directory` bereit
- [ ] Metadaten für Codequellen sind vorhanden
    * Jeder Code-Chunk speichert: `source`, `source_type` (CODE), `file_path` (relativer Pfad), `language`, `chunk_index`, `document_id`
    * Verknüpfung über `VectorStoreDocumentChunk`-Tabelle mit `DocumentMetadata`-Eintrag
    * `DocumentMetadata`-Entität wurde um `source_type` und `language` erweitert
- [ ] Online-LLM kann optional verwendet werden
    * `OnlineLlmChatService` implementiert das `ChatService`-Interface (OpenAI-kompatibler Endpunkt)
    * Auswahl erfolgt über das Feld `provider` im `ChatRequest` ("ollama" oder "online")
    * Konfiguration in `application.yml`: api-key, base-url, model, max-context-chars; standardmäßig deaktiviert
- [ ] Eine API für OpenCode ist definiert
    * `OpenCodeController` stellt folgende Endpunkte bereit: `/api/search`, `/api/context`
    * Mögliche feinere Gliederung der Endpunkte möglich

#### Erweiterung zur Gänze erfüllt
- [ ] Code- und PDF-Retrieval sind sinnvoll kombiniert
    * `RetrievalService` führt Suche über beide Wissensräume durch und wendet Source-Diversity-Filterung an (max. 2 Chunks pro Quelle)
    * Filter über `source_type`-Metadatenfeld in der Vektordatenbank
- [ ] Antworten enthalten nachvollziehbare Quellen aus beiden Wissensräumen
    * `SourceReference`enthält: `source`, `page`, `score`, `content`, `sourceType` (PDF/CODE), `filePath`
    * `OpenCodeSearchResult`ergänzt zusätzlich `language`
    * Chat-Antworten (`ChatResponse`) liefern eine Liste von `SourceReference`-Objekten
    * Dashboard zeigt Quellen mit Dateiname, Seite bzw. Pfad an
- [ ] Datenschutz bei Online-LLM-Nutzung ist technisch berücksichtigt
    * `ContextSanitizer` redigiert sensible Muster vor jeder externen Übertragung:
        - API-Keys, Bearer-Tokens, Passwörter, JDBC-URLs, RSA-Private-Keys, AWS-Keys (AKIA/ASIA)
        - interne IP-Bereiche (192.168.x, 10.x, 172.16–31.x), Localhost-URLs
    * Alle Redigierungen werden geloggt (Auditierbarkeit)
    * Nur abgerufene Chunks werden übertragen, nie die gesamte Codebasis oder Dokumentensammlung
    * Kontextlänge auf `max-context-chars` (Standard: 4000 Zeichen) begrenzt
- [ ] OpenCode kann strukturierte Kontextdaten über die API abrufen
    * Antworten sind JSON-Strukturen (`OpenCodeSearchResponse`, `OpenCodeContextResponse`)
    * Keine unstrukturierten Freitextblöcke; interne Datenbankdetails werden nicht exponiert
    * `topK`-Parameter ermöglicht kontrollierte Ergebnismenge pro Anfrage
- [ ] Bekannte Fehlerquellen wurden dokumentiert und adressiert
    * Zu große Chunks: behoben durch zweistufiges Chunking (Blank-Line-Split → Line-Split als Fallback, 500 Zeichen, 80 Zeichen Overlap)
    * Fehlende Metadaten: adressiert durch vollständige Metadatenspeicherung (`file_path`, `language`, `chunk_index`)
    * Veraltete Embeddings: behoben durch Re-Indizierungs-Logik mit automatischer Vorab-Löschung
    * Quellen-Dominanz einzelner Dateien: adressiert durch Source-Diversity-Filterung (max. 2 Chunks/Quelle)
    * Datenleck an Online-LLMs: adressiert durch `ContextSanitizer` und Beschränkung auf Retrieved Chunks
    * Strukturierte API-Antworten
    * Dokumentation der Fehlerquellen und Gegenmaßnahmen im `README.md`


### Kommentare zur Erweiterung
* Wenn Gruppengröße definiert ist, bitte daran halten (2!=3)
* Kein `prompts/`-Verzeichnis vorhanden – Prompts (inkl. vollständiger Antworten) **aller** Gruppenmitglieder müssen als Markdown-Dateien in `prompts/` abgelegt sein; `PROMPTS.md` im Root-Verzeichnis genügt nicht
* Bei Verwendung von KI-Coding-Agents sind die Befehle in `prompts/Agent-NACHNAME.md` zu loggen
* Generierte Abgaben ohne vollständige Prompts werden nicht bewertet – Prüfungsgespräch vorbereiten!
* Zugriff auf Web-Dashboard nicht beschrieben/möglich
* Änderungen in `CHANGELOG.md` dokumentieren
* Commit Messages verbesserungswürdig
* Commits nicht gleichverteilt auf alle Gruppenmitglieder
* Kommandos in `README.md` entsprechend formatieren
* Quellen bei der Ausarbeitung fehlen bzw. sind nicht nach IEEE-Standard referenziert (z.B. [1] [Titel; Author; Ort; zuletzt abgerufen am 2019-04-09; online](http://link))
* Symbolische Position im Code (Zeilennummer) wird nicht als Metadatum gespeichert – nur `chunk_index`

