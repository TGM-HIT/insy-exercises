# Kleine DTD-Syntaxhilfe

Formuliere die Regeln für deine Wechselkursdatei selbst. Die folgenden unabhängigen
Beispiele zeigen nur die Schreibweise anhand einer Messwertdatei.

```dtd
<!ELEMENT messung (ort, wert+, notiz?)>
<!ELEMENT ort (#PCDATA)>
<!ELEMENT wert (#PCDATA)>
<!ELEMENT notiz (#PCDATA)>
<!ATTLIST wert einheit (C|K) #REQUIRED>
<!ATTLIST messung kennung CDATA #REQUIRED>
```

* `ELEMENT` deklariert einen Elementtyp; alle vorkommenden Typen brauchen eine Deklaration.
* Das Komma legt die Reihenfolge fest.
* Ohne Zusatz kommt ein Element genau einmal vor; `+` bedeutet mindestens einmal,
  `?` bedeutet null oder einmal, `*` bedeutet null bis beliebig oft.
* `#PCDATA` erlaubt Textinhalt. Es ist keine Zahlenprüfung.
* `ATTLIST` beschreibt Attribute eines Elements; `#REQUIRED` verlangt ihre Angabe.
* `(C|K)` beschränkt den Attributwert auf eine der angegebenen Möglichkeiten.
* `CDATA` erlaubt Attributtext und kontrolliert kein Datumsformat.

Speichere deine DTD separat und übergib sie dem Prüfwerkzeug. Eine DOCTYPE-Angabe
im XML ist für diesen Arbeitsablauf nicht erforderlich.

Quelle: W3C, „Extensible Markup Language (XML) 1.0, Fifth Edition“, Abschnitt 3,
zuletzt geprüft am 13.11.2026, [online](https://www.w3.org/TR/xml/#sec-logical-struct).
