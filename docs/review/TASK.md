---
hide:
  - navigation
---

# "*Lieferantenangebote mit XML vergleichen*" - Taskdescription

## Einführung

Das Bistro **Küche & Bar** bestellt regelmäßig Verbrauchsmaterial. Für **1.000 Papierbecher
à 300 ml** liegt neben dem Angebot des bisherigen österreichischen Lieferanten je ein
Angebot aus Polen und Tschechien vor. Alle drei Angebote erfüllen dieselben Vorgaben
zu Menge, Qualität und Lieferfrist. Preise, Währungen und Versandkosten unterscheiden sich.

Ein größerer Kreis möglicher Lieferanten eröffnet zusätzliche Bezugsquellen. Ein niedriger
Zahlenwert auf einem Angebot zeigt aber noch keine Ersparnis: Erst nach Währungsumrechnung
und Einbeziehung des Versands sind die Kosten vergleichbar. Bei regelmäßigen Bestellungen
können sich solche Unterschiede summieren.

**Dein Auftrag:** Bereite Wechselkursdaten eines Webservices als eigenes XML-Dokument
für den bereitgestellten Preisvergleichsrechner auf. Sichere dessen Struktur mit einer
eigenen DTD ab und empfehle dem Bistro einen Lieferanten anhand der Gesamtkosten.
Du bearbeitest **eine zusammenhängende GK-Aufgabe in 4 Unterrichtseinheiten à 50 Minuten**.

## Ziele

* Eine XML-Antwort eines Webservices abrufen und die benötigten Daten darin erkennen.
* Ein eigenes XML-Dokument nach einem vereinbarten Austauschformat erstellen.
* Mit einer selbst erstellten DTD die Struktur prüfen und Syntax- von Strukturfehlern unterscheiden.
* Die selbst aufbereiteten Daten in einer Anwendung nutzen und eine Einkaufsentscheidung begründen.

## Kompetenzzuordnung

#### GK INSY – Integration von Informationssystemen

