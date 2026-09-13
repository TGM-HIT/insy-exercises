---
hide:
  - navigation
---

# "_ORM mit Django_" - Taskdescription

## Einführung

Das Bistro **Küche & Bar** sammelt Rezepte bisher in einzelnen Dokumenten. Zutaten werden mehrfach unterschiedlich geschrieben, Mengen sind schwer vergleichbar und niemand findet schnell alle Rezepte mit einer bestimmten Zutat. Ihr entwickelt ein gemeinsames Rezeptbuch mit Django und seinem Object-Relational Mapper (ORM).

Die Küche pflegt Speisen, die Bar Getränke. Beide verwenden denselben Zutatenstamm. Das Team kann Lieblingsrezepte markieren. Die erste Version bildet beide Rezepttypen gemeinsam ab; in der Erweiterung untersucht ihr eine Lösung mit Vererbung.

## Ziele

Ihr entwerft ein relational tragfähiges Objektmodell, erzeugt mit Migrationen das Schema, erfasst Demodaten im Django Admin und implementiert eigene ORM-Abfragen sowie Endpunkte zum Lesen, Anlegen und Löschen. Ihr erklärt das erzeugte SQL und überprüft eure Entscheidungen an konkreten Daten.

## Kompetenzzuordnung

#### GK SYT2 Datenbanken - Object-Relational Mapping

- "ein Datenmodell mittels ORM in Klassen abbilden und daraus eine Datenbank generieren"
- "einfache und komplexe Abfragen mittels ORM formulieren"
- "Vererbungsbeziehungen in einem relationalen Datenmodell mittels ORM geeignet umsetzen"

## Voraussetzungen

Python-Grundkenntnisse, relationale Modellierung mit Primär-/Fremdschlüsseln und grundlegender Umgang mit der Kommandozeile. Für Docker benötigt ihr eine funktionierende Umgebung mit Linux-Containern.

## Arbeitsmaterial und Versionen

Ladet das [Startprojekt als ZIP](project.zip) herunter und entpackt es. Arbeitet im enthaltenen Ordner `project`, in dem `manage.py` liegt. Die [Checkliste](CHECK.md) enthält dieselbe GK-/EK-Aufteilung wie die Bewertung am Ende.

| Technologie | Unterrichtsstand | Begründung |
| --- | --- | --- |
| Python | 3.14.7 | Aktuelle stabile Version; von Django 5.2 unterstützt. |
| Django | 5.2.17 LTS | Aktueller Patch der LTS-Linie, Sicherheitsunterstützung bis April 2028. Django 6.1 ist neuer, für diese ORM-Aufgabe aber nicht erforderlich. |
| Datenbank | SQLite aus Python | Keine zusätzliche Serverinstallation; Fokus auf ORM und Beziehungen. |
| Docker | Compose V2, `python:3.14.7-slim-bookworm` | Gleiche Python-/Django-Version wie im venv-Weg. |

Versionsprüfung: **13.09.2026**. Verwendet die beigefügte `requirements.txt` für beide Wege. Sie fixiert auch die Python-Abhängigkeiten. Vor einem späteren Kursdurchlauf sind verfügbare Sicherheitsupdates erneut zu prüfen.

**Vorgegeben:** Django-Projekt, URL-Zuordnung, HTML-Grundgerüst, Docker-Konfiguration und ein JSON-Testclient mit Anmelde-/CSRF-Unterstützung. **Eure Arbeit:** Modelle, Migrationen, Admin-Registrierung, Demodaten, ORM-Abfragen, Antwortlogik und Rezeptansichten. Die Startseite bestätigt nur den Start; die übrigen Fach-Endpunkte liefern zunächst bewusst HTTP 501.

## Grundanforderungen

### 1. Projekt aufsetzen

Für die Grundanforderungen reicht **venv oder Docker**. Erst für „Erweitert vollständig“ sind beide Wege nachzuweisen. Ein Entwicklungsserver, SQLite und einfache HTML-Seiten genügen; eine zusätzliche Frontend-Bibliothek ist nicht erforderlich.

#### Weg A: venv

