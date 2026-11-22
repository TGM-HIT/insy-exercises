"""Vorgegebener Abruf einer echten XML-Antwort der polnischen Nationalbank (NBP)."""

from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import re
import sys
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen
from xml.etree import ElementTree

URL = "https://api.nbp.pl/api/exchangerates/tables/a/?format=xml"
MAX_BYTES = 1_000_000


def fetch_response():
    request = Request(URL, headers={"Accept": "application/xml", "User-Agent": "INSY-XML-Unterricht/1.0"}, method="GET")
    with urlopen(request, timeout=15) as response:
        if response.status != 200:
            raise ValueError(f"Der Dienst antwortet mit HTTP {response.status}.")
        raw = response.read(MAX_BYTES + 1)
        if len(raw) > MAX_BYTES:
            raise ValueError("Die Antwort ist unerwartet groß.")
        if "xml" not in response.headers.get("Content-Type", "").lower():
            raise ValueError("Der Dienst hat keine XML-Antwort geliefert.")
        text = raw.decode("utf-8-sig")
        if re.search(r"<!\s*(?:DOCTYPE|ENTITY)\b", text, re.IGNORECASE):
            raise ValueError("Die Antwort enthält unerwartete Deklarationen.")
        root = ElementTree.fromstring(raw)
        if root.tag != "ArrayOfExchangeRatesTable":
            raise ValueError("Die Antwort hat nicht die erwartete NBP-Struktur.")
        tables = root.findall("ExchangeRatesTable")
        if len(tables) != 1 or tables[0].findtext("Table") != "A":
            raise ValueError("Es wurde nicht genau eine Kurstabelle A geliefert.")
        published = tables[0].findtext("EffectiveDate")
        if not published:
            raise ValueError("In der Antwort fehlt das Veröffentlichungsdatum.")
        metadata = {
            "anfrage": URL,
            "methode": "GET",
            "http_status": response.status,
            "content_type": response.headers.get("Content-Type"),
            "abgerufen_utc": datetime.now(timezone.utc).isoformat(),
            "server_datum": response.headers.get("Date"),
            "kursdatum": published,
            "tabellennummer": tables[0].findtext("No"),
            "sha256": hashlib.sha256(raw).hexdigest(),
            "hinweis": "Unveränderte Antwortbytes. Mid ist PLN pro einer Einheit der angegebenen Fremdwährung.",
        }
    return raw, metadata


def main():
    try:
        raw, metadata = fetch_response()
        destination = Path("quellen")
        destination.mkdir(exist_ok=True)
        (destination / "nbp-antwort.xml").write_bytes(raw)
        (destination / "nbp-abruf.json").write_text(json.dumps(metadata, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        print(f"HTTP 200: {URL}")
        print(f"XML unverändert gespeichert: quellen/nbp-antwort.xml ({len(raw)} Bytes)")
        print(f"Kursdatum: {metadata['kursdatum']}; Abrufnachweis: quellen/nbp-abruf.json")
        print("Sucht in der XML-Antwort die Einträge mit Code EUR und CZK. PLN ist die Basiswährung.")
        return 0
    except (HTTPError, URLError, TimeoutError, OSError, ValueError, ElementTree.ParseError) as error:
        print(f"ABRUF FEHLGESCHLAGEN: {error}", file=sys.stderr)
        print("Es wurden keine neuen Kursdateien gespeichert. Bereits vorhandene Dateien können älter sein.", file=sys.stderr)
        print("Verwendet bei einem Dienstausfall die gekennzeichnete XML-Datei aus ersatzdaten/ und dokumentiert den Ersatzdaten-Einsatz.", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