Bezug zum [Lehrplan, 7. Semester](https://github.com/TGM-HIT/insy-exercises/blob/main/docs/Lehrplan.md): „Daten aus Informationssystemen
darstellen und interpretieren“. Das Erzeugen valider semistrukturierter Dokumente greift
eine im Lehrplan bereits im 5. Semester genannte Kompetenz auf.

Die GK-Zuordnung dieser Übung umfasst das Abrufen, strukturierte Bereitstellen, Validieren
und Interpretieren der Daten. Es werden ausschließlich Grundanforderungen bewertet.

## Voraussetzungen

* Grundkenntnisse zu XML-Elementen, Attributen und Verschachtelung sowie eine kurze Einführung in DTD.
* Dateien mit einem Texteditor bearbeiten und vorgegebene Befehle ausführen können.
* Browser, Texteditor und **bereits installiertes Python 3.14**; Internet für den Abruf.

Lade die [Projekt-Dateien](https://download-directory.github.io/?url=https%3A%2F%2Fgithub.com%2FTGM-HIT%2Finsy-exercises%2Ftree%2Fmain%2Fdocs%2Freview%2Fproject) herunter und öffne den enthaltenen Projektordner.
Die Arbeitsdateien stehen gesammelt in [project/](project/HILFE.md). Arbeite dort;
der [Rechner](project/index.html), Abruf und Prüfwerkzeug sind fertig bereitgestellt.
Du programmierst keine Anwendung; DOM, Parserentwicklung, XPath und XSLT sind kein Arbeitsauftrag.

<details class="info">
<summary>Einrichtung und Befehle – etwa zehn Minuten</summary>

<p>Öffne ein Terminal im Projektordner <code>project</code>. Unter Windows / PowerShell:</p>
<pre><code class="language-powershell">py -3.14 -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
</code></pre>
<p>In den folgenden Befehlen steht <code>python</code> für <code>.\.venv\Scripts\python.exe</code>.
Falls der Launcher die vorhandene Installation nicht findet, verwende beim ersten Befehl
den vollständigen Pfad zur <code>python.exe</code>, mit <code>&amp;</code> vor dem Pfad in Anführungszeichen.
Linux/macOS: <code>python3.14 -m venv .venv</code>, danach <code>.venv/bin/python</code> verwenden.
Die Einrichtung unter macOS wurde nicht separat getestet.</p>
<p>Der Rechner lässt sich auch ohne Server durch Öffnen von <code>index.html</code> im Projektordner nutzen.
Eine Internetverbindung benötigt er nach dem Laden nicht. Hinweise stehen in <code>HILFE.md</code>.</p>

</details>

## Detaillierte Aufgabenbeschreibung

### Grundanforderungen

**Ein Datenfluss, eine Abgabe:** Webservice → eigenes XML → DTD-Prüfung → Preisvergleich → Empfehlung.
Behalte die empfangene Originalantwort unverändert. Alle eigenen XML- und DTD-Dateien
entstehen in `arbeit/`. Ergänze die kurze Vorlage `DOKUMENTATION.md` während der Bearbeitung.

| Unterrichtseinheit | Arbeit am gemeinsamen Auftrag |
| --- | --- |
| 1 | Einrichtung, Webservice abfragen und Daten verstehen – 50 Minuten |
| 2 | Eigenes XML erstellen und Fragen 1–3 bearbeiten – 50 Minuten |
| 3 | Eigene DTD erstellen, validieren und Fragen 4–5 bearbeiten – 50 Minuten |
| 4 | Fehlerprüfungen, Fragen 6–7, Angebotsvergleich, Dokumentation und Abgabe – 50 Minuten |

#### 1. Wechselkurse für den Einkauf beschaffen

<details class="example">
<summary>Webservice abfragen und die benötigten Werte finden</summary>

<p>Rufe die <a href="https://api.nbp.pl/api/exchangerates/tables/a/?format=xml">XML-Kurstabelle der polnischen Nationalbank</a>
mit dem fertigen Werkzeug ab:</p>
<pre><code class="language-bash">python abrufen.py
</code></pre>
<p>Die Antwort wird als <code>quellen/nbp-antwort.xml</code> gespeichert. Das Werkzeug führt eine
HTTP-GET-Anfrage aus; <code>format=xml</code> fordert die XML-Darstellung an. Notiere die Anfrage-URL,
das Kursdatum aus <code>EffectiveDate</code> und die beiden <code>Mid</code>-Werte zu <code>EUR</code> und <code>CZK</code>.
Suche dafür im Editor nach den zugehörigen <code>Code</code>-Elementen.</p>
<p><strong>Kursrichtung:</strong> Die NBP-Werte geben an, wie viele <strong>PLN eine Einheit der jeweiligen
Währung</strong> wert ist. Der PLN-Kurs selbst ist deshalb <code>1</code>. EUR und CZK müssen aus derselben
Antwort stammen. Das Kursdatum ist der Veröffentlichungstag der Tabelle und kann vor dem Abrufdatum liegen.</p>
<p>Falls der Abruf scheitert, verwende die mitgelieferte Originalantwort aus <code>ersatzdaten/</code>
als <code>quellen/nbp-antwort.xml</code> und kennzeichne dies in der Dokumentation.
Lege den Ordner <code>quellen</code> bei Bedarf selbst an. Ihr verwendet
dann historische Beispielkurse. Dies ersetzt den Liveabruf gleichwertig bei einem Dienstausfall.</p>

</details>

#### 2. Ein eigenes XML-Dokument für den Rechner erstellen

<details class="example">
<summary>Die Daten selbst in das vereinbarte Austauschformat bringen</summary>

<p>Erstelle <code>arbeit/wechselkurse.xml</code> selbst im Texteditor. Die Datei im Material enthält
nur einen Arbeitskommentar. Übernimm die benötigten Werte manuell aus der Originalantwort
und beachte den <a href="https://github.com/TGM-HIT/insy-exercises/blob/main/docs/review/project/HILFE.md#austauschformat">Datenvertrag</a>:</p>
<ul>
<li>Wurzelelement <code>wechselkurse</code> mit den Attributen <code>basis="PLN"</code> und <code>datum</code>.</li>
<li>Zuerst ein Element <code>quelle</code> mit der verwendeten Anfrage-URL als Text.</li>
<li>Danach drei <code>kurs</code>-Elemente mit dem Attribut <code>waehrung</code>: je eines für EUR, CZK und PLN.
  Der jeweilige Zahlenwert steht als Elementtext; verwende einen Dezimalpunkt.</li>
<li>Am Ende darf ein optionales Element <code>hinweis</code> mit einer kurzen Anmerkung stehen.</li>
</ul>
<p>Speichere als UTF-8. Die Namen und Reihenfolge sind vereinbart, damit der Rechner deine
Datei versteht. Du erzeugst das Dokument selbst; eine fertige Lösung wird nicht mitgeliefert.
Prüfe die Wohlgeformtheit:</p>
<pre><code class="language-bash">python pruefen.py xml arbeit/wechselkurse.xml
</code></pre>

</details>

#### 3. Das eigene Austauschformat mit einer DTD absichern

<details class="example">
<summary>Eigene DTD erstellen und einen erfolgreichen Test nachweisen</summary>

<p>Erstelle <code>arbeit/wechselkurse.dtd</code>. Beschreibe alle vier Elementtypen und die Attribute
aus dem Datenvertrag. Für die Struktur gilt: genau eine Quelle, danach <strong>ein oder mehrere</strong>
Kurse und zuletzt <strong>null oder ein</strong> Hinweis. Die Attribute <code>basis</code>, <code>datum</code> und <code>waehrung</code>
sind erforderlich; für <code>basis</code> ist nur PLN, für <code>waehrung</code> sind EUR, CZK und PLN erlaubt.</p>
<p>Hilfen: <code>,</code> beschreibt eine Reihenfolge, <code>+</code> mindestens ein Vorkommen, <code>?</code> ein optionales
Vorkommen, <code>#PCDATA</code> Text und <code>#REQUIRED</code> ein Pflichtattribut. Eine Enumeration beschreibt
die erlaubten Attributwerte. Eine kurze Syntaxreferenz steht in <code>HILFE.md</code> unter „DTD-Hilfe“.</p>
<pre><code class="language-bash">python pruefen.py dtd arbeit/wechselkurse.xml arbeit/wechselkurse.dtd
</code></pre>
<p>Die DTD wird separat übergeben. Ergänze keinen DOCTYPE im XML. Der erfolgreiche Test
bestätigt die von deiner DTD beschriebenen Strukturregeln. Zahlenwerte, Datum und die
Vollständigkeit der drei unterschiedlichen Währungen prüft der Rechner zusätzlich.</p>

</details>

#### 4. Prüfen, vergleichen und eine Entscheidung treffen

<details class="example">
<summary>Zwei Fehler nachweisen und das eigene XML praktisch verwenden</summary>

<p>Erstelle aus deinem fertigen XML zwei getrennte Kopien. Das Original bleibt korrekt:</p>
<table>
<thead>
<tr>
<th>Testdatei</th>
<th>Gezielte Änderung</th>
<th>Erwartung</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>arbeit/syntaxfehler.xml</code></td>
<td>Ein schließendes Tag passt nicht mehr zum öffnenden Tag.</td>
<td>XML-Prüfung schlägt fehl.</td>
</tr>
<tr>
<td><code>arbeit/strukturfehler.xml</code></td>
<td>Entferne das vollständige Element <code>quelle</code>.</td>
<td>XML-Prüfung erfolgreich, DTD-Prüfung schlägt fehl.</td>
</tr>
</tbody>
</table>
<p>Prüfe die Kopien mit denselben Werkzeugbefehlen und angepassten Dateinamen. Notiere
zusammen mit dem erfolgreichen Originaltest <strong>drei Testzeilen</strong> mit Soll, Ist und Erklärung.</p>
<p>Öffne anschließend <code>index.html</code> und lade dein <strong>korrektes</strong> <code>arbeit/wechselkurse.xml</code>.
Verwende die bereits eingetragenen, fiktiven Angebote:</p>
<table>
<thead>
<tr>
<th>Lieferant</th>
<th>Land</th>
<th>Warenpreis für 1.000 Becher</th>
<th>Versand</th>
</tr>
</thead>
<tbody>
<tr>
<td>AT – bisheriger Lieferant</td>
<td>Österreich</td>
<td>180,00 EUR</td>
<td>12,00 EUR</td>
</tr>
<tr>
<td>PL</td>
<td>Polen</td>
<td>760,00 PLN</td>
<td>90,00 PLN</td>
</tr>
<tr>
<td>CZ</td>
<td>Tschechien</td>
<td>3.900,00 CZK</td>
<td>250,00 CZK</td>
</tr>
</tbody>
</table>
<p>Alle Preise sind Nettopreise für dieselbe Menge und Spezifikation. Für diesen vereinfachten
Vergleich werden Warenpreis und Versand berücksichtigt; Steuern, Bankgebühren und
weitere Kosten werden nicht modelliert. Gleiche Qualität und Lieferfrist sind vorgegeben.</p>
<p>Der Rechner zeigt Kurse, Quelle und Datum, die Gesamtkosten in Euro sowie die Ersparnis
gegenüber AT. Er nutzt deine XML-Daten und prüft deren Format und Werte. <strong>Die DTD-Prüfung
aus Schritt 3 bleibt ein eigener Nachweis; der Browser führt sie nicht aus.</strong></p>
<p>Kontrolliere den Euro-Gesamtbetrag von <strong>Lieferant PL oder CZ</strong> mit dem Rechenweg
<code>(Warenpreis + Versand) × PLN-Kurs der Angebotswährung ÷ PLN-Kurs von EUR</code>.
Runde erst das Endergebnis auf Cent. Sichere einen Screenshot der Vergleichsansicht.
Empfiehl in zwei bis drei Sätzen einen Lieferanten und nenne die Ersparnis gegenüber AT.
Bei gleichen angezeigten Gesamtkosten ist der Gleichstand zu benennen.</p>

</details>

## Fragestellungen

### Grundlegend

Die sieben Fragen prüfen das **grundlegende Verständnis von XML und DTD**. Die
Schwierigkeit bezeichnet die Anforderung innerhalb dieser GK-Aufgabe; auch 3/5
ist hier keine erweiterte Kompetenz. Bearbeite die Fragen bei den passenden
Arbeitsschritten und plane insgesamt etwa **15–20 Minuten innerhalb der vier UE** ein.
Bei 1/5 genügen Stichpunkte, bei 2/5 und 3/5 jeweils ein bis drei kurze Sätze.

1. **[1/5] Wurzelelement:** Was ist das Wurzelelement eines XML-Dokuments? Nenne das Wurzelelement deiner Wechselkursdatei.
2. **[1/5] Element, Attribut und Text:** Benenne in `<kurs waehrung="EUR">4.4070</kurs>` den Elementnamen, den Attributnamen, den Attributwert und den Textinhalt.
3. **[1/5] Zweck einer DTD:** Was legt eine DTD für ein XML-Dokument fest? Nenne eine Strukturregel aus deiner eigenen DTD.
4. **[2/5] Häufigkeit und Reihenfolge:** Erkläre `kurs+` und `hinweis?` in deiner DTD. Darf ein Dokument keinen Kurs enthalten? Darf der Hinweis fehlen? Darf ein vorhandener Hinweis vor den Kursen stehen? Begründe mit der festgelegten Reihenfolge.
5. **[2/5] Pflichtattribut und erlaubte Werte:** Was bewirken `#REQUIRED` und `(EUR|CZK|PLN)` beim Attribut `waehrung`? Ist ein Kurs ohne dieses Attribut beziehungsweise mit `waehrung="USD"` nach deiner DTD gültig? Begründe kurz.
6. **[3/5] Wohlgeformt oder DTD-gültig:** Gehe von deinem korrekten XML und einer passenden DTD aus. In Kopie A wird ein Endtag `</kurs>` durch `</kurs_falsch>` ersetzt. In Kopie B wird das vollständige Element `quelle` entfernt. Welche Kopie ist wohlgeformt, welche ist DTD-gültig? Erkläre den Unterschied.
7. **[3/5] Grenze der DTD:** Ein Kurs enthält den Text `-4.4070`. Das Element ist in der DTD mit `#PCDATA` beschrieben; die übrige Datei ist korrekt. Kann das XML wohlgeformt und DTD-gültig sein, obwohl der Rechner es ablehnt? Begründe, was die DTD hier prüft und welche zusätzliche Regel die Anwendung benötigt.

## Abgabe

Gib **eine gemeinsame Abgabe** mit folgenden Dateien ab: `quellen/nbp-antwort.xml`,
`arbeit/wechselkurse.xml`, `arbeit/wechselkurse.dtd`, `arbeit/syntaxfehler.xml`,
`arbeit/strukturfehler.xml`, `DOKUMENTATION.md` und `vergleich.png`.

Die Dokumentation folgt der mitgelieferten Vorlage und bleibt mit kurzen Absätzen,
drei Testzeilen, Kurzantworten und Empfehlung ungefähr **ein bis zwei Seiten plus Screenshot**.
Sie enthält Quelle und Kursdatum, den manuellen Rechencheck sowie Quellen- und KI-Angaben.
Die fertigen Werkzeuge, Bibliotheken und `.venv` werden nicht abgegeben. Die Lehrkraft kann
während der Arbeitszeit eine Strukturregel und den Angebotsvergleich erklären lassen.

## Bewertung

Gruppengröße: **1 Person**. Zeitrahmen: **4 UE à 50 Minuten einschließlich Dokumentation
und Abgabe**. Es gibt eine gemeinsame Bewertung ausschließlich im GK-Bereich.
Die beiden Stufen bauen aufeinander auf. Vorlagen und Hilfen dürfen verwendet werden.
Die [Checkliste](CHECK.md) enthält dieselben Kriterien.

### Grundanforderungen **überwiegend erfüllt**

- [ ] 1. Webservice-Antwort beschafft; Anfrage, Kursdatum und die benötigten EUR-/CZK-Werte nachvollziehbar ermittelt.
- [ ] 2. Eigenes XML mit Quelle, Datum und den drei korrekt zugeordneten Kursen erstellt; Wohlgeformtheit erfolgreich geprüft.
- [ ] 3. Eigene DTD beschreibt Elemente, Reihenfolge, Wiederholung und Pflichtattribute; das korrekte XML besteht die Validierung.
- [ ] 4. Eigenes XML im Rechner verwendet; Gesamtkosten verglichen und eine begründete Lieferantenempfehlung abgegeben.
- [ ] Fragestellungen 1–5 nachvollziehbar beantwortet; XML-Bausteine und grundlegende DTD-Regeln verstanden.
- [ ] Dokumentation

### Grundanforderungen **zur Gänze erfüllt**

- [ ] 3. DTD berücksichtigt erlaubte Attributwerte und den optionalen Hinweis vollständig.
- [ ] 4. Beide Fehlerkopien mit den erwarteten unterschiedlichen Ergebnissen geprüft und in drei Testzeilen einschließlich Original dokumentiert.
- [ ] 4. Einen Gesamtbetrag für PL oder CZ manuell kontrolliert; Ersparnis oder Gleichstand gegenüber AT korrekt erläutert und Vergleichsansicht gesichert.
- [ ] Fragestellungen 1–7 vollständig und fachlich richtig beantwortet; Wohlgeformtheit, DTD-Gültigkeit und fachliche Werteprüfung unterschieden.
- [ ] Dokumentation

*:robot: Diese Aufgabe wurde mithilfe von KI erstellt.*

## Quellen

* Narodowy Bank Polski: „NBP Web API“, Beschreibung der GET-Abfragen, XML-Ausgabe und Kursfelder; zuletzt geprüft am 13.11.2026; [online](https://api.nbp.pl/en.html).
* W3C: „Extensible Markup Language (XML) 1.0, Fifth Edition“, XML-Syntax und DTD-Regeln; zuletzt geprüft am 13.11.2026; [online](https://www.w3.org/TR/xml/).
* MDN Web Docs: „XML introduction“, Einführung in XML-Dokumente; zuletzt geprüft am 13.11.2026; [online](https://developer.mozilla.org/en-US/docs/Web/XML/Guides/XML_introduction).
* lxml: „Validation“, explizite DTD-Validierung im bereitgestellten Prüfwerkzeug; zuletzt geprüft am 13.11.2026; [online](https://lxml.de/validation.html).

Die Angebote sind eigens erstellte Unterrichtsbeispiele. Frühere Aufgabenstände stehen
im [Archiv des gesicherten Aufgabenstands](https://github.com/TGM-HIT/insy-exercises/blob/27704ddaa452e5c4dbe284fbcca831c747924591/docs/review/archiv/2026-11-13/index.md).

---

**Version** *20261113v3*
