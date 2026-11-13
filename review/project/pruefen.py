"""Vorgegebenes Prüfwerkzeug: XML-Wohlgeformtheit und eine eigene lokale DTD."""

import argparse
from importlib.metadata import version
from io import BytesIO
from pathlib import Path
import re
import sys

from lxml import etree

MAX_BYTES = 1_000_000


def read_utf8(path, limit=MAX_BYTES):
    """Liest eine kleine Unterrichtsdatei ohne zusätzliche Ressourcen."""
    raw = Path(path).read_bytes()
    if len(raw) > limit:
        raise ValueError(f"Datei ist größer als die erlaubten {limit} Bytes.")
    text = raw.decode("utf-8-sig")
    declaration = re.match(r"\s*<\?xml\b[^?]*\bencoding\s*=\s*['\"]([^'\"]+)['\"]", text)
    if declaration and declaration.group(1).lower() not in ("utf-8", "utf8"):
        raise ValueError("Die XML-Datei muss als UTF-8 gespeichert und deklariert sein.")
    return raw, text


def load_xml(path):
    raw, text = read_utf8(path)
    if re.search(r"<!\s*(?:DOCTYPE|ENTITY)\b", text, re.IGNORECASE):
        raise ValueError("DOCTYPE und Entity-Deklarationen sind in diesem Arbeitsmaterial nicht erlaubt. Die DTD wird separat übergeben.")
    parser = etree.XMLParser(
        resolve_entities=False, no_network=True, load_dtd=False,
        recover=False, huge_tree=False,
    )
    return etree.fromstring(raw, parser=parser)


def load_dtd(path):
    raw, text = read_utf8(path, limit=64_000)
    if re.search(r"<!\s*ENTITY\b|\b(?:SYSTEM|PUBLIC)\b|%", text, re.IGNORECASE):
        raise ValueError("Verwendet eine lokale DTD mit ELEMENT- und ATTLIST-Deklarationen; Entities und externe Referenzen sind nicht erlaubt.")
    return etree.DTD(BytesIO(raw))


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="befehl", required=True)
    xml = sub.add_parser("xml", help="Wohlgeformtheit einer XML-Datei prüfen")
    xml.add_argument("datei", help="Pfad zur XML-Datei")
    dtd = sub.add_parser("dtd", help="XML gegen eine eigene lokale DTD prüfen")
    dtd.add_argument("datei", help="Pfad zur XML-Datei")
    dtd.add_argument("schema", help="Pfad zur DTD-Datei")
    sub.add_parser("versionen", help="Verwendete Versionen anzeigen")
    args = parser.parse_args(argv)
    try:
        if args.befehl == "versionen":
            print(f"Python {sys.version.split()[0]}\nlxml {version('lxml')}\nlibxml2 {'.'.join(map(str, etree.LIBXML_VERSION))}")
            return 0
        tree = load_xml(args.datei)
        if args.befehl == "xml":
            print(f"WOHLGEFORMT: {args.datei} (Wurzelelement: {tree.tag})")
            print("Damit sind weder die DTD-Gültigkeit noch die Richtigkeit der Werte nachgewiesen.")
            return 0
        schema = load_dtd(args.schema)
        if not schema.validate(tree):
            print("DTD-UNGÜLTIG: Die XML-Struktur entspricht nicht der angegebenen DTD.", file=sys.stderr)
            for error in schema.error_log:
                print(f"  Zeile {error.line}: {error.message}", file=sys.stderr)
            return 1
        print(f"DTD-GÜLTIG: {args.datei} entspricht {args.schema}.")
        print("Zahlenwerte, Datumswerte und die Vollständigkeit der drei Währungen prüft anschließend die Anwendung.")
        return 0
    except etree.XMLSyntaxError as error:
        line, column = error.position
        print(f"XML-FEHLER in Zeile {line}, Spalte {column}: Die Datei ist nicht wohlgeformt.", file=sys.stderr)
        print(f"  Parsermeldung: {error.msg}", file=sys.stderr)
    except etree.DTDParseError as error:
        print(f"DTD-FEHLER: Die DTD kann nicht gelesen werden. {error}", file=sys.stderr)
    except UnicodeError:
        print("DATEIFEHLER: Speichert XML und DTD als UTF-8.", file=sys.stderr)
    except (OSError, ValueError) as error:
        print(f"FEHLER: {error}", file=sys.stderr)
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
