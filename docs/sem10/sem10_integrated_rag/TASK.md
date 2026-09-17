# Informationssysteme "Integrated RAG"

## Einführung
Bei dieser Übung soll eine lokale Vector-Datenbank erweitert werden und eine integrierte RAG Umgebung geschaffen werden.

## Ziele
Auf Basis des bestehenden lokalen RAG-Systems, das bisher primär PDF-Dokumente verarbeitet, soll das Projekt um drei zentrale Fähigkeiten erweitert werden:

- Einbindung der **lokalen Codebasis** als zusätzliche Wissensquelle,
- kontrollierte Nutzung von **externen / online verfügbaren LLMs**,
- Bereitstellung einer **API-Schnittstelle für OpenCode**, damit lokale Coding-Workflows auf die aufbereitete Wissensbasis zugreifen können.

Ziel ist es, ein System zu entwickeln, das nicht nur private Dokumente, sondern auch den Quellcode eines Projekts semantisch erschließen kann und dieses Wissen sowohl lokalen als auch externen Modellen in kontrollierter Form zur Verfügung stellt. Die bestehende modulare Architektur des Local-RAG-Systems soll dabei erhalten und sinnvoll erweitert werden.

## Voraussetzungen
+ Docker Compose
+ Grundkenntnisse über Large-Language-Modelle
+ Verwendung von Ollama
+ Lokale Vector-Database

## Detailierte Aufgabenstellung

### Erweiterung um die Codebasis
Die semantische Suche des Systems soll anschließend sowohl auf PDF-Inhalte als auch auf Code-Inhalte zugreifen können. Dabei ist sicherzustellen, dass Antworten nachvollziehbar bleiben und weiterhin auf konkrete Quellen verweisen, also etwa auf ein PDF mit Seitenzahl oder auf eine Datei mit Pfad und symbolischer Position im Projekt.

### Nutzung von Online-LLMs

Das bestehende lokale Query-Service soll um eine zusätzliche Möglichkeit erweitert werden, Anfragen nicht nur an das lokale LLM, sondern optional auch an externe Online-LLMs weiterzuleiten. Diese Erweiterung muss so gestaltet sein, dass der ChatController bzw. die zentrale Query-Schnittstelle austauschbar bleibt und unterschiedliche Modellanbieter über eine einheitliche interne Architektur angesprochen werden können.

Dabei darf **nicht** die gesamte Dokumenten- oder Codebasis unkontrolliert an einen externen Dienst übertragen werden. Stattdessen soll das lokale System zuerst die relevanten Inhalte per Retrieval bestimmen und nur einen gezielt reduzierten, nachvollziehbaren Kontext an den Online-Dienst weitergeben. Die Studierenden sollen dafür ein geeignetes Kontextpaket definieren, das sowohl Quellenhinweise als auch Begrenzungen hinsichtlich Datenschutz, Umfang und Nachvollziehbarkeit berücksichtigt.

Zusätzlich soll dokumentiert werden, welche Unterschiede sich zwischen lokalem und externem Modell ergeben. Dabei können insbesondere Antwortqualität, Antwortzeit, Kosten, Abhängigkeit von Netzwerk und Datenschutzaspekte betrachtet werden. Diese Erweiterung knüpft an die bereits vorgesehene vergleichende Betrachtung unterschiedlicher Modelle an.

### API-Bereitstellung für OpenCode

Das System soll um eine klar definierte API erweitert werden, über die externe Werkzeuge – insbesondere **OpenCode** – auf die Wissensbasis zugreifen können. Diese API soll es ermöglichen, gezielt Informationen aus der Codebasis und aus den PDF-Dokumenten abzurufen, ohne dass OpenCode direkten Zugriff auf die Datenbankstruktur oder die internen Implementierungsdetails erhalten muss.

Die API soll mindestens folgende Fähigkeiten in geeigneter Form bereitstellen:

- Suche in den PDF-Quellen
- Suche in der Codebasis
- kombinierte Suche über beide Wissensräume
- Rückgabe strukturierter Kontextinformationen für Folgeabfragen oder Coding-Tasks
- nachvollziehbare Quellenangaben in den Antworten

Die Schnittstelle soll so gestaltet sein, dass sie in Zukunft leicht erweitert oder durch andere Werkzeuge verwendet werden kann. Eine saubere Trennung zwischen Dashboard, Query-Service und externer API ist dabei explizit notwendig, da die ursprüngliche Aufgabenstellung bereits eine modulare Struktur und austauschbare Komponenten vorsieht.

## Bekannte Fehlerquellen und zu berücksichtigende Probleme

Bei der Umsetzung dieser Erweiterung sind typische Fehlerquellen bewusst zu berücksichtigen und in der Dokumentation zu reflektieren.

### Fehlerquellen bei der Indizierung der Codebasis

- Quellcode wird in ungeeignete oder zu große Chunks zerlegt, wodurch wichtige Zusammenhänge verloren gehen oder das Retrieval unpräzise wird
- Es werden ausschließlich rohe Textsegmente gespeichert, ohne symbolische oder strukturelle Metadaten zu berücksichtigen
- Die Codebasis wird nicht erneut indiziert, obwohl sich Dateien geändert haben; dadurch entstehen veraltete Embeddings und inkonsistente Antworten

### Fehlerquellen bei Retrieval und Antwortgenerierung

