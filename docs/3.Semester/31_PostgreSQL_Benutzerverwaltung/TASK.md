---
hide:
  - navigation
---

# "_PostgreSQL Benutzerverwaltung_" - Taskdescription

## Einführung

Wer darf Zahlungen erfassen, Filmdaten bearbeiten oder Kundendaten lesen? In dieser Übung setzt ihr ein Berechtigungskonzept für eine DVD-Verleihdatenbank um. Ihr verwendet Gruppenrollen und persönliche Datenbankaccounts, schützt Netzwerkverbindungen mit TLS und beschränkt den Datenzugriff auf Tabellen-, Spalten- und Zeilenebene.

Die Beispieldatenbank `dvdrental` bleibt bewusst überschaubar. Die eingesetzten Techniken gehören zur aktuellen PostgreSQL-Benutzer- und Rechteverwaltung.

## Ziele

Nach der Übung könnt ihr:

- Rollen und persönliche Accounts unterscheiden und sinnvoll zuordnen;
- mit `GRANT` und `REVOKE` ein Konzept nach dem Prinzip der geringsten notwendigen Rechte umsetzen;
- die tatsächlich wirksamen Rechte mit erfolgreichen und abgewiesenen Zugriffen überprüfen;
- mit `pg_hba.conf` einen Testclient sperren und TLS für TCP/IP-Verbindungen erzwingen;
- eine View als eingeschränkten Zugang und Row-Level Security (RLS) in Kombination mit Spaltenrechten einsetzen;
- den automatischen Datenimport und die Folgen eines vollständigen Resets erklären.

## Kompetenzzuordnung

### GK INSY Datenbanksysteme – Benutzer- und Rechteverwaltung

- Rollen und Berechtigungen in einem Datenbankmanagementsystem planen und mittels SQL umsetzen.
- Den Datenbankzugriff über `pg_hba.conf` einschränken und absichern.
- Zugriffsbeschränkungen auf Zeilen- und Spaltenebene mittels Views, Policies und Spaltenrechten realisieren.

## Voraussetzungen

- Grundkenntnisse in `SELECT`, `INSERT`, `UPDATE`, `DELETE` und Fremdschlüsseln.
- Grundverständnis von Client, Server, IP-Adresse und Port.
- Docker mit laufender Linux-Container-Engine und Docker Compose v2 oder neuer.
- Ein Editor, ein Browser und ein Terminal. Ein lokal installiertes PostgreSQL oder OpenSSL ist nicht erforderlich.

## Detaillierte Aufgabenbeschreibung

Erstellt ein verständliches Protokoll mit SQL, Konfigurationsausschnitten, erwarteten Ergebnissen und tatsächlich beobachteten Ergebnissen. Führt die Lösung beim Abgabegespräch auf der eigenen Maschine vor.

**Arbeitsweise: zuerst planen, dann umsetzen, anschließend nachweisen.** Erstellt vor der Rechtevergabe eure Berechtigungsmatrix. Notiert vor jedem Test, was ihr erwartet, und vergleicht es danach mit dem tatsächlichen Ergebnis. Begründet Abweichungen und verbessert eure Lösung.

Die aufklappbaren Hilfen könnt ihr bei Bedarf nacheinander öffnen. Ihre Nutzung führt zu keinem Bewertungsabzug. Haltet bei den zwei Lernversuchen zu Spaltenrechten und RLS jeweils eure erste Vermutung, die Beobachtung und eure daraus abgeleitete Erklärung fest. Ein vollständiges Arbeitstagebuch ist nicht erforderlich.

Bearbeitet zunächst die Aufgaben 1 bis 3 gemeinsam: Zum Prüfen der Rechte aus Aufgabe 2 benötigt ihr die persönlichen Accounts aus Aufgabe 3. Danach folgen die Verbindungsregeln, der Marketing-Zugriff und eine kleine eigene Erweiterung. Die ausdrücklich optionale Vertiefung ist keine Voraussetzung für die vollständige Erfüllung der Grundanforderungen.

Die Umgebung verwendet **PostgreSQL 18.6** und **pgAdmin 4 9.17**. Die Versionsstände sind für diese Ausgabe festgelegt; die Versionswahl und Quellen wurden am **12.09.2026** geprüft.

### Bereitstellung der Datenbank mit Docker Compose

Ladet das [DB-Paket](db.zip) herunter und entpackt es. Alternativ könnt ihr den Ordner `docs/3.Semester/31_PostgreSQL_Benutzerverwaltung/db/` aus dem Kursrepository verwenden.

Das Paket enthält:

