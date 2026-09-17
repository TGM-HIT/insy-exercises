# Checkliste: ORM mit Django

## Grundlegend überwiegend

- [ ] Projekt lauffähig gemacht (venv oder Docker) und Pakete installiert
- [ ] Datenmodelle (User, Recipe, Ingredient, Contain) in `models.py` angelegt
- [ ] Modelle im Admin-Backend registriert und Adminbenutzer erstellt
- [ ] Demorezepte über das Admin-Backend angelegt
- [ ] Dokumentation

## Grundlegend vollständig

- [ ] Views für Index, `/recipe/[id]` und `/by-ingredient/[id]` implementiert
- [ ] Endpoint `/new` zum Anlegen neuer Rezepte via POST-Request implementiert
- [ ] Endpoint `/remove/<id>` zum Löschen von Rezepten implementiert
- [ ] Demorezepte mittels `dumpdata` exportiert
- [ ] Fragestellungen beantwortet
- [ ] Abgabegespräch über die Aufgaben- und Fragestellungen
- [ ] Dokumentation

## Erweitert überwiegend

- [ ] Rezepttyp mittels Vererbung (Essen / Trinken) statt als Attribut umgesetzt
- [ ] Zusätzliche Eigenschaften je Rezepttyp (Kohlensäure/Alkohol bzw. Kalorien) gespeichert
- [ ] Dokumentation

## Erweitert vollständig

- [ ] Endpoints für Index, `/recipe/[id]` und `/by-ingredient/[id]` an die neue Vererbungsstruktur angepasst
- [ ] Ausführung sowohl über venv als auch über Docker gelöst und erklärt
- [ ] Dokumentation