Installiert Python 3.14.7. Prüft vor dem Anlegen der Umgebung die Version mit `py -3.14 --version` unter Windows beziehungsweise `python3.14 --version` unter Linux/macOS.

Windows / PowerShell:

```powershell
py -3.14 -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
.\.venv\Scripts\python.exe manage.py migrate
.\.venv\Scripts\python.exe manage.py createsuperuser
.\.venv\Scripts\python.exe manage.py runserver
```

Linux / macOS:

```bash
python3.14 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
.venv/bin/python manage.py migrate
.venv/bin/python manage.py createsuperuser
.venv/bin/python manage.py runserver
```

Der direkte Interpreterpfad macht eine Aktivierung der venv überflüssig. Wenn ihr sie aktiviert, könnt ihr anschließend `python` verwenden. Der erste Aufruf von `migrate` erzeugt zunächst Djangos eigene Tabellen, etwa für Benutzer und Sitzungen.

#### Weg B: Docker

Die Docker-Dateien sind vorhanden. Der Dienst heißt **`web`**.

```bash
docker compose build
docker compose run --rm web python manage.py migrate
docker compose run --rm web python manage.py createsuperuser
docker compose up -d
docker compose logs --tail 30 web
```

Öffnet bei beiden Wegen `http://127.0.0.1:8000/` und anschließend `/admin/`. Falls Port 8000 belegt ist: Docker verwendet mit `HOST_PORT=8001` in einer lokalen `.env` Port 8001; bei venv startet ihr mit `runserver 127.0.0.1:8001`. Weitere Hinweise stehen in der `README.md` des Projekts.

Codeänderungen werden durch den Entwicklungsserver nachgeladen. Docker bindet den Projektordner nach `/app` ein. Deshalb bleiben Code, Migrationen und `db.sqlite3` am Host erhalten, auch nach `docker compose down`. Nach Änderungen an den Abhängigkeiten ist ein neuer Build nötig. Führt venv und Docker für denselben Projektordner abwechselnd aus.

### 2. Datenmodell selbst entwerfen

Skizziert zuerst Klassen, Beziehungen und Kardinalitäten. Leitet daraus Feldtypen, Pflichtfelder und Löschregeln ab. Begründet besonders, wo **Menge und Einheit** gespeichert werden müssen.

Folgende Klassen gehören zum Modell:

- **User:** Djangos vorhandener Benutzer. Legt kein zweites User-Modell an; referenziert das konfigurierte Benutzermodell.
- **Recipe:** Name, Anleitung und zunächst `type` mit den Werten `food` oder `drink`. Rezepte haben Zutaten und können von Benutzern geliked werden.
- **Ingredient:** Ein Eintrag im gemeinsamen Zutatenstamm mit einem eindeutigen Namen.
- **Contain:** Eine Zutatenposition eines Rezepts mit Menge und optionaler Einheit.

Geschäftsregeln:

1. Ein Rezept enthält keine, eine oder mehrere Zutatenpositionen. Eine leere Zutatenliste ist als Entwurf erlaubt.
2. Dieselbe Zutat darf in vielen Rezepten vorkommen, innerhalb eines Rezepts aber nur einmal. Die Mengen können sich je Rezept unterscheiden.
3. Mengen sind positiv und dürfen Bruchteile enthalten, beispielsweise `0.5` Zitronen. Unterstützt bis zu drei Nachkommastellen und Werte bis `999999.999`; begründet eure Wahl des Datentyps. Eine fehlende Einheit bedeutet Stück.
4. Benutzer können mehrere Rezepte liken; jedes Benutzer-Rezept-Paar kommt höchstens einmal vor. Auch null Likes sind erlaubt.
5. Beim Löschen eines Rezepts verschwinden dessen Zutatenpositionen und Like-Zuordnungen. Der Zutatenstamm und die Benutzer bleiben erhalten. Die Löschregel für eine noch verwendete Zutat wählt und begründet ihr selbst.
6. Namen und Anleitungen sind nicht leer. Verwendet für Namen höchstens 120 Zeichen, für Einheiten höchstens 20 Zeichen. Zutaten werden vor der Erfassung einheitlich benannt; automatische Synonymerkennung ist nicht Teil der Aufgabe.

