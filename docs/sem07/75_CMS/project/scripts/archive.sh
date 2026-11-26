#!/bin/sh
set -eu
cd /var/www/html
action=${1:-}
name=${2:-}
case "$name" in ''|*[!a-zA-Z0-9_-]*) echo 'Name: nur Buchstaben, Ziffern, _ oder -.' >&2; exit 2;; esac
dir="/backups/$name"
case "$action" in
  backup)
    test ! -e "$dir" || { echo 'Sicherungsname existiert bereits.' >&2; exit 2; }
    mkdir "$dir"
    wp --allow-root db export "$dir/database.sql" --single-transaction
    tar -czf "$dir/wp-content.tar.gz" wp-content
    wp --allow-root option get home > "$dir/site-url.txt"
    wp --allow-root core version > "$dir/wordpress-version.txt"
    wp --allow-root plugin list --format=json > "$dir/plugins.json"
    wp --allow-root theme list --format=json > "$dir/themes.json"
    (cd "$dir" && sha256sum database.sql wp-content.tar.gz site-url.txt wordpress-version.txt plugins.json themes.json > SHA256SUMS)
    echo "Sicherung fertig: backups/$name"
    ;;
  restore)
    new_url=${3:-}
    case "$new_url" in http://127.0.0.1:[0-9]*|http://localhost:[0-9]*) ;; *) echo 'Lokale Ziel-URL mit Port erforderlich.' >&2; exit 2;; esac
    test -f "$dir/SHA256SUMS"
    (cd "$dir" && sha256sum -c SHA256SUMS)
    # Nur in ein frisches, noch nicht installiertes Ziel wiederherstellen.
    if wp --allow-root core is-installed 2>/dev/null; then
      echo 'Abbruch: Ziel enthält bereits eine Installation. Neues Compose-Projekt verwenden.' >&2
      exit 2
    fi
    test "$(wp --allow-root core version)" = "$(cat "$dir/wordpress-version.txt")" || { echo 'WordPress-Versionen stimmen nicht überein.' >&2; exit 2; }
    wp --allow-root db import "$dir/database.sql"
    tar -xzf "$dir/wp-content.tar.gz"
    chown -R 33:33 wp-content
    old_url=$(cat "$dir/site-url.txt")
    wp --allow-root search-replace "$old_url" "$new_url" --all-tables-with-prefix --skip-columns=guid
    wp --allow-root rewrite flush
    echo "Wiederhergestellt nach $new_url"
    ;;
  *) echo 'Aufruf: backup NAME | restore NAME http://127.0.0.1:PORT' >&2; exit 2;;
esac
