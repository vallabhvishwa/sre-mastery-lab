# SLI/SLO/error-budget workbook

## Define the user journey first

Example: “A valid request to retrieve a customer record returns a correct response within 500 ms.” Define what counts as a valid/eligible event and how measurement is sampled end to end.

- **SLI:** measurable proportion/value of good events (e.g., good requests / eligible requests).
- **SLO:** internal target over a time window (e.g., 99.9% good requests over 30 days).
- **SLA:** external agreement with terms/consequences; do not casually equate it with an SLO.
- **Error budget:** allowed bad events over the SLO window, based on the chosen SLI and event volume.

## Arithmetic drill

For a request-based SLI:

- eligible requests = 2,000,000
- SLO = 99.9%
- allowed bad requests = eligible requests × (1 − SLO) = 2,000
- if 1,400 bad requests have occurred, remaining budget = 600
- observed error ratio = bad requests / eligible requests

For an availability/time-based model, use the eligible time window instead; don't mix request-based and time-based units.

## Burn rate

Burn rate = observed error ratio / allowed error ratio. A burn rate of 5 means budget is being consumed 5× as fast as the SLO's average allowance. Real alerting should consider both short and longer windows and service-specific user impact. Do not alert solely on a single noisy percentage without volume/context.

## Exercise

Choose an SLI for PetClinic read requests and one for writes. State event eligibility, aggregation, SLO window, target rationale, error budget, budget policy, and what action occurs if budget burn is high. Identify failure modes your SLI misses, such as technically successful but incorrect/stale data.
