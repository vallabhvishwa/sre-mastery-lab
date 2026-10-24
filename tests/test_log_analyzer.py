import unittest
from pathlib import Path
import sys
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "04-python"))
from log_analyzer import analyze_lines

class LogAnalyzerTests(unittest.TestCase):
    def test_status_levels_and_latency(self):
        lines = [
            'INFO path=/owners status=200 latency_ms=10',
            'ERROR path=/owners status=503 latency_ms=90 timeout',
            'WARN path=/vets status=200 latency_ms=20',
        ]
        out = analyze_lines(lines)
        self.assertEqual(out['lines'], 3)
        self.assertEqual(out['http_5xx'], 1)
        self.assertEqual(out['http_5xx_rate_percent'], 33.33)
        self.assertEqual(out['latency_max_ms'], 90.0)
        self.assertEqual(out['paths']['/owners'], 2)
        self.assertEqual(out['levels']['ERROR'], 1)

    def test_empty_input(self):
        out = analyze_lines([])
        self.assertEqual(out['lines'], 0)
        self.assertIsNone(out['latency_p95_ms'])
        self.assertIsNone(out['http_5xx_rate_percent'])

if __name__ == '__main__':
    unittest.main()
