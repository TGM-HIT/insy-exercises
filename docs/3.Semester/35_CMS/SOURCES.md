# Quellen und Versionsentscheidungen

Geprüft am **13.09.2026**. Die alte Angabe enthielt nur den WordPress-Downloadlink.
Die folgende Auswahl ergänzt offizielle Produktdokumentation und Herstellerquellen.

## Laufzeit und Wartung

| Quelle | Verwendung in der Aufgabe |
| --- | --- |
| [WordPress herunterladen](https://wordpress.org/download/) | Aktuelle stabile Basis 7.1. |
| [WordPress-Anforderungen](https://wordpress.org/about/requirements/) | Empfohlene PHP-/Datenbankbasis und HTTPS für realen Betrieb. |
| [WordPress/PHP-Kompatibilität](https://make.wordpress.org/core/handbook/references/php-compatibility-and-wordpress-versions/) | WordPress 7.1 unterstützt PHP 8.5. |
| [Unterstützte PHP-Versionen](https://www.php.net/supported-versions.php) | PHP 8.5 ist aktiv unterstützt; PHP 7.3 aus der Altaufgabe entfällt. |
| [Offizielles WordPress-Docker-Image](https://hub.docker.com/_/wordpress) | Apache-Variante, Datenbankkonfiguration, persistente Dateien und CLI. |
| [Offizielle WordPress-Image-Tags](https://github.com/docker-library/official-images/blob/master/library/wordpress) | Tatsächlich verfügbare Tags für WordPress 7.1.0 und CLI 2.12.0 mit PHP 8.5. |
| [MariaDB 12.3 LTS](https://mariadb.org/mariadb-server-12-3-lts-released/) | Stabile LTS-Basis statt Vorabversion oder wechselndem latest-Tag. |
| [Offizielles MariaDB-Image](https://hub.docker.com/_/mariadb) | Datenbankinitialisierung und persistentes Volume. |
| [Offizielle MariaDB-Image-Tags](https://github.com/docker-library/official-images/blob/master/library/mariadb) | Geprüfter Wartungsstand 12.3.3. |
| [Compose: Startreihenfolge](https://docs.docker.com/compose/how-tos/startup-order/) | WordPress startet nach erfolgreicher Datenbankabfrage. |

Die Image-Tags fixieren Produktversionen bzw. PHP-Hauptlinien, sind aber keine
unveränderlichen Digests. Beim Nachbau: PHP 8.5.10. Neue Image-Builds können eine
aktualisierte Patchversion enthalten. Ein erneutes Image-Pull allein aktualisiert
keinen bereits initialisierten WordPress-Dateibestand im Volume.

## Redaktion und Gestaltung

| Quelle | Verwendung in der Aufgabe |
| --- | --- |
| [WordPress: Rollen und Capabilities](https://wordpress.org/documentation/article/roles-and-capabilities/) | Rechte für eigene/fremde Beiträge, Seiten, Medien und Administration. |
| [Plugin-Handbuch: Rollen](https://developer.wordpress.org/plugins/users/roles-and-capabilities/) | Technisches Rollenmodell; benannte Rollen sind Mengen von Capabilities. |
| [Members im Pluginverzeichnis](https://wordpress.org/plugins/members/) | Version 3.2.26, getestet bis WordPress 7.1; kostenlose Rollenverwaltung. |
| [Members: Rollenverwaltung](https://members-plugin.com/docs/role-management/) | Eigene Rollen und gewährte, verweigerte bzw. nicht gesetzte Rechte. Änderungen bleiben nach Plugin-Deaktivierung gespeichert. |
| [Members: Rollen klonen](https://members-plugin.com/docs/clone-roles/) | Standardrollen als Ausgangspunkt, ohne diese selbst zu verändern. |
| [WordPress Site Editor](https://wordpress.org/documentation/article/site-editor/) | Gestaltung mit Block-Themes. |
| [Twenty Twenty-Five](https://wordpress.org/themes/twentytwentyfive/) | Getestetes Block-Theme 1.5, keine mitkopierte alte Themesammlung. |
| [WordPress-Schriftbibliothek](https://wordpress.org/documentation/article/the-font-library/) | Lokaler Import der bereitgestellten Schriften; ab WordPress 7.0 auch unter Design/Schriften erreichbar. |
| [Query Loop Block](https://wordpress.org/documentation/article/query-loop-block/) | Dynamische Neuigkeiten statt manuell duplizierter Textkarten. |
| [Offizielle TGM-Website](https://www.tgm.ac.at/) | Informationsarchitektur als Bezugspunkt; Demo bleibt klar gekennzeichnet. |

**Fachliche Folgerung:** Eine Kategorie oder ein Schulrollenname setzt keine
Klassen-/Abteilungsschranke um. Die praktische Aufgabe prüft daher den begrenzten
Pilot und lässt die fehlende Bereichstrennung ausdrücklich nachweisen. Members
wird hier als Rollenoberfläche eingesetzt, nicht als zugesagte Lösung für eine
vollständige schulweite Zugriffstrennung. Eine solche Erweiterung müsste gesondert
ausgewählt, konfiguriert und mit positiven und negativen Zugriffstests geprüft werden.

## Sicherung und Wiederherstellung

| Quelle | Verwendung in der Aufgabe |
| --- | --- |
| [WordPress-Backups](https://developer.wordpress.org/advanced-administration/security/backup/) | Datenbank und Dateien sind getrennte Bestandteile der Sicherung. |
| [WP-CLI: Datenbankexport](https://developer.wordpress.org/cli/commands/db/export/) | SQL-Sicherung der WordPress-Datenbank. |
| [WP-CLI: Datenbankimport](https://developer.wordpress.org/cli/commands/db/import/) | Wiederherstellung im frischen zweiten Projekt. |
| [WP-CLI: search-replace](https://developer.wordpress.org/cli/commands/search-replace/) | URL-Wechsel einschließlich serialisierter Werte. |

Logo und Schriften stammen aus `cms_alt`; Herkunft und die unveränderte Extraktion
des im SVG eingebetteten PNGs sind im Material unter `assets/HERKUNFT.md` dokumentiert.
Das bereitgestellte Material ist kein neu behaupteter Corporate-Design-Standard.
