# Quellen und Versionsentscheidungen

Geprüft am **13.09.2026**. Dieses Modul verwendet eigene synthetische Beispieldaten;
es werden keine realen Lieferanten-, Kunden- oder Zugangsdaten benötigt.

## Datenformate im Vergleich

- IETF: [RFC 8259 – JSON](https://www.rfc-editor.org/rfc/rfc8259).
- IETF: [RFC 4180 – CSV](https://www.rfc-editor.org/rfc/rfc4180). Der RFC ist eine informative
  Beschreibung verbreiteter Konventionen; CSV besitzt weiterhin unterschiedliche Dialekte.
  Der Datenvertrag legt unseren Dialekt ausdrücklich fest.
- Python 3.14: [csv](https://docs.python.org/3.14/library/csv.html) und
  [json](https://docs.python.org/3.14/library/json.html).

## XML, DTD und DOM

- W3C: [XML 1.0, fünfte Ausgabe](https://www.w3.org/TR/xml/), einschließlich DTD-Regeln.
  Die Spezifikation stammt von 2008 und bleibt die bewusst gewählte stabile Grundlage.
  XML 1.1 ist für diese Daten nicht erforderlich.
- W3C: [Namespaces in XML 1.0](https://www.w3.org/TR/xml-names/).
- Python 3.14: [DOM / minidom](https://docs.python.org/3.14/library/xml.dom.minidom.html).
  Das ist eine Python-Implementierung einer DOM-Teilmenge, kein Browser-DOM mit Web-APIs.
- lxml: [DTD-Validierung](https://lxml.de/validation.html) und [Parsing](https://lxml.de/parsing.html).

## Parsing und Werkzeugversionen

- Python: [verfügbare Versionen](https://www.python.org/downloads/),
  [ElementTree und iterparse](https://docs.python.org/3.14/library/xml.etree.elementtree.html),
  [Dezimalarithmetik](https://docs.python.org/3.14/library/decimal.html) und
  [tracemalloc](https://docs.python.org/3.14/library/tracemalloc.html).
- Python 3.14: [XML-Verarbeitung und Sicherheitsaspekte](https://docs.python.org/3.14/library/xml.html).
- defusedxml: [Projekt und Parseroptionen](https://github.com/tiran/defusedxml),
  [Paketversion 0.7.1](https://pypi.org/project/defusedxml/0.7.1/). Die ältere Versionsnummer
  ist weiterhin der veröffentlichte stabile Paketstand; die verwendeten Aufrufe werden mit Python 3.14 getestet.
- lxml: [Projekt](https://lxml.de/) und [Paketversion 6.1.3](https://pypi.org/project/lxml/6.1.3/).
  Für XML und DTD eingesetzt; sein eingebauter XPath-/XSLT-Prozessor beschränkt sich auf 1.0.
- Docker: [offizielles Python-Image](https://hub.docker.com/_/python) und [Compose](https://docs.docker.com/compose/).

## XPath und XSLT

- W3C: [XPath 3.1](https://www.w3.org/TR/xpath-31/) und [XSLT 3.0](https://www.w3.org/TR/xslt-30/).
  Die lange XSLT-Spezifikation ist eine Referenz; sie muss nicht vollständig gelesen werden.
- Saxonica: [SaxonC-13-Python-API](https://www.saxonica.com/saxon-c/doc13/python/index.html),
  [Dokumentationsübersicht](https://www.saxonica.com/html/documentation13/about/index.html)
  und [Paketversion SaxonC-HE 13.0.0](https://pypi.org/project/saxonche/13.0.0/).
  HE unterstützt die hier eingesetzten XPath-3.1-/XSLT-3.0-Funktionen ohne kostenpflichtige Lizenz.
  Die Aufgabe benötigt weder Schema-Awareness noch XSLT-Streaming der kostenpflichtigen Editionen.
- Chrome for Developers: [Entfernung nativer XSLT-Unterstützung](https://developer.chrome.com/docs/web-platform/deprecating-xslt).
  Deshalb wird lokal transformiert und anschließend nur das entstandene HTML im Browser geöffnet.

Die Paketversionen stehen in [requirements.txt](requirements.txt) und identisch im
[Material-ZIP](material.zip). Vor einem späteren Unterrichtsdurchlauf sind Sicherheitsupdates
erneut zu prüfen. Versionsnummern von Standards und Versionen ihrer Implementierungen sind
unterschiedliche Dinge: Eine neue Bibliotheksversion erfordert nicht automatisch einen anderen XML-Standard.