- Zu viele ähnliche Chunks aus derselben Quelle verdrängen relevantere Informationen aus anderen Dateien oder Dokumenten
- Quellenangaben fehlen oder sind nicht eindeutig genug, sodass Antworten nicht nachvollzogen werden können
- PDF-Quellen und Code-Quellen werden vermischt, ohne den Ursprung für Benutzer klar sichtbar zu machen
- Die gewählte Chunk-Größe oder Embedding-Dimension ist nicht geeignet und verschlechtert Qualität oder Performance

### Fehlerquellen bei der Nutzung von Online-LLMs

- Vertrauliche Daten, Schlüssel, interne URLs oder sensible Codebestandteile werden ungefiltert an externe Dienste gesendet
- Es wird kein klarer Unterschied zwischen lokalem und externem Verarbeitungsmodus gemacht
- Das Kontextfenster des Online-LLM wird durch zu große Retrieval-Pakete überlastet
- Externe Antworten werden übernommen, ohne sie gegen die lokal gefundenen Quellen zu prüfen
- Die Kosten, Limits oder Latenzen externer APIs werden nicht berücksichtigt

### Fehlerquellen bei der API für OpenCode

- Die API liefert unstrukturierte Freitextblöcke statt maschinenlesbarer, weiterverarbeitbarer Daten
- Interne Datenbankdetails werden nach außen exponiert, statt eine stabile fachliche API bereitzustellen
- Fehlende Versionierung oder unklare Endpunkte erschweren die Nutzung durch OpenCode
- Die API berücksichtigt keine Fehlerfälle, z.B. leere Trefferlisten, Timeouts oder nicht unterstützte Dateitypen

## Technische Erwartungen

Die Umsetzung soll weiterhin in einer modularen Struktur erfolgen. Eine mögliche Erweiterung der bestehenden Modulaufteilung wäre zum Beispiel:

- `rag-code-indexer-service` für das Einlesen und Vektorisieren der Codebasis
- `rag-online-llm-adapter` für die kontrollierte Anbindung externer Modelle
- `rag-opencode-api` oder ein entsprechend erweitertes `rag-mcp-server` Modul für die externe Werkzeuganbindung

## Abgabe
Im Repository soll das `README.md` die notwendigen Schritte beschreiben. Auch das kombinierte `docker-compose.yml` soll enthalten sein. Bitte die Binaries und Class-Files in das `.gitignore` eintragen, sodass keine irrtümliche Abgabe erfolgt (besonders das `node-modules` Verzeichnis). Die Source-Code Files sollen getrennt abgelegt werden. Jegliche Änderungen müssen im `CHANGELOG.md` dokumentiert werden.

Bei der Verwendung von KI-Tools müssen die Chat-Prompts im Verzeichnis `prompts/` als Markdown-Files exportiert werden (Anfrage+Antowrt, ungekürzt). Hier soll darauf geachtet werden, dass die Anfrage als auch die Quellen der Antworten ersichtlich sind. Bei der Verwendung von KI-Coding Agents sind die Befehle zu loggen und im `prompts/Agent-NACHNAME.md` zu speichern.

Zusätzlich zu den bisherigen Abgabebestandteilen sind für diese Erweiterung insbesondere folgende Punkte zu dokumentieren:

- Architektur der Erweiterung um Codebasis, Online-LLMs und OpenCode,
- Beschreibung der gewählten Chunking- und Metadatenstrategie für Code,
- Beschreibung des Sicherheits- und Datenschutzkonzepts bei Online-LLMs,
- Dokumentation der API-Endpunkte inklusive Beispielanfragen und Beispielantworten,
- Beschreibung der bekannten Fehlerquellen und der gewählten Gegenmaßnahmen.

### Classroom Repository
[Hier](https://classroom.github.com/a/q9vOCtjX) finden Sie das Abgabe-Repository zum Entwickeln und Commiten Ihrer Lösung.

## Help, oh I need somebody

## Bewertung
Gruppengrösse: 3-4 Personen

### Erweiterung überwiegend erfüllt
- [ ] Codebasis wird zusätzlich zu PDFs indexiert
- [ ] Metadaten für Codequellen sind vorhanden
- [ ] Online-LLM kann optional verwendet werden
- [ ] Eine API für OpenCode ist definiert

### Erweiterung zur Gänze erfüllt
- [ ] Code- und PDF-Retrieval sind sinnvoll kombiniert
- [ ] Antworten enthalten nachvollziehbare Quellen aus beiden Wissensräumen
- [ ] Datenschutz bei Online-LLM-Nutzung ist technisch berücksichtigt
- [ ] OpenCode kann strukturierte Kontextdaten über die API abrufen
- [ ] Bekannte Fehlerquellen wurden dokumentiert und adressiert

## Quellen
* [NotebookLM](https://workspace.google.com/products/notebooklm)
* [SYT Theorie - Dezentrale Systeme](https://elearning.tgm.ac.at/course/view.php?id=199#coursecontentcollapse9)
* "Energy Efficiency across Programming Languages" [acm.org](https://dl.acm.org/doi/epdf/10.1145/3136014.3136031)

---
*Hinweis:* Diese Aufgabenbeschreibung wurde mit Unterstützung des KI-Assistenzsystems Perplexity erstellt.  

**Version** *20260408v2*
