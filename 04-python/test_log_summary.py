import tempfile
import unittest
from pathlib import Path
from log_summary import summarize

class LogSummaryTests(unittest.TestCase):
    def test_counts_levels_status_and_path(self):
        with tempfile.TemporaryDirectory() as directory:
            log = Path(directory) / "app.log"
            log.write_text("INFO path=/vets status=200\nERROR path=/owners status=503\nnoise\n", encoding="utf-8")
            result = summarize(log)
            self.assertEqual(result["total_lines"], 3)
            self.assertEqual(result["levels"]["ERROR"], 1)
            self.assertEqual(result["http_statuses"]["503"], 1)
            self.assertEqual(result["top_paths"][0][0], "/vets")
            self.assertEqual(result["lines_without_level"], 1)

if __name__ == "__main__":
    unittest.main()
