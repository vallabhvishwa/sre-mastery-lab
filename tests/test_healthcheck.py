import threading
import unittest
from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path
import sys
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "04-python"))
from sre_healthcheck import check_url

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        code = 200 if self.path == '/health' else 503
        self.send_response(code)
        self.end_headers()
        self.wfile.write(b'ok' if code == 200 else b'unavailable')
    def log_message(self, *_args):
        pass

class HealthCheckTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.server = HTTPServer(('127.0.0.1', 0), Handler)
        cls.thread = threading.Thread(target=cls.server.serve_forever, daemon=True)
        cls.thread.start()
        cls.base = f'http://127.0.0.1:{cls.server.server_port}'
    @classmethod
    def tearDownClass(cls):
        cls.server.shutdown()
        cls.thread.join(timeout=2)
        cls.server.server_close()
    def test_healthy(self):
        result = check_url(self.base + '/health', timeout=1, retries=0)
        self.assertTrue(result.ok)
        self.assertEqual(result.status, 200)
    def test_unhealthy(self):
        result = check_url(self.base + '/broken', timeout=1, retries=0)
        self.assertFalse(result.ok)
        self.assertEqual(result.status, 503)
    def test_invalid_timeout(self):
        with self.assertRaises(ValueError):
            check_url(self.base + '/health', timeout=0)

if __name__ == '__main__':
    unittest.main()