Setzt geeignete Regeln auch in der Datenbank durch, insbesondere die eindeutige Zutatenposition und die positive Menge. Eine Prüfung im Formular allein schützt nicht jeden Schreibweg. Dokumentiert, welche Regel auf welcher Ebene gilt.

Implementiert anschließend `backend/models.py`, erzeugt Migrationen und prüft das Ergebnis:

```bash
# Bei aktiver venv; sonst euren direkten Interpreterpfad verwenden:
python manage.py makemigrations backend
python manage.py sqlmigrate backend 0001
python manage.py migrate
python manage.py check
```

`0001` bezeichnet eure erste Migration; verwendet bei weiteren Änderungen den tatsächlich erzeugten Namen. Im laufenden Container lautet der Präfix `docker compose exec web python manage.py ...`.

**Lernversuch – Beziehung mit Zusatzdaten:** Sagt voraus, welche Datensätze entstehen, wenn zwei Rezepte dieselbe Zutat mit verschiedenen Mengen verwenden. Legt den Fall an, vergleicht eure Vorhersage mit den Tabellen und erklärt, warum die Menge weder direkt zu `Ingredient` noch zu `Recipe` gehört.

??? tip "Hilfe bei der Modellierung"

    Vergleicht eine normale Many-to-many-Beziehung mit einer Beziehung über ein eigenes Zwischenmodell (`through`). Prüft außerdem `ForeignKey`, `settings.AUTH_USER_MODEL`, `DecimalField`, `UniqueConstraint`, `CheckConstraint` und die möglichen `on_delete`-Regeln in den verlinkten Django-Quellen. Zeichnet euer Modell, bevor ihr die Syntax übernehmt.

### 3. Admin und aussagekräftige Demodaten

Registriert eure eigenen Modelle in `backend/admin.py`. Der Benutzer ist bereits im Admin vorhanden. Vergebt verständliche Objektbezeichnungen und erfasst mindestens:

- zwei Speisen und zwei Getränke mit unterschiedlichen Zutatenkombinationen;
- eine Zutat, die in mindestens zwei Rezepten mit unterschiedlicher Menge vorkommt;
- eine Zutat ohne Verwendung und einen Rezeptentwurf ohne Zutaten;
- eine Menge mit Nachkommastellen und eine Position ohne Einheit;
- zwei Benutzer mit unterschiedlichen Likes; mindestens ein Rezept mit zwei Likes und zwei Zutaten.

Die beiden Benutzer dürfen reine Demoaccounts sein. Eine eigene Registrierungs- oder Like-Weboberfläche ist nicht gefordert; die Zuordnung über Admin oder Django-Shell genügt. Haltet für eure Daten die erwarteten Zutatenanzahlen und Suchtreffer fest, bevor ihr die Views implementiert.

### 4. ORM-Abfragen und Endpunkte

Ersetzt die TODO-Stellen durch eure Lösung. Die Leseansichten liefern einfache HTML-Seiten; fachlich korrekte Inhalte und nachvollziehbare Abfragen sind entscheidend.

| Methode und Pfad | Erwartetes Verhalten |
| --- | --- |
| `GET /` | Alle Rezepte mit Namen und **Anzahl unterschiedlicher Zutaten**, auch Entwürfe mit Anzahl 0; Link auf die Detailansicht. |
| `GET /recipe/<id>` | Rezept mit Typ, Anleitung und Zutaten samt Mengen/Einheiten; jede Zutat verlinkt zur Zutatensuche. Unbekanntes Rezept: 404. |
| `GET /by-ingredient/<id>` | Alle Rezepte, die genau diese Zutat enthalten. Vorhandene unbenutzte Zutat: leere Trefferliste mit verständlichem Hinweis; unbekannte Zutat: 404. |
| `POST /new` | JSON prüfen und ein Rezept samt Zutatenpositionen gemeinsam speichern. Erfolg: 201 und JSON mit der neuen Rezept-ID. |
| `POST /remove/<id>` | Rezept mit seinen Zuordnungen löschen. Erfolg: 200 und JSON mit der gelöschten ID; unbekanntes Rezept: 404. |

