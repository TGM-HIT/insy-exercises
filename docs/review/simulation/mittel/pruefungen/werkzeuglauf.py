from pathlib import Path
import json
import subprocess
import sys
from datetime import datetime, timezone

base = Path(__file__).resolve().parents[1]
interpreter = Path(r"SOURCE_WORKSPACE/xml-webservice-20261113/qa/tools-venv/Scripts/python.exe")
checker = Path(r"SOURCE_WORKSPACE/xml-webservice-20261113/material/pruefen.py")
label, mode, *files = sys.argv[1:]
command = [str(interpreter), "-X", "utf8", str(checker), mode]
command.extend(str((base / file).resolve()) for file in files)
result = subprocess.run(command, text=True, encoding="utf-8", capture_output=True)
log = {"label": label, "executed_at_utc": datetime.now(timezone.utc).isoformat(), "command": command, "stdout": result.stdout, "stderr": result.stderr, "exitcode": result.returncode}
(base / "pruefungen" / (label + ".json")).write_text(json.dumps(log, ensure_ascii=False, indent=2), encoding="utf-8")
(base / "pruefungen" / (label + ".stdout.txt")).write_text(result.stdout, encoding="utf-8")
(base / "pruefungen" / (label + ".stderr.txt")).write_text(result.stderr, encoding="utf-8")
(base / "pruefungen" / (label + ".exitcode.txt")).write_text(str(result.returncode) + "\n", encoding="utf-8")
print(json.dumps(log, ensure_ascii=False, indent=2))