---
hide:
  - navigation
---

# "_ORM mit Django_" - Taskdescription

## Einführung

Object-Relational Mapping (ORM) ermöglicht es, Datenbankstrukturen objektorientiert zu modellieren, ohne SQL direkt schreiben zu müssen. Django bringt mit seinem eigenen ORM ein mächtiges Werkzeug mit, um Modelle zu definieren, daraus automatisch Datenbanktabellen zu generieren und komfortabel Abfragen zu formulieren. In dieser Übung wird anhand eines kleinen Rezepte-Projekts der praktische Umgang mit dem Django ORM erlernt.

## Ziele

Ein bestehendes Django-Projekt lokal (oder in Docker) zum Laufen bringen, mittels Django ORM passende Datenmodelle für eine Rezeptdatenbank entwerfen und implementieren, daraus die Datenbank generieren lassen, das Admin-Backend nutzen sowie einfache CRUD-Endpoints im Backend umsetzen. Darüber hinaus die Modellierung von Vererbung mit dem Django ORM verstehen und anwenden können.

## Kompetenzzuordnung

#### GK SYT2 Datenbanken - Object-Relational Mapping

- "ein Datenmodell mittels ORM in Klassen abbilden und daraus eine Datenbank generieren"
- "einfache und komplexe Abfragen mittels ORM formulieren"
- "Vererbungsbeziehungen in einem relationalen Datenmodell mittels ORM geeignet umsetzen"

## Voraussetzungen

- Grundkenntnisse in Python
- Grundlegendes Verständnis relationaler Datenbanken (Tabellen, Beziehungen, Primär-/Fremdschlüssel)
- Umgang mit der Kommandozeile
- Grundkenntnisse in Docker sind von Vorteil (bei Verwendung der Docker-Alternative)

## Detaillierte Aufgabenbeschreibung

### Ausgangslage

Gegeben ist ein kleines Django-Projekt `recipes`, das im Wesentlichen aus einer App `backend` besteht. Ziel der Übung ist es, das Projekt zunächst lokal laufen zu lassen und dann mittels Django ORM passende Modelle anzulegen und daraus die Datenbank generieren zu lassen, sowie einfache Abfragen zu formulieren.

### Grundanforderungen

#### Projekt aufsetzen