Die Fachpfade haben **keinen abschließenden Slash**. Anlegen und Löschen erfordern eine aktive Admin-Sitzung. Die fertigen Dekoratoren prüfen Anmeldung und HTTP-Methode; behaltet sie bei. GET darf keine Daten verändern und wird bei den beiden Schreib-Endpunkten mit 405 abgewiesen. CSRF bleibt aktiv.

#### JSON testen

Meldet euch unter `/admin/` an und öffnet danach `/tools/`. Der mitgelieferte Testclient sendet POST, Sitzung und CSRF-Token. Ihr müsst dafür keine eigene Anmeldelogik entwickeln. Verwendet echte Zutaten-IDs aus eurer Datenbank, beispielsweise:

```json
{
  "name": "Zitronenwasser",
  "type": "drink",
  "instructions": "Wasser und Zitrone mischen.",
  "ingredients": [
    {"id": 1, "quantity": 250, "unit": "ml"},
    {"id": 2, "quantity": 0.5}
  ]
}
```

`name`, `type`, `instructions` und `ingredients` sind Pflichtfelder. `ingredients` ist eine Liste; jede Position enthält eine ganzzahlige positive `id` und eine endliche Zahl `quantity`, optional eine Zeichenkette `unit`. Die Grenzen und Geschäftsregeln aus dem Datenmodell gelten auch hier. Boolesche Werte sind keine Mengen oder IDs. Eine unbekannte Zutaten-ID, doppelte Zutaten, fehlende Pflichtfelder, ein unbekannter Typ oder ungültiges JSON führen zu **400 mit verständlicher JSON-Fehlermeldung**. Ein anderer Content-Type als `application/json` führt zu **415**. Ein Fehler darf kein halbes Rezept hinterlassen.

**Lernversuch – alles oder nichts:** Sendet ein Rezept mit einer gültigen und danach einer unbekannten Zutaten-ID. Notiert vorher die erwartete Änderung der Rezept- und Positionsanzahl. Vergleicht nach der Antwort die tatsächlichen Werte und begründet, wie eure Lösung unvollständige Datensätze verhindert.

??? tip "Hilfe bei Abfragen und Schreibvorgängen"

    Startet Abfragen in `manage.py shell` mit euren Demodaten. Die Dokumentation zu Queries und Aggregation zeigt Filtern über Beziehungen und Zählen pro Objekt. Für Fehlerantworten helfen `JsonResponse` und `get_object_or_404`; für zusammengehörige Schreibvorgänge `transaction.atomic()`. Django ruft bei `save()` nicht automatisch `full_clean()` auf: Legt eure Validierung bewusst fest.

#### Abfragen verstehen

Weist Zutatenanzahl und Zutatenfilter mit euren vorher festgelegten Sollwerten nach. Zeigt zu einer Abfrage das SQL über die `query`-Eigenschaft des QuerySets und erklärt die beteiligten Tabellen. Berechnet einmal in der Shell Zutatenanzahl **und** Like-Anzahl für dasselbe Rezept: Prüft am Rezept mit zwei Zutaten und zwei Likes, ob zusätzliche Joins eure Zählung verfälschen. Die Like-Anzahl muss nicht ins Frontend eingebaut werden.

Eine optionale Vertiefung ist der Vergleich der Abfrageanzahl beim Laden mehrerer Detailansichten mit und ohne `select_related` beziehungsweise `prefetch_related`. Diese Optimierung ist keine zusätzliche Bewertungsstufe.

### 5. Demodaten exportieren

Exportiert die fachlichen Daten mit dem Django-Befehl. `--output` vermeidet die Shell-Umleitung; **`-X utf8`** stellt auch unter Windows mit Python 3.14 die benötigte UTF-8-Kodierung sicher:

```bash
# Aktive venv:
python -X utf8 manage.py dumpdata backend --natural-foreign --indent 2 --output recipes.json

# Alternativ im laufenden Container:
docker compose exec web python -X utf8 manage.py dumpdata backend --natural-foreign --indent 2 --output recipes.json
```

