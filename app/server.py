from http.server import SimpleHTTPRequestHandler, HTTPServer

PORT = 8000

class Handler(SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/health":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"OK")
        else:
            super().do_GET()

httpd = HTTPServer(("0.0.0.0", PORT), Handler)

print("Serving on 0.0.0.0:8000")
httpd.serve_forever()
