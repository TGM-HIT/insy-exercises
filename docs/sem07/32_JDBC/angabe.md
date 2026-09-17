# JDBC

Lade [Projekt-Dateien](TODO) herunter.

Studiere die Unterlagen .pdf durch.

Beantworte die Fragenstellungen, bearbeite dann die Übung.

## Fragestellungen

- was sind technischen Voraussetzungen für JDBC

## Ausgangslage

Gegeben ist ein fast fertiges Programm, ein Mini-Webshop, der aus einem einfachen Webservice besteht. Das Webservice kann Artikel, Kunden und Bestellungen anzeigen, sowie neue Bestellungen aufgeben. Das Programm ist bis auf ein kleines Detail fertig: Die Anbindung an die Datenbank wurde noch nicht implementiert, das ist nun deine Aufgabe. Die entsprechenden Stellen im Sourcecode sind mit // TODO gekennzeichnet.

Richte zunaechst eine Postgres-Datenbank mit pgAdmin mittels Docker Compose ein:

```
cd project/db
docker compose up -d
```

Dies startet eine PostgreSQL-Instanz (Port 5432) und pgAdmin (Port 8080). Die Tabellen und Testdaten werden automatisch aus `webshop.sql` erstellt.

### Option A: Java-Server in Docker (empfohlen)

Der Java-Server kann ebenfalls containerisiert laufen. Starte einfach alle Services mit einem Befehl:

```
cd project/db
docker compose up -d
```

Dies startet PostgreSQL, pgAdmin **und** den Java-Server. Beim ersten Start wird das Java-Image heruntergeladen und der Server automatisch kompiliert und gestartet. Der Webshop ist dann unter [http://127.0.0.1:8000](http://127.0.0.1:8000) erreichbar.

### Option B: Lokale Java-Installation

Falls du Java bereits lokal installiert hast, kannst du den Server auch ohne Docker starten. Dafuer benoetigst du den JDBC-Treiber fuer Postgres [1] sowie die JSON-Java Library [2]. Du kannst diese mittels Gradle installieren oder die entsprechende JAR-Dateien selbst herunterladen und in dein Projekt einbinden. Alternativ lassen sich die Libraries mittels gradle ueber die folgenden Dependencies einrichten:

```
dependencies {
     implementation 'org.json:json:20171018'
     implementation 'org.postgresql:postgresql:42.2.8'
}
```

Kompiliere und starte den Server mit:

```
cd project
javac -cp ".;json-20171018.jar;postgresql-42.2.8.jar" Server.java
java -cp ".;json-20171018.jar;postgresql-42.2.8.jar" Server
```

## Funktionsweise des Webshops

Standardmaessig laeuft der Webshop auf Port 8000; falls dieser Port bei dir belegt ist, kannst du ihn mittels dem Property `Server.port` aendern. Du kannst das laufende Webservice dann entsprechend unter [http://127.0.0.1:8000](http://127.0.0.1:8000) aufrufen.
Wie du siehst, existieren Methoden zum Anzeigen von Kunden, Bestellungen, und Artikeln und zum Aufgeben von Bestellungen. Alle Methoden koennen im Browser per Adresszeile (d.h. per GET-Request) aufgerufen werden und liefern eine Antwort im JSON-Format.

index.html kann im Browser geöffnet werden um alle Daten einzusehen und Bestellungen zu testen.

[1] [https://jdbc.postgresql.org/download.html](https://jdbc.postgresql.org/download.html)

[2] [https://github.com/stleary/JSON-java](https://github.com/stleary/JSON-java)
