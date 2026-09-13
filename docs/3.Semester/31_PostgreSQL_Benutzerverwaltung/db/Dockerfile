FROM postgres:18.6

RUN apt-get update \
    && apt-get install -y --no-install-recommends openssl \
    && rm -rf /var/lib/apt/lists/*

COPY tls-entrypoint.sh /usr/local/bin/lab-tls-entrypoint.sh
RUN sed -i 's/\r$//' /usr/local/bin/lab-tls-entrypoint.sh \
    && chmod 0755 /usr/local/bin/lab-tls-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/lab-tls-entrypoint.sh"]
CMD ["postgres"]
