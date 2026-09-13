# Checkliste: PostgreSQL Benutzerverwaltung

## Grundlegend überwiegend

- [ ] Umgebung gestartet; Erstinitialisierung und Reset nachvollziehbar erklärt.
- [ ] Gruppenrollen angelegt und Berechtigungsmatrix aus den Geschäftsregeln selbst abgeleitet.
- [ ] Zahlungsrechte einschließlich notwendiger Sequenzrechte korrekt umgesetzt.
- [ ] Kunden- und Redakteurbeschränkungen auf `film` korrekt umgesetzt.
- [ ] Erlaubte und abgewiesene Objektzugriffe unter normalen Accounts dokumentiert; Lernversuch zu Spaltenrechten mit Vorhersage und Erklärung ausgewertet.

## Grundlegend vollständig

- [ ] Alle geforderten persönlichen Accounts korrekt zugeordnet; keine ungewollte Rechteweitergabe.
- [ ] IP-Sperre und TLS-Pflicht umgesetzt; alle Fälle der Verbindungstestmatrix nachgewiesen.
- [ ] Marketing-Zugriff über eine geschützte View vollständig umgesetzt und getestet.
- [ ] Marketing-Zugriff über RLS **und** Spaltenrechte vollständig umgesetzt und getestet.
- [ ] Beide Marketing-Varianten funktionieren gemeinsam und sind über getrennte Accounts nachgewiesen.
- [ ] Lernversuch zu RLS ohne Policy mit Vorhersage und Erklärung ausgewertet.
- [ ] Eigene zusätzliche Rolle fachlich begründet, mit minimalen Rechten umgesetzt und positiv sowie negativ getestet.
- [ ] Lösung mit den abgegebenen Dateien reproduzierbar; Kontrollfragen verständlich beantwortet und eine kurze Transferaufgabe selbstständig umgesetzt.
