# Aufgabenstellung ORM mit Django

## Ausgangslage

Gegeben ist ein kleines Django-Projekt `recipes`, das im Wesentlichen aus einer App `backend` besteht. Ziel der Übung ist es, das Projekt zunächst bei euch laufen zu lassen und dann mittels Django ORM passende Models anzulegen und daraus die Datenbank generieren zu lassen, sowie einfache Abfragen zu formulieren.

## Arbeitsschritte

- Lade zunächst das Projekt herunter, initialisiere ein _virtual environment_ und installiere mittels `pip install -r requirements.txt` die entsprechenden Pakete.
- Starte das Projekt mittels `./manage.py runserver`.
- Lege in der `backend/models.py` entsprechende Modelle für Rezepte an (siehe unten).
- Füge in der `backend/admin.py` deine Modelle hinzu (`admin.site.register(<Modellname>)`).
- Erstelle einen Adminbenutzer mittels `./manage.py createsuperuser`.
- Rufe das Admin-Backend unter `http://127.0.0.1:8000/admin` auf und erstelle ein paar Demorezepte.
- Passe die `backend/views.py` dementsprechend an, dass die Rezepte aus der Datenbank gelesen und angezeigt werden.
- Exportiere deine Demorezepte mittels `./manage.py dumpdata backend > recipes.json`.

### Alternative: Ausführung in Docker

Anstelle eines lokalen _virtual environment_ kann das Projekt auch in einem Docker-Container laufen. Dazu im Projektverzeichnis (dort, wo `manage.py` liegt) folgende Dateien anlegen:

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

### Datenmodell

Folgende Klassen sollen zumindest vorhanden sein:

- **User**: ein Benutzer (`auth.User` existiert bereits)
- **Recipe**: ein Rezept, besitzt einen Namen, mehrere Zutaten, einen Typ und eine Kochanleitung. Ein Rezept kann von einem oder mehreren Benutzern geliked werden.
- **Ingredient**: eine Zutat, besitzt einen Namen
- **Contain**: das Vorkommen einer Zutat in einem Rezept mit einer bestimmten Anzahl und einer Einheit (optional)

## Frontend-Endpoints

Baue das Frontend wie folgt ein um:

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

### Hints

- URLs mit Parametern lassen sich in der `urls.py` zum Beispiel wie folgt definieren: `path("recipe/<int:recipeid>", views.recipe, name="recipe")`. Im View bekommt man diesen Parameter dann extra übergeben: `def recipe(request, recipeid):`

- Auf den Body lässt sich bei einem POST-Request in der `views.py` mittels `request.body` zugreifen und dann mittels `json.loads()` in JSON konvertieren. Für die Übung muss die Methode in der `views.py` mit `@csrf_exempt` annotiert werden. Der Aufruf lässt sich dann z. B. mittels Postman und einem JSON-Dokument im Request-Body testen oder auch mittels `curl` mit folgenden Parametern:

  ```
  curl -X POST -H "Content-Type: application/json" --data '{"a":"b"}' "http://127.0.0.1:8000/new"

  curl -X POST -H "Content-Type: application/json" --data '{"name":"Test Rezept","type":"food","instructions":"Testen","ingredients":[]}' "http://127.0.0.1:8000/new"
  ```

## Erweitert

Ändere das Datenmodell deiner Django-Anwendung wie folgt:

- Der Typ eines Recipes soll nicht mehr als Attribut abgespeichert werden.
- Verschiedene Rezepttypen (Essen / Trinken) sollen stattdessen mittels Vererbung realisiert werden. Wähle dabei eine geeignete Realisierung der Vererbung mit Django ORM.
- Für Getränkerezepte soll dabei gespeichert werden, ob das Getränk Kohlensäure bzw. Alkohol enthält.
- Für Essen soll dabei die Menge an Kalorien gespeichert werden.

Ändere die Endpunkte für Index, `/recipe/[id]` und `/by-ingredient/[id]` so ab, dass beide Rezepttypen samt ihren zusätzlichen Eigenschaften angezeigt werden.

Außerdem ist die Ausführung über venv als auch über Docker zu lösen als auch zu erklären.

### Hints

Die Pakete [django-model-utils](https://github.com/jazzband/django-model-utils) oder [django-polymorphic](https://github.com/jazzband/django-polymorphic) können bei der Nutzung von Polymorphie bei der Vererbung helfen.

## Quellen

- [Django Dokumentation Models](https://docs.djangoproject.com/en/5.2/topics/db/models/)
- [Django Dokumentation Queries](https://docs.djangoproject.com/en/5.2/topics/db/queries/)
- [django-model-utils](https://github.com/jazzband/django-model-utils)
- [django-polymorphic](https://github.com/jazzband/django-polymorphic)