| Datei | Zweck |
| --- | --- |
| `compose.yml` | PostgreSQL, pgAdmin und zwei Testclients starten |
| `Dockerfile`, `tls-entrypoint.sh` | PostgreSQL-Image erweitern und ein lokales TLS-Testzertifikat erzeugen |
| `dvdrental.sql` | Originaldatenbank als SQL-Dump |
| `init/20-lab-baseline.sql` | Öffentliche Objektrechte begrenzen und den Datenbestand prüfen |
| `config/pg_hba.conf` | Ausgangskonfiguration für Aufgabe 4 |
| `pgadmin/servers.json` | Datenbankverbindung in pgAdmin vorbereiten |
| `.env.example` | Optionale lokale Zugangsdaten vorgeben |

Wechselt im Terminal in den entpackten Ordner `db` und startet die Umgebung:

```bash
docker compose up -d --build
docker compose ps
docker compose logs postgres
```

Beim ersten Build werden zusätzlich die Werkzeuge zur Zertifikatserstellung installiert. Der Start kann deshalb einige Minuten dauern.

Öffnet pgAdmin unter [http://localhost:8080](http://localhost:8080). Die Standardzugänge für diese lokale Übung sind:

| Zugang | Benutzer | Passwort |
| --- | --- | --- |
| pgAdmin-Weboberfläche | `admin@example.org` | `pgadmin-lab-2026` |
| PostgreSQL-Einrichtung | `postgres` | `postgres-lab-2026` |

Die vorbereitete Serververbindung in pgAdmin verwendet Host `postgres`, Port `5432`, Datenbank `dvdrental` und TLS-Modus `require`. Gebt das PostgreSQL-Passwort beim Verbinden ein. Der Login zur Weboberfläche und ein Datenbanklogin sind unterschiedliche Accounts.

Diese Zugangsdaten sind ausschließlich für die lokale Übung bestimmt. Die veröffentlichten Ports sind an `127.0.0.1` gebunden. Bei einer Portkollision kann in `compose.yml` der Host-Port links geändert werden; der interne Datenbankport bleibt `5432`.

#### Was automatisch vorbereitet wird

Die Startumgebung erzeugt Zertifikat und privaten Schlüssel in einem Docker-Volume und aktiviert TLS im PostgreSQL-Server. Die Schüleraufgabe besteht darin, TLS anschließend über `pg_hba.conf` verpflichtend zu machen. Im Ausgangszustand sind sowohl verschlüsselte als auch unverschlüsselte TCP-Verbindungen mit gültigem Passwort möglich.

`POSTGRES_DB=dvdrental` legt bei der Erstinitialisierung die Zieldatenbank fest. Der Entrypoint des offiziellen PostgreSQL-Images führt die eingebundenen Dateien in `/docker-entrypoint-initdb.d/` in Namensreihenfolge aus. Zuerst wird der Dump importiert, danach die Ausgangslage für die Rechteübung hergestellt. Das geschieht nur bei einem noch nicht initialisierten Datenverzeichnis.

Der Original-Dump enthält unter anderem eine Funktion mit `SECURITY DEFINER`. Die Vorbereitung entzieht `PUBLIC` deshalb die Ausführungsrechte auf die enthaltenen Funktionen. Vergebt diese Rechte in der Übung nicht pauschal neu. Die benötigten Gruppenrollen, Accounts, Views und Policies werden von euch erstellt.

#### Stoppen, Neustarten und Zurücksetzen

```bash
# Container stoppen; Daten und Konfiguration bleiben erhalten
docker compose down

# Mit dem vorhandenen Datenbestand erneut starten
docker compose up -d
```

**Ein vollständiger Reset löscht alle Daten in den projektzugehörigen Volumes**, einschließlich angelegter Rollen, Rechte, Views und Policies, gespeicherter pgAdmin-Einstellungen und des TLS-Testzertifikats:

```bash
docker compose down --volumes
docker compose up -d --build
```

Beim nächsten Start werden Zertifikat und Datenbank neu erzeugt. Auf dem Host gespeicherte Dateien wie `config/pg_hba.conf` und eure SQL-Skripte bleiben erhalten. Für den ursprünglichen Verbindungszustand müsst ihr zusätzlich die Originalfassung von `pg_hba.conf` aus dem Paket wiederherstellen. Ein Reset ist keine Datensicherung. PostgreSQL-Volumes älterer Hauptversionen dürfen nicht einfach in diese Umgebung übernommen werden.

### Datenmodell

![ER-Diagramm der DVD-Verleihdatenbank](db/dvdrental-diagram.png){ width="450" .on-glb }

*Zum Vergrößern auf das Diagramm klicken.* [Originalbild öffnen](db/dvdrental-diagram.png).

**Für diese Übung gilt: Ein Kunde ist aktiv, wenn `customer.active = 1` ist.** Die Spalte `active` hat im gelieferten Dump den Datentyp `integer`. Die zusätzliche boolesche Spalte `activebool` wird für diese Aufgabe nicht verwendet: Sie enthält im Ausgangsdump bei allen Kunden `true` und bildet die geforderte Unterscheidung nicht ab.

Kontrolliert als Einrichtungsaccount die Datentypen und den Ausgangsbestand: 599 Kunden insgesamt, davon 584 mit `active = 1` und 15 mit `active = 0`.

### 1. Rollen und Rechtekonzept

Legt die Gruppenrollen `kunde`, `mitarbeiter`, `admin` und `redakteur` ohne `LOGIN` an. Für die zwei Marketing-Varianten kommen in Aufgabe 5 die voneinander unabhängigen Rollen `marketing_view` und `marketing_rls` hinzu.

`admin` ist ein **fachlicher Administrator**. Er bekommt die unten definierten Objektrechte, aber weder `SUPERUSER`, `CREATEROLE` noch `BYPASSRLS`. Keine Übungsrolle darf Eigentümerin der Basistabellen oder Mitglied der Einrichtungsrolle `postgres` sein. Auch Eigentümerschaften der bereitgestellten Objekte werden nicht auf Übungsaccounts übertragen.

Erstellt aus den Geschäftsregeln in Aufgabe 2 selbst eine Berechtigungsmatrix: Zeilen für Objekte beziehungsweise Spalten und Aktionen, Spalten für Gruppenrollen. Kennzeichnet erlaubte und verbotene Zugriffe. Ergänzt bei der Umsetzung notwendige technische Objektrechte und begründet sie. Rechte auf nicht genannte Tabellen und Funktionen werden nicht zusätzlich vergeben.

### 2. Tabellen- und Spaltenberechtigungen

Leitet aus diesen Geschäftsregeln die benötigten SQL-Rechte ab und setzt sie um:

- **Zahlungen (`payment`):** Mitarbeiter und der fachliche Admin dürfen Zahlungen lesen und erfassen. Nur der Admin darf vorhandene Zahlungen ändern oder löschen. Kunden und Redakteure erhalten keinen Zugriff auf Zahlungen.
- **Filmkatalog (`film`):** Alle vier Rollen dürfen Filminformationen lesen. Die Ersatzkosten (`replacement_cost`) bleiben für Kunden verborgen; Mitarbeiter, Admin und Redakteure dürfen auch diese Spalte lesen.
- **Redaktion:** Redakteure dürfen ausschließlich den Titel (`title`) und die Beschreibung (`description`) vorhandener Filme ändern. Der Admin darf alle Filmspalten ändern. Kunden und Mitarbeiter dürfen keine Filmdaten ändern.
- **Neue und entfernte Filme:** Keine der vier Rollen darf Filme anlegen oder löschen.

Weitere Verwaltungsrechte wie `TRUNCATE`, `TRIGGER`, `MAINTAIN` oder die Weitergabe von Rechten sind nicht Teil dieser Freigaben.

Für den Kunden ist die Beschränkung in dieser Teilaufgabe mit **Spaltenrechten auf `film`** umzusetzen. Das Lesen der erlaubten Spalten muss funktionieren; das Lesen von `replacement_cost` muss scheitern. Erklärt auch das Verhalten von `SELECT *`.

**Lernversuch – schützt ein Spaltenentzug?** Prüft vor der endgültigen Umsetzung die Vermutung: „Wenn eine Rolle die ganze Tabelle lesen darf, kann ich ihr anschließend das Lesen einer einzelnen Spalte verbieten.“ Verwendet dafür eine eigene temporäre Rolle ohne weitere Mitgliedschaften und einen Testaccount. Gewährt zunächst Tabellenleserechte, entzieht dann das Leserecht auf `replacement_cost` und testet mit diesem Account. Notiert zuerst eure Vorhersage. Erklärt danach die Beobachtung und leitet daraus eure endgültige Lösung ab. Entfernt die temporären Rechte und Accounts nach dem Versuch; verwendet dafür nicht die endgültige Kundenrolle.

??? tip "Hilfe 1: Woher stammt ein wirksames Recht?"

    Prüft direkte Rechte, Gruppenmitgliedschaften und Rechte aus `PUBLIC`. Untersucht in der GRANT-/REVOKE-Dokumentation, wie Tabellen- und Spaltenrechte zusammenwirken.

??? tip "Hilfe 2: Tabellen- und Spaltenrechte"

    Rechte aus verschiedenen Quellen addieren sich. `REVOKE` erzeugt kein übergeordnetes Verbot. Ein bestehendes Tabellenleserecht bleibt wirksam, wenn lediglich ein Spaltenrecht entzogen wird. Für die Kundenrolle darf deshalb kein weitergehendes Tabellenleserecht bestehen; vergebt gezielt die erlaubten Spaltenrechte.

??? tip "Hilfe 3: INSERT scheitert trotz Tabellenrecht"

    Lest die genaue Fehlermeldung. Betrifft sie das Schema, die Tabelle, eine Sequenz oder einen Fremdschlüssel? Untersucht den Defaultwert von `payment.payment_id`. Eine automatisch verwendete Sequenz ist ein eigenes Objekt mit eigenen Rechten.

Entwickelt aus eurer Matrix aussagekräftige Tests. Jede erlaubte Aktion der Geschäftsregeln muss mindestens einmal erfolgreich ausgeführt werden. Prüft außerdem für jede Gruppenrolle mindestens einen ausdrücklich verbotenen Zugriff sowie für den Kunden beide Abfragen auf `replacement_cost` und `SELECT *`. Verwendet gültige Fremdschlüsselwerte aus dem vorhandenen Datenbestand: Ein verbotener Zugriff muss an fehlenden Rechten scheitern, nicht an ungültigen Testdaten.

Änderungen für Tests sollen in einer Transaktion erfolgen und anschließend zurückgerollt werden. Sequenzwerte können dabei trotzdem weitergezählt werden.

### 3. Gruppenrollen und persönliche Accounts

Legt mindestens folgende persönliche Datenbankaccounts mit `LOGIN` und Passwort an:

- zwei Mitarbeiteraccounts, zum Beispiel `ma_anna` und `ma_ben`;
- zwei Redakteuraccounts, zum Beispiel `red_lea` und `red_noah`;
- einen Kundenaccount und einen fachlichen Adminaccount;
- je einen getrennten Account für die beiden Marketing-Varianten aus Aufgabe 5.

Ordnet jedem Account ausschließlich die passende Gruppenrolle zu. Die Marketingaccounts sind **keine** Mitglieder von `mitarbeiter`; organisatorische Bezeichnungen bedeuten keine automatische technische Rollenmitgliedschaft. Die Datensätze und Benutzernamen in der Beispieltabelle `staff` sind ebenfalls keine PostgreSQL-Logins.

Vergebt fachliche Rechte an die Gruppenrollen und überprüft, dass die zugehörigen Accounts diese Rechte nutzen können. Erläutert die Vererbung der Rollenrechte. Prüft die Zugriffe über echte Anmeldungen als jeweiliger Account; Einrichtungsbefehle führt ihr getrennt als `postgres` aus. Notiert bei Tests `session_user` und `current_user`.

### 4. Verbindungsregeln und TLS-Pflicht

Die Umgebung stellt zwei Testclients im selben Docker-Netz bereit:

| Dienst | IP-Adresse | Bedeutung |
| --- | --- | --- |
| `postgres` | `172.30.42.10` | Datenbankserver |
| `client_ok` | `172.30.42.20` | zugelassener Arbeitsplatz |
| `client_blocked` | `172.30.42.30` | zu sperrender Arbeitsplatz |
| `pgadmin` | `172.30.42.40` | Server der Verwaltungsoberfläche |

Bearbeitet `db/config/pg_hba.conf` auf dem Host so, dass:

1. `client_blocked` keine neue TCP/IP-Verbindung zur Datenbank aufbauen darf, unabhängig von Benutzerkonto und TLS-Modus;
2. alle unverschlüsselten TCP/IP-Verbindungen abgewiesen werden, einschließlich IPv4 und IPv6;
3. die vorgesehenen zugelassenen Clients mit TLS und gültigen Zugangsdaten auf `dvdrental` zugreifen können;
4. der vorbereitete lokale Einrichtungszugang für `postgres` im DB-Container erhalten bleibt.

Der lokale Unix-Socket-Zugang ist eine ausdrücklich vorgesehene Administrationsausnahme. TLS betrifft hier die Verbindung zwischen Datenbankclient und PostgreSQL; HTTPS für die lokal bereitgestellte pgAdmin-Weboberfläche ist nicht Gegenstand der Aufgabe.

Plant zuerst die Reihenfolge eurer Regeln. Begründet, ob der gesperrte Arbeitsplatz durch eine andere Regel doch Zugriff erhalten könnte. Ladet Änderungen als Einrichtungsaccount neu und prüft die Datei auf Fehler:

```bash
docker compose exec postgres psql -U postgres -d dvdrental
```

```sql
SHOW hba_file;
SELECT pg_reload_conf();
SELECT line_number, error
FROM pg_hba_file_rules
WHERE error IS NOT NULL;
```

Die Neuladung beendet bestehende Sitzungen nicht. Führt deshalb für jeden Verbindungstest eine **neue Anmeldung** durch. Beispiel für den Account `ma_anna`:

```bash
docker compose exec client_ok psql "host=postgres dbname=dvdrental user=ma_anna sslmode=require connect_timeout=5" -W
```

Ergänzt für diese Testfälle selbst die erwarteten Ergebnisse **vor und nach** eurer HBA-Änderung. Führt beide Durchläufe mit demselben gültigen normalen Datenbankaccount durch; prüft die pgAdmin-Verbindung zusätzlich über den vorbereiteten Servereintrag. Notiert bei Abweisungen die passende Regel und die Fehlermeldung.

| Client | TLS-Modus |
| --- | --- |
| `client_ok` | `require` |
| `client_ok` | `disable` |
| `client_blocked` | `require` |
| `client_blocked` | `disable` |
| `pgadmin` | `require` |

??? tip "Hilfe 1: Bedeutung der Regeltypen"

    Vergleicht in der Dokumentation `host`, `hostssl`, `hostnossl` und `local`. Welche Verbindungstypen erfasst eine allgemeine `host`-Regel?

??? tip "Hilfe 2: Reihenfolge und Arbeitsplatzsperre"

    PostgreSQL verwendet die erste passende Regel. Eine allgemeine Freigabe vor einer Sperre kann die Sperre unwirksam machen. Die Arbeitsplatzsperre muss für beide TLS-Modi und alle Benutzer greifen. Die lokalen Einrichtungsregeln müssen erhalten bleiben.

Dokumentiert bei einer erfolgreichen Testverbindung auch die serverseitig sichtbare Quelladresse und TLS-Nutzung:

```sql
SELECT session_user, current_user, inet_client_addr();
SELECT ssl, version, cipher
FROM pg_stat_ssl
WHERE pid = pg_backend_pid();
```

Testet die Arbeitsplatzsperre über die beiden Clientcontainer. Bei einer Verbindung aus der pgAdmin-Weboberfläche sieht PostgreSQL die Adresse des **pgAdmin-Servers**, nicht die des Browsers.

Falls das vorgegebene Docker-Netz mit einem vorhandenen Netz kollidiert, passt nach Absprache das Subnetz und alle vier IP-Adressen konsistent an. Dokumentiert die verwendeten Adressen.

### 5. Marketing-Zugriff mittels View und RLS

Marketing darf ausschließlich die E-Mail-Adressen aktiver Kunden lesen. Es darf weder andere Kundenspalten auslesen noch Daten ändern. Die technische Bedingung lautet in dieser Datenbank `active = 1`.

Implementiert **zwei unabhängig überprüfbare Varianten**. Beide sollen am Ende in derselben Datenbank funktionieren. Verwendet getrennte Gruppenrollen und Accounts; diese dürfen keine gegenseitigen Mitgliedschaften oder gemeinsamen weitergehenden Datenrechte besitzen.

#### Variante A: View

- Erstellt als Einrichtungsaccount eine View, die nur `email` ausgibt und inaktive Kunden ausfiltert.
- Setzt für die View die Option `security_barrier = true`. Diese Einstellung ist für die Zugriffsbeschränkung vorgegeben; ihre technische Begründung gehört zur optionalen Vertiefung.
- Die Rolle `marketing_view` erhält ausschließlich das erforderliche Leserecht auf diese View und keinen direkten Datenzugriff auf `customer`.
- Der View-Eigentümer bleibt der vertrauenswürdige Einrichtungsaccount; verwendet die Standardausführung ohne `security_invoker = true`. Erklärt anhand eures Tests, warum der Marketingaccount die View lesen kann, obwohl ihm der direkte Tabellenzugriff fehlt.

#### Variante B: Row-Level Security und Spaltenrechte

- Plant, welche Objektrechte und welche Policy nötig sind, um die fachliche Anforderung vollständig zu erfüllen. Begründet, welche Einstellung die sichtbaren Zeilen und welche die sichtbaren Spalten bestimmt.
- Aktiviert RLS auf `customer` und erstellt eine `SELECT`-Policy für `marketing_rls`, die ausschließlich aktive Kunden zulässt.
- Der Account dieser Variante fragt `customer` direkt ab. Er erhält keinen Zugriff über die Marketing-View.
- Verwendet keinen Superuser, keine Rolle mit `BYPASSRLS` und keinen Tabelleneigentümer für den Funktionsnachweis.
- RLS wird für die gesamte Tabelle aktiviert. Berücksichtigt deshalb auch die Auswirkungen auf die bereits bestehende View und prüft sie erneut.

**Lernversuch – Rechte ohne Policy:** Gewährt dem normalen RLS-Testaccount zunächst nur das erforderliche Leserecht auf `email`. Aktiviert RLS, legt aber noch keine Policy an. Sagt voraus, was `SELECT email FROM customer;` liefert, und führt die Abfrage mit diesem Account aus. Ergänzt anschließend eure Policy und wiederholt die Abfrage. Erklärt den Unterschied. Prüft zusätzlich, ob der Account andere Kundenspalten lesen kann, und begründet das Ergebnis anhand der jeweils zuständigen Einstellung.

??? tip "Hilfe 1: Zwei getrennte Fragen"

    Welche Kundendatensätze sind sichtbar? Welche ihrer Spalten dürfen gelesen werden? Prüft, ob eine einzige Einstellung beide Anforderungen erfüllt.

??? tip "Hilfe 2: RLS und Spaltenrechte kombinieren"

    Eine Policy beschränkt Zeilen, nicht Spalten. Kombiniert daher eine Policy für `active = 1` mit einem Leserecht ausschließlich auf `email`. Bei aktivierter RLS werden für normale Accounts ohne passende Policy keine Zeilen freigegeben. Verwendet für die Prüfung einen Account ohne Eigentümer- oder Superuserrechte.

#### Erforderliche Nachweise für beide Varianten

- Die erlaubte E-Mail-Abfrage funktioniert ohne selbst hinzugefügten Aktivitätsfilter.
- Vergleicht das vollständige Ergebnis mit der Referenzabfrage des Einrichtungsaccounts für `active = 1`. Bei unveränderten Daten sind es 584 Ergebniszeilen. Die Zeilenanzahl allein reicht als Nachweis nicht aus.
- Eine als Einrichtungsaccount ermittelte E-Mail-Adresse eines inaktiven Kunden erscheint nicht im Ergebnis.
- Das Auslesen weiterer Kundenspalten und Schreibversuche werden abgewiesen.
- Bei Variante A scheitert auch der direkte Tabellenzugriff; bei Variante B scheitert `SELECT *` auf `customer` wegen der zusätzlichen Spaltenrechte.
- Wiederholt den View-Test, nachdem ihr RLS aktiviert habt, und erklärt das Ergebnis.

### 6. Eine eigene Rolle entwerfen

Formuliert einen zusätzlichen, plausiblen Anwendungsfall im Filmkatalog, beispielsweise für eine externe Katalogprüfung oder eine spezialisierte Redaktion. Entscheidet selbst, welche Spalten gelesen und gegebenenfalls geändert werden müssen. Die Rolle muss sich in ihren Rechten von den vier vorgegebenen Rollen unterscheiden.

- Begründet den Zweck sowie mindestens eine erlaubte und eine ausdrücklich verbotene Aktion.
- Ergänzt eure Berechtigungsmatrix und setzt die Rolle mit einem eigenen persönlichen Testaccount um.
- Beschränkt euch auf `film` und vergebt nur die für euren Zweck erforderlichen Rechte. Die neue Rolle erhält keine Mitgliedschaft in den bisherigen Übungsrollen und keine globalen Verwaltungsrechte. Die bisherigen Anforderungen müssen weiter erfüllt bleiben.
- Führt einen erfolgreichen und einen abgewiesenen Test aus. Erklärt anhand dieser Tests, warum eure Rechte für den Anwendungsfall ausreichen.

Eine zusätzliche Rolle genügt; es werden keine neuen Tabellen und kein größeres Anwendungssystem verlangt.

### Optionale Vertiefung

Diese Punkte sind keine Voraussetzung für die vollständige Erfüllung der Grundanforderungen. Wählt bei Interesse einen davon:

- Erklärt anhand der PostgreSQL-Dokumentation den Zweck von `security_barrier`. Welche zusätzlichen Annahmen sind nötig, damit eine View als Sicherheitsgrenze geeignet ist?
- Untersucht an einer separaten Testview, wie `security_invoker = true` die benötigten Rechte und das Zusammenspiel mit RLS verändert. Lasst eure fertige Marketing-View bestehen.
- Vergleicht `sslmode=require` und `verify-full`. Zeigt mit bewusst bereitgestelltem vertrauenswürdigem Zertifikat, wie sich ein richtiger und ein falscher Servername auswirken.

## Fragestellungen

- Wie unterscheiden sich Gruppenrollen ohne `LOGIN` und persönliche Accounts mit `LOGIN`?
- Wie wirken direkt vergebene Rechte, `PUBLIC` und Rollenmitgliedschaften zusammen?
- Warum ist ein fachlicher Admin nicht automatisch ein PostgreSQL-Superuser?
- Welche zusätzlichen Objektrechte habt ihr benötigt und wie habt ihr sie ermittelt?
- Was hat euer Lernversuch zum Tabellenleserecht und zum Spaltenentzug gezeigt?
- Welche Aufgaben übernehmen Compose, der PostgreSQL-Entrypoint und `/docker-entrypoint-initdb.d/` beim ersten Start?
- Was bleibt nach `docker compose down` erhalten, und was wird bei `down --volumes` gelöscht? Welche Dateien bleiben selbst dann auf dem Host erhalten?
- Was bewirkt `ssl = on`, und welche zusätzliche Aufgabe übernimmt `pg_hba.conf`?
- Wie unterscheiden sich `host`, `hostssl`, `hostnossl` und `local`? Warum ist die Reihenfolge wichtig?
- Welche IP-Adresse sieht PostgreSQL bei Zugriffen über pgAdmin?
- Welche Aufgaben übernehmen View, Spaltenrechte und RLS-Policy jeweils? Welche Rolle spielt der Eigentümer?
- Wie unterscheiden sich eure Vorhersage und Beobachtung beim Aktivieren von RLS ohne Policy?
- Welche Rechte habt ihr für eure eigene Rolle bewusst nicht vergeben und warum?

Beantwortet die Fragen anhand eurer eigenen Lösung. Verweist auf passende Tests, statt allgemeine Definitionen mehrfach abzuschreiben.

## Abgabe

**Gruppengröße: 1 Person.** Abzugeben sind auf Moodle:

- ein PDF-Protokoll mit selbst erstellter Rollen-/Berechtigungsmatrix, den zwei Lernversuchen, begründeter eigener Rolle sowie positiven und negativen Testergebnissen;
- eure SQL-Skripte und die fertige `pg_hba.conf` als separate Dateien oder ZIP, damit die Lösung erneut aufgebaut werden kann.

Kennzeichnet verwendete Quellen und KI-Unterstützung. Gebt keine persönlichen Passwörter oder privaten TLS-Schlüssel ab. Bereitet die laufende Umgebung für das Abgabegespräch vor. Dabei demonstriert ihr ausgewählte Zugriffe und erklärt insbesondere den Import, den Reset und die Trennung zwischen Einrichtungs- und Testaccounts.

Ein Testnachweis enthält jeweils Account, Aktion beziehungsweise SQL, erwartetes Ergebnis, beobachtetes Ergebnis und eine kurze Begründung. Eine kompakte Tabelle genügt; Screenshots können ergänzen, ersetzen aber keine Erklärung. Die beiden Lernversuche dürfen direkt bei den zugehörigen Tests dokumentiert werden.

**Kurze Transferaufgabe im Abgabegespräch:** Ihr setzt außerdem eine kleine Änderung an eurer laufenden Lösung um und weist ihre Wirkung nach. Die Lehrkraft wählt beispielsweise einen dieser Fälle:

- Ein Mitarbeiter verlässt das Unternehmen. Verhindert neue Anmeldungen dieses Accounts, ohne den zweiten Mitarbeiteraccount oder die Gruppenrechte zu verändern. Bereits offene Sitzungen sind hier nicht Teil der Aufgabe.
- Ein Redakteur wechselt in die Mitarbeiterrolle. Passt die Zuordnung an und zeigt, dass ein neues Recht wirkt und ein bisheriges Recht nicht mehr besteht.
- Der zugelassene Testarbeitsplatz soll vorübergehend ebenfalls gesperrt werden. Passt die HBA-Regeln an, prüft eine neue Anmeldung und stellt anschließend den vorherigen Zustand wieder her.

Dokumentation und eigene Unterlagen sind erlaubt. Entscheidend sind die begründete Änderung und der passende Test, nicht auswendig gelernte Syntax. Führt die Änderung selbst durch; während dieser kurzen Prüfung wird keine neue Lösung von einer KI erzeugt.

## Bewertung

Die kompakte [Checkliste zur Abgabe](CHECK.md) fasst die Bewertungskriterien zusammen.

### Grundanforderungen überwiegend erfüllt

- [ ] Umgebung gestartet; Erstinitialisierung und Reset nachvollziehbar erklärt.
- [ ] Gruppenrollen angelegt und Berechtigungsmatrix aus den Geschäftsregeln selbst abgeleitet.
- [ ] Zahlungsrechte einschließlich notwendiger Sequenzrechte korrekt umgesetzt.
- [ ] Kunden- und Redakteurbeschränkungen auf `film` korrekt umgesetzt.
- [ ] Erlaubte und abgewiesene Objektzugriffe unter normalen Accounts dokumentiert; Lernversuch zu Spaltenrechten mit Vorhersage und Erklärung ausgewertet.

### Grundanforderungen zur Gänze erfüllt

Zusätzlich zu allen vorstehenden Kriterien:

- [ ] Alle geforderten persönlichen Accounts korrekt zugeordnet; keine ungewollte Rechteweitergabe.
- [ ] IP-Sperre und TLS-Pflicht umgesetzt; alle Fälle der Verbindungstestmatrix nachgewiesen.
- [ ] Marketing-Zugriff über eine geschützte View vollständig umgesetzt und getestet.
- [ ] Marketing-Zugriff über RLS **und** Spaltenrechte vollständig umgesetzt und getestet.
- [ ] Beide Marketing-Varianten funktionieren gemeinsam und sind über getrennte Accounts nachgewiesen.
- [ ] Lernversuch zu RLS ohne Policy mit Vorhersage und Erklärung ausgewertet.
- [ ] Eigene zusätzliche Rolle fachlich begründet, mit minimalen Rechten umgesetzt und positiv sowie negativ getestet.
- [ ] Lösung mit den abgegebenen Dateien reproduzierbar; Kontrollfragen verständlich beantwortet und eine kurze Transferaufgabe selbstständig umgesetzt.

Die Nutzung der angebotenen Hilfen ist zulässig und führt zu keinem Bewertungsabzug. Die optionale Vertiefung wird nicht als fehlende Grundanforderung gewertet.

## Quellen

Alle folgenden Quellen wurden am **12.09.2026** auf Erreichbarkeit und fachliche Eignung geprüft. PostgreSQL-Links beziehen sich bewusst auf Hauptversion 18.

- PostgreSQL 18: [GRANT](https://www.postgresql.org/docs/18/sql-grant.html) und [REVOKE](https://www.postgresql.org/docs/18/sql-revoke.html).
- PostgreSQL 18: [Role Membership](https://www.postgresql.org/docs/18/role-membership.html).
- PostgreSQL 18: [CREATE VIEW](https://www.postgresql.org/docs/18/sql-createview.html).
- PostgreSQL 18: [CREATE POLICY](https://www.postgresql.org/docs/18/sql-createpolicy.html) und [Row Security Policies](https://www.postgresql.org/docs/18/ddl-rowsecurity.html).
- PostgreSQL 18: [The pg_hba.conf File](https://www.postgresql.org/docs/18/auth-pg-hba-conf.html).
- PostgreSQL 18: [Secure TCP/IP Connections with SSL](https://www.postgresql.org/docs/18/ssl-tcp.html) und [SSL Support auf Clientseite](https://www.postgresql.org/docs/18/libpq-ssl.html).
- Docker: [Offizielles PostgreSQL-Image](https://hub.docker.com/_/postgres).
- pgAdmin 4 9.17: [Container Deployment](https://www.pgadmin.org/docs/pgadmin4/9.17/container_deployment.html).
- PostgreSQL: [Versionsunterstützung](https://www.postgresql.org/support/versioning/); pgAdmin: [Dokumentations- und Versionsübersicht](https://www.pgadmin.org/docs/).
- Material for MkDocs: [Bilder und Lightbox](https://squidfunk.github.io/mkdocs-material/reference/images/); [MkDocs GLightbox](https://blueswen.github.io/mkdocs-glightbox/).
- Kursrepository: [Original-Dump und ER-Diagramm](https://github.com/TGM-HIT/insy-exercises/tree/main/docs/3.Semester/31_PostgreSQL_Benutzerverwaltung/db). Das Diagramm trägt die Quellenangabe „PostgreSQL Tutorial“.

*Diese Aufgabenbeschreibung wurde mit KI-Unterstützung überarbeitet.*

---

**Version:** 20260913v4 – Repositoryfassung
