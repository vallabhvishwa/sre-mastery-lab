# Session 003 — P0 incident command tabletop (no real fault injection)

Scenario: a new release is followed by widespread 5xx and p99 latency increase. A dependency is slow; retries and queue depth rise. Telemetry is delayed. A rollback may break schema compatibility. A senior stakeholder asks for an ETA.

- 0–5: assign incident commander, technical lead, communications lead and scribe.
- 5–10: state impact, severity under hypothetical policy, known/unknown and next update time.
- 10–20: identify 3 evidence sources and at least 2 hypotheses.
- 20–30: choose mitigation; explain why it is reversible and what condition stops it.
- 30–40: address retry storm, queue overload, dependency protection and rollback/schema compatibility.
- 40–50: deliver two mock status updates and define recovery criteria using a user-facing SLI.
- 50–60: write postmortem outline, prevention actions, score using `runbooks/p0_simulation_checklist.md`.

Pass criteria: minimize impact before deep root cause, avoid unsupported ETA, communicate next update, validate user outcome, and assign measurable follow-ups.
