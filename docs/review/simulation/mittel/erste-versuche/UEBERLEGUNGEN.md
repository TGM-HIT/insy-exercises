# Erste Überlegungen – didaktisch modelliert

Dieses Dokument rekonstruiert einen plausiblen Arbeitsstand eines mittelguten Profils. Es stammt nicht von einer real beobachteten Schülerin oder einem real beobachteten Schüler.

- Im Original stehen EUR 4.4070 und CZK 0.1806. Die Werte bedeuten PLN je EUR bzw. PLN je CZK, darum kommt PLN mit 1 dazu.
- Der erste XML-Versuch übernimmt diese Daten und das Datum 2026-11-13. Einen Hinweis ergänze ich erst in der Revision, damit die Offline-Basis erkennbar ist.
- DTD: `quelle, kurs, hinweis?` sollte zunächst heißen: erst die Quelle, dann die Kurse und eventuell ein Hinweis. Ich habe dabei zunächst übersehen, dass `kurs` ohne Zeichen nur einmal vorkommen darf.
- Nach dem echten Prüfergebnis 02: Es werden drei Kurse gefunden, obwohl nur einer erwartet wird. In DTD-HILFE.md steht `+` für mindestens einmal. Ich ändere daher nur die Häufigkeit auf `kurs+`.
- Erste Antwortidee zu Frage 7: „Ein negativer Kurs ist falsch; wahrscheinlich ist er auch DTD-ungültig.“ Unsicherheit: Prüft `#PCDATA` überhaupt den Inhalt einer Zahl?
- Ein modellierter Lehrkraftimpuls: „Schau in der DTD-Hilfe nach, was `#PCDATA` zusichert, und vergleiche es mit den Wertregeln im Datenvertrag.“
- Danach: `#PCDATA` heißt nur Text. Ich habe die fachliche Bedeutung mit der Strukturprüfung verwechselt. Die positive Zahl muss der Rechner zusätzlich verlangen.