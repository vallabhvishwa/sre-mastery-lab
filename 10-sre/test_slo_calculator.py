import unittest
from slo_calculator import calculate

class SLOCalculatorTests(unittest.TestCase):
    def test_budget(self):
        result = calculate(2_000_000, 1_400, 99.9)
        self.assertEqual(result["allowed_bad_requests_for_this_volume"], 2000.0)
        self.assertEqual(result["remaining_budget_requests"], 600.0)
        self.assertFalse(result["budget_exhausted"])
    def test_exhausted(self):
        self.assertTrue(calculate(1000, 2, 99.9)["budget_exhausted"])
    def test_invalid_total(self):
        with self.assertRaises(ValueError):
            calculate(0, 0, 99.9)

if __name__ == "__main__":
    unittest.main()
