# Checkliste: PostgreSQL Benutzerverwaltung

## Grundlegend überwiegend

- [ ] Datenbank-Umgebung mittels Docker Compose erfolgreich gestartet und Prozess erklärt
- [ ] Rollen Kunde, Mitarbeiter, Admin und Redakteur angelegt
- [ ] Berechtigungen für Zahlungen (einsehen, anlegen, ändern, löschen) korrekt vergeben und protokolliert
- [ ] Zugriffsbeschränkung auf die Spalte `replacement_cost` umgesetzt
- [ ] Dokumentation

## Grundlegend vollständig

- [ ] Individuelle Accounts für Mitarbeiter und Redakteure angelegt
- [ ] Zugriffskontrolle über `pg_hba.conf` (unsicherer Rechner blockiert, SSL-Zwang) umgesetzt und getestet
- [ ] Marketing-Zugriff auf aktive Kunden-E-Mails mittels View gelöst
- [ ] Index.html verknüpft
- [ ] Dokumentation