Exportiert nicht die komplette `auth`-App mit Passworthashes. Durch `--natural-foreign` verweisen Likes beim Standardbenutzer auf Benutzernamen. Nennt diese Demo-Benutzernamen in eurer README. Zum Prüfen des Exports verwendet ihr eine **separate Projektkopie ohne Datenbankdatei und ohne venv**: Umgebung einrichten, Migrationen anwenden, gleichnamige Demo-Benutzer anlegen und `python manage.py loaddata recipes.json` ausführen. Vergleicht Rezepte, Zutatenpositionen und Likes. Die Originaldatenbank bleibt dabei erhalten.

## Erweiterte Anforderungen

### 6. Rezepttypen durch Vererbung abbilden

Die Küche benötigt **Kalorien in kcal pro Rezept**, die Bar die beiden Angaben **Kohlensäure** und **Alkohol** (ja/nein). Ersetzt das gespeicherte Typattribut durch geeignete Django-Modellvererbung für Speisen und Getränke.

Vergleicht abstrakte Basisklassen, Multi-table Inheritance und Proxy-Modelle. Begründet eure Wahl anhand gemeinsamer Zutaten-/Like-Beziehungen, Identität und zusätzlicher Felder. Ein Rezept gehört fachlich genau einem konkreten Typ. Prüft, wie eure Lösung untypisierte oder widersprüchliche Einträge vermeidet.

Sichert vor dem Umbau den GK-Stand samt Daten. Dokumentiert die Schemaänderung und übernehmt eure bisherigen Demorezepte samt Mengen und Likes. Dafür ist eine Datenmigration oder ein erklärter Export-/Importweg zulässig. Neue fachliche Werte ergänzt ihr bewusst; ein Löschen der Datenbank allein erklärt keine Migration. Die GK-Lösung muss über einen eigenen Git-Stand oder eine getrennte Abgabe weiterhin demonstrierbar sein.

Passt **Index, Detailansicht und Zutatensuche** an: Beide Rezepttypen müssen mit ihren jeweiligen Zusatzangaben erscheinen. Untersucht insbesondere, welchen Python-Objekttyp eine Abfrage auf die gemeinsame Basisklasse zurückliefert. Die bereits nachgewiesenen GK-Schreib-Endpunkte werden für die EK-Stufe nicht um eine neue JSON-Schnittstelle erweitert; pflegt die EK-Daten über den angepassten Admin. Falls ihr `/new` in der EK-Version vorübergehend nicht anbietet, muss das klar angezeigt sein und der gesicherte GK-Stand weiterhin funktionieren.

