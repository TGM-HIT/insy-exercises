#!/bin/sh
set -eu

# Local teaching environment only. No shared private key is shipped.
if [ "$1" = postgres ]; then
    mkdir -p /tls
    if [ ! -s /tls/server.crt ] || [ ! -s /tls/server.key ]; then
        # Keep the restrictive umask local to certificate generation. The
        # upstream entrypoint must create traversable parent directories.
        (
        umask 077
        openssl req -x509 -newkey rsa:3072 -nodes -days 365 \
            -keyout /tls/server.key -out /tls/server.crt \
            -subj '/CN=postgres' \
            -addext 'subjectAltName=DNS:postgres,DNS:localhost,IP:127.0.0.1,IP:172.30.42.10'
        )
    fi
    chown postgres:postgres /tls /tls/server.crt /tls/server.key
    chmod 0700 /tls
    chmod 0600 /tls/server.key
    chmod 0644 /tls/server.crt
fi

exec /usr/local/bin/docker-entrypoint.sh "$@"