- Lade zunächst das [Projekt](https://download-directory.github.io/?url=https%3A%2F%2Fgithub.com%2FTGM-HIT%2Finsy-exercises%2Ftree%2Fmain%2Fdocs%2F3.Semester%2F33_ORM%2Fproject) herunter, initialisiere ein _virtual environment_ und installiere mittels `pip install -r requirements.txt` die entsprechenden Pakete.
- Starte das Projekt mittels `./manage.py runserver`.
- Lege in der `backend/models.py` entsprechende Modelle für Rezepte an (siehe Abschnitt [Datenmodell](#datenmodell)).
- Füge in der `backend/admin.py` deine Modelle hinzu (`admin.site.register(<Modellname>)`).
- Erstelle einen Adminbenutzer mittels `./manage.py createsuperuser`.
- Rufe das Admin-Backend unter `http://127.0.0.1:8000/admin` auf und erstelle ein paar Demorezepte.
- Passe die `backend/views.py` dementsprechend an, dass die Rezepte aus der Datenbank gelesen und angezeigt werden.
- Exportiere deine Demorezepte mittels `./manage.py dumpdata backend > recipes.json`.

#### Alternative: Ausführung in Docker

Anstelle eines lokalen _virtual environment_ kann das Projekt auch in einem Docker-Container laufen. Dazu im Projektverzeichnis (dort, wo `manage.py` liegt) die entsprechenden Docker-Dateien anlegen.

Das Volume `.:/app` bindet das Projektverzeichnis in den Container, sodass Codeänderungen sofort wirken: Python-Dateien (z. B. `views.py`) lösen dank des `StatReloader` von `runserver` automatisch einen Neustart des Dev-Servers aus, Templates (z. B. `index.html`) werden bei `DEBUG = True` ohnehin bei jedem Request neu geladen. Ein `docker compose build` ist daher nur bei Änderungen an `requirements.txt` oder am `Dockerfile` selbst nötig.

Verwendung:

```bash
# Container bauen und im Hintergrund starten
docker compose up -d --build

# Logs ansehen
docker compose logs -f

# Container stoppen und entfernen
docker compose down
```

`manage.py`-Befehle lassen sich im laufenden Container mittels `docker compose exec` ausführen:

```bash
docker compose exec web python manage.py makemigrations
docker compose exec web python manage.py migrate
docker compose exec -it web python manage.py createsuperuser
docker compose exec web python manage.py dumpdata backend > recipes.json
```

Alternativ ganz ohne dauerhaft laufenden Container, als Einmal-Ausführung:

```bash
docker compose run --rm web python manage.py migrate
```

#### Datenmodell

Folgende Klassen sollen zumindest vorhanden sein:

- **User**: ein Benutzer (`auth.User` existiert bereits)
- **Recipe**: ein Rezept, besitzt einen Namen, mehrere Zutaten, einen Typ und eine Kochanleitung. Ein Rezept kann von einem oder mehreren Benutzern geliked werden.
- **Ingredient**: eine Zutat, besitzt einen Namen
- **Contain**: das Vorkommen einer Zutat in einem Rezept mit einer bestimmten Anzahl und einer Einheit (optional)

#### Frontend-Endpoints

Baue das Frontend wie folgt ein:

- Speichere über das Admin-Interface ein paar aussagekräftige Rezepte.
- Die Index-Route soll alle Rezepte mit Rezeptnamen und Anzahl der Zutaten auflisten und auf `/recipe/[id]` verlinken.
- Unter `/recipe/[id]` soll das entsprechende Rezept angezeigt werden.
- Unter `/by-ingredient/[id]` sollen alle Rezepte gelistet werden, die die entsprechende Zutat enthalten.
- Unter `/new` soll ein neues Rezept angelegt werden können. Dies geschieht via POST-Request, der im Body ein Rezept im JSON-Format wie zum Beispiel

  ```json
  {
    "name": "Spaghetti Carbonara",
    "type": "food",
    "instructions": "... to be continued ...",
    "ingredients": [
      {
        "id": 1,
        "quantity": 400,
        "unit": "g"
      },
      {
        "id": 2,
        "quantity": 2
      }
    ]
  }
  ```

  enthält.

- Unter `/remove/<id>` soll ein Rezept gelöscht werden können.

**Hinweise:**

- URLs mit Parametern lassen sich in der `urls.py` zum Beispiel wie folgt definieren: `path("recipe/<int:recipeid>", views.recipe, name="recipe")`. Im View bekommt man diesen Parameter dann extra übergeben: `def recipe(request, recipeid):`
- Auf den Body lässt sich bei einem POST-Request in der `views.py` mittels `request.body` zugreifen und dann mittels `json.loads()` in JSON konvertieren. Für die Übung muss die Methode in der `views.py` mit `@csrf_exempt` annotiert werden. Der Aufruf lässt sich dann z. B. mittels Postman und einem JSON-Dokument im Request-Body testen oder auch mittels `curl` mit folgenden Parametern:

  ```
  curl -X POST -H "Content-Type: application/json" --data '{"a":"b"}' "http://127.0.0.1:8000/new"

  curl -X POST -H "Content-Type: application/json" --data '{"name":"Test Rezept","type":"food","instructions":"Testen","ingredients":[]}' "http://127.0.0.1:8000/new"
  ```

### Erweiterte Anforderungen

Ändere das Datenmodell deiner Django-Anwendung wie folgt:

- Der Typ eines Recipes soll nicht mehr als Attribut abgespeichert werden.
- Verschiedene Rezepttypen (Essen / Trinken) sollen stattdessen mittels Vererbung realisiert werden. Wähle dabei eine geeignete Realisierung der Vererbung mit Django ORM.
- Für Getränkerezepte soll dabei gespeichert werden, ob das Getränk Kohlensäure bzw. Alkohol enthält.
- Für Essen soll dabei die Menge an Kalorien gespeichert werden.

Ändere die Endpunkte für Index, `/recipe/[id]` und `/by-ingredient/[id]` so ab, dass beide Rezepttypen samt ihren zusätzlichen Eigenschaften angezeigt werden.

Außerdem ist die Ausführung über venv als auch über Docker zu lösen als auch zu erklären.

**Hinweis:** Die Pakete [django-model-utils](https://github.com/jazzband/django-model-utils) oder [django-polymorphic](https://github.com/jazzband/django-polymorphic) können bei der Nutzung von Polymorphie bei der Vererbung helfen.

## Fragestellungen

### Grundlegend

- Was versteht man unter Object-Relational Mapping und welche Vorteile bringt es gegenüber reinem SQL?
- Wie werden Beziehungen zwischen Modellen (z. B. ManyToMany, ForeignKey) im Django ORM abgebildet?
- Wie generiert Django aus den Modellen die tatsächliche Datenbankstruktur (Migrations)?
- Welche Möglichkeiten bietet Django ORM, um Vererbung zwischen Modellen abzubilden, und worin unterscheiden sie sich?
- Was ist der Unterschied zwischen dem Django Admin-Backend und selbst geschriebenen Views?
- Was ist venv? Wie ist es zu verwenden?
- Wie lässt sich python in einem Container für Development verwenden?

## Abgabe

Der vollständige Quellcode des Django-Projekts (inklusive Modelle, Views, URLs und ggf. Docker-Dateien) sowie die exportierten Demodaten (`recipes.json`) sind auf moodle abzugeben. Die Beantwortung der Fragestellungen ist ebenfalls beizulegen.

Bei einem Abgabegespräch sind die laufende Umgebung (lokal oder in Docker) sowie kurze Kontrollfragen zwecks Verständnisüberprüfung notwendig.

## Bewertung

Gruppengrösse: 1 Person

### Grundanforderungen **überwiegend erfüllt**

- [ ] Projekt lauffähig gemacht (venv oder Docker) und Pakete installiert
- [ ] Datenmodelle (User, Recipe, Ingredient, Contain) in `models.py` angelegt
- [ ] Modelle im Admin-Backend registriert und Adminbenutzer erstellt
- [ ] Demorezepte über das Admin-Backend angelegt

### Grundanforderungen **zur Gänze erfüllt**

- [ ] Views für Index, `/recipe/[id]` und `/by-ingredient/[id]` implementiert
- [ ] Endpoint `/new` zum Anlegen neuer Rezepte via POST-Request implementiert
- [ ] Endpoint `/remove/<id>` zum Löschen von Rezepten implementiert
- [ ] Demorezepte mittels `dumpdata` exportiert
- [ ] Fragestellungen beantwortet
- [ ] Abgabegespräch über die Aufgaben- und Fragestellungen

### Erweiterte Anforderungen **überwiegend erfüllt**

- [ ] Rezepttyp mittels Vererbung (Essen / Trinken) statt als Attribut umgesetzt
- [ ] Zusätzliche Eigenschaften je Rezepttyp (Kohlensäure/Alkohol bzw. Kalorien) gespeichert

### Erweiterte Anforderungen **zur Gänze erfüllt**

- [ ] Endpoints für Index, `/recipe/[id]` und `/by-ingredient/[id]` an die neue Vererbungsstruktur angepasst
- [ ] Ausführung sowohl über venv als auch über Docker gelöst und erklärt

_🤖 Diese Aufgabe wurde Mithilfe von KI erstellt._

## Quellen

- "Django Dokumentation Models"; [online](https://docs.djangoproject.com/en/5.2/topics/db/models/)
- "Django Dokumentation Queries"; [online](https://docs.djangoproject.com/en/5.2/topics/db/queries/)
- "django-model-utils"; [online](https://github.com/jazzband/django-model-utils)
- "django-polymorphic"; [online](https://github.com/jazzband/django-polymorphic)
- "ORM 1 - Allgemeines"; [online](https://github.com/TGM-HIT/insy-exercises/blob/main/docs/3.Semester/33_ORM/project/ORM%201%20-%20Allgemeines.pdf)
- "Projektdateien"; [online](https://download-directory.github.io/?url=https%3A%2F%2Fgithub.com%2FTGM-HIT%2Finsy-exercises%2Ftree%2Fmain%2Fdocs%2F3.Semester%2F33_ORM%2Fproject)

---

**Version** _20260906v1_