??? tip "Hilfe zur Vererbung"

    Verwendet zuerst die eingebauten Django-Möglichkeiten. Für eine optionale Recherche gibt es [django-model-utils](https://github.com/jazzband/django-model-utils) und [django-polymorphic](https://github.com/django-commons/django-polymorphic). Sie sind nicht erforderlich und nicht im Startprojekt installiert. Wenn ihr ein Zusatzpaket einsetzt, prüft dessen Django-/Python-Kompatibilität und fixiert die verwendete Version.

### 7. Beide Ausführungswege erklären

Zeigt denselben EK-Projektstand **im venv und in Docker**. Dokumentiert Python-/Django-Version, Installations- und Migrationsbefehle, Speicherort der Datenbank sowie die Wirkung des Bind-Mounts. Erklärt, wann ein Container-Neustart genügt und wann ein neuer Build erforderlich ist.

## Fragestellungen

Beantwortet die folgenden **grundlegenden** Fragen anhand eurer eigenen Lösung. Vererbung wird hier bereits theoretisch behandelt; ihre praktische Umsetzung gehört weiterhin zu den erweiterten Anforderungen.

1. Was ist ORM? Wo hilft es gegenüber direktem SQL, und warum bleiben SQL- und Datenbankkenntnisse nötig?
2. Wie bilden eure Modelle Beziehungen ab? Warum benötigen Zutatenmengen ein Zwischenmodell, Likes aber keine zusätzlichen fachlichen Felder?
3. Was unterscheidet `makemigrations`, `sqlmigrate` und `migrate`? Welche Dateien braucht jemand, der eure Datenbank neu aufbaut?
4. Welche drei Django-Varianten der Modellvererbung gibt es? Welche können zusätzliche Datenbankfelder speichern, und wann ist eine gemeinsame Basistabelle vorhanden?
5. Wofür nutzt ihr den Django Admin, wofür eigene Views? Welche Prüfungen gelten auch außerhalb des Admins?
6. Was isoliert eine venv, und wie stellt ihr sicher, dass `pip` und `manage.py` denselben Interpreter verwenden?
7. Wie unterstützt ein Python-Container die Entwicklung? Was passiert mit Code und Datenbank beim Stoppen beziehungsweise Entfernen des Containers?

## Abgabe und Nachweis

**Gruppengröße: 1 Person.** Gebt auf Moodle den Quellcode inklusive eigener Migrationen, `requirements.txt`, verwendeter Docker-Dateien, `recipes.json` und einer kurzen README ab. Bei EK enthält die Abgabe auch den nachvollziehbaren GK-Stand. `.venv`, Cache-Dateien, Datenbankdateien und persönliche Zugangsdaten gehören nicht in die Abgabe.

Ergänzt ein kompaktes Protokoll mit Modellskizze, begründeten Entscheidungen, Antworten und Tests. Pro Test genügen Ausgangsdaten, Aktion, erwartetes Ergebnis, beobachtetes Ergebnis und eine kurze Erklärung. Screenshots sind Ergänzungen. Kennzeichnet Quellen und KI-Unterstützung.

Nutzt mindestens diese Kontrollfälle für die jeweils bearbeiteten Anforderungen:

| Bereich | Kontrollfälle |
| --- | --- |
| Modell/Admin | Geteilte Zutat mit unterschiedlichen Mengen; doppelte Position und nichtpositive Menge abweisen; zwei Benutzer liken dasselbe Rezept. |
| Lesen | Normales Rezept, Entwurf mit 0 Zutaten, verwendete und unbenutzte Zutat, unbekannte IDs, korrekte Zählung trotz Likes. |
| Anlegen | Gültiges Rezept, leere Zutatenliste, ungültiges JSON, fehlendes Feld, ungültiger Typ/Menge, doppelte oder unbekannte Zutat; kein Teilimport. |
| Löschen | Vorhandene und unbekannte ID; Zuordnungen verschwinden, Benutzer/Zutaten bleiben; GET verändert nichts. |
| Export | Wiederherstellung in separater Kopie einschließlich Mengen und Likes. |
| EK | Beide konkreten Typen mit Zusatzfeldern in allen drei Leseansichten; Datenübernahme; Start im venv und in Docker. |

Im Abgabegespräch erklärt ihr die laufende Lösung und führt eine kleine Änderung selbst aus, etwa eine Zutatenmenge ändern und die Auswirkung auf das zweite Rezept prüfen oder die Zutatensuche um eine zusätzliche Bedingung ergänzen. Für EK kann die Lehrkraft eine typbezogene Abfrage wählen. Eigene Unterlagen sind erlaubt; entscheidend sind Erklärung und Überprüfung der Änderung.

## Bewertung

Die GK-/EK-Zuordnung bleibt unverändert. Die Kontrollfälle konkretisieren die bestehenden Kriterien. Hilfen dürfen ohne Bewertungsabzug verwendet werden.

### Grundanforderungen **überwiegend erfüllt**

- [ ] Projekt lauffähig gemacht (venv oder Docker) und Pakete installiert.
- [ ] Datenmodelle (vorhandener User, Recipe, Ingredient, Contain) samt Beziehungen und begründeten Regeln umgesetzt.
- [ ] Eigene Modelle im Admin-Backend registriert und Adminbenutzer erstellt.
- [ ] Aussagekräftige Demorezepte über das Admin-Backend angelegt.

### Grundanforderungen **zur Gänze erfüllt**

- [ ] Views für Index, `/recipe/<id>` und `/by-ingredient/<id>` mit korrekten ORM-Abfragen implementiert und geprüft.
- [ ] Endpoint `/new` zum Anlegen neuer Rezepte via POST mit JSON implementiert und geprüft.
- [ ] Endpoint `/remove/<id>` zum Löschen von Rezepten implementiert und geprüft.
- [ ] Demorezepte mittels `dumpdata` exportiert und Wiederherstellung nachgewiesen.
- [ ] Grundlegende Fragestellungen anhand der eigenen Lösung beantwortet.
- [ ] Abgabegespräch über Aufgaben und Fragestellungen einschließlich einer kleinen eigenen Änderung.

### Erweiterte Anforderungen **überwiegend erfüllt**

- [ ] Rezepttyp mittels begründeter Vererbung (Essen / Trinken) statt als gespeichertem Attribut umgesetzt.
- [ ] Zusätzliche Eigenschaften je Rezepttyp (Kohlensäure/Alkohol bzw. Kalorien) gespeichert; Schemaänderung und Übernahme der Demodaten erklärt.

### Erweiterte Anforderungen **zur Gänze erfüllt**

- [ ] Endpoints für Index, `/recipe/<id>` und `/by-ingredient/<id>` an die Vererbungsstruktur angepasst und mit beiden Typen geprüft.
- [ ] Ausführung sowohl über venv als auch über Docker gelöst und erklärt.

## Quellen

Alle Quellen wurden am **13.09.2026** auf Erreichbarkeit und fachliche Eignung geprüft. Die Django-Anleitungen passen zur eingesetzten 5.2-Linie.

- Django: [Versionen und Support](https://www.djangoproject.com/download/) und [Python-Kompatibilität](https://docs.djangoproject.com/en/5.2/faq/install/).
- Python: [Veröffentlichte Versionen](https://www.python.org/downloads/) und [venv](https://docs.python.org/3.14/library/venv.html).
- Django 5.2: [Modelle, Beziehungen und Vererbung](https://docs.djangoproject.com/en/5.2/topics/db/models/), [Abfragen](https://docs.djangoproject.com/en/5.2/topics/db/queries/) und [Aggregation](https://docs.djangoproject.com/en/5.2/topics/db/aggregation/).
- Django 5.2: [Migrationen](https://docs.djangoproject.com/en/5.2/topics/migrations/), [Transaktionen](https://docs.djangoproject.com/en/5.2/topics/db/transactions/) und [Serialisierung / Natural Keys](https://docs.djangoproject.com/en/5.2/topics/serialization/).
- Django 5.2: [CSRF-Unterstützung für AJAX](https://docs.djangoproject.com/en/5.2/howto/csrf/) und [Abfrageoptimierung](https://docs.djangoproject.com/en/5.2/topics/db/optimization/).
- Docker: [Compose](https://docs.docker.com/compose/) und [offizielles Python-Image](https://hub.docker.com/_/python).
- Optionale Erweiterungen: [django-model-utils](https://github.com/jazzband/django-model-utils) und [django-polymorphic](https://github.com/django-commons/django-polymorphic), inzwischen unter `django-commons`.
- Historische Kursunterlage: Erhard List, **2013/14**, [ORM 1 – Allgemeines](resources/ORM-Allgemeines-2013-14.pdf). Die Diagramme illustrieren allgemeine Mapping-Strategien; sie sind keine aktuelle Django-Anleitung. Die Aussagen zur Leistung auf S. 14 sind nicht allgemeingültig. Ein Data Mapper trennt Persistenz und Domänenobjekte; er ist nicht dadurch definiert, dass ein Objekt eine ganze Kollektion repräsentiert (S. 15). Bei 1:n liegt der Fremdschlüssel auf der n-Seite und verweist zur 1-Seite (Präzisierung zu S. 12). Vergleicht dazu Martin Fowler: [Active Record](https://martinfowler.com/eaaCatalog/activeRecord.html) und [Data Mapper](https://martinfowler.com/eaaCatalog/dataMapper.html).
- [Startprojekt dieser Aufgabe](project.zip); es ersetzt den bisherigen Download über einen externen Verzeichnis-Downloader.

*Diese Aufgabenbeschreibung wurde mit KI-Unterstützung überarbeitet.*

---

**Version:** 20260913v2 – aktuelles Startprojekt, überprüfbare ORM-Lernaufträge und unveränderte GK-/EK-Zuordnung
