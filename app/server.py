import json
import os
from datetime import datetime, timezone
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer

PORT = int(os.getenv("APP_PORT", "8000"))


def emit_log(level, **fields):
    payload = {
        "ts": datetime.now(timezone.utc).isoformat().replace("+00:00", "Z"),
        "level": level,
        **fields,
    }
    print(json.dumps(payload), flush=True)


class JsonRequestHandler(SimpleHTTPRequestHandler):
    def log_request(self, code="-", size="-"):
        emit_log(
            "info",
            event="http_request",
            client_ip=self.client_address[0],
            method=getattr(self, "command", None),
            path=getattr(self, "path", None),
            status=int(code) if str(code).isdigit() else code,
            size=int(size) if str(size).isdigit() else size,
            user_agent=self.headers.get("User-Agent", ""),
        )

    def log_error(self, fmt, *args):
        emit_log(
            "error",
            event="http_error",
            client_ip=self.client_address[0] if self.client_address else None,
            method=getattr(self, "command", None),
            path=getattr(self, "path", None),
            message=fmt % args,
        )


if __name__ == "__main__":
    emit_log("info", event="startup", port=PORT, message="server starting")
    with ThreadingHTTPServer(("0.0.0.0", PORT), JsonRequestHandler) as httpd:
        httpd.serve_forever()