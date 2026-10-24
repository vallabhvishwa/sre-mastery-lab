# P0/P1 incident command practice

This is a **tabletop** template. In a real incident, follow your employer's incident-management policy.

## Initial 2 minutes

1. State the user/business impact and affected scope; separate facts from assumptions.
2. Declare severity according to policy and open a timestamped incident log.
3. Assign roles when staffing permits: Incident Commander (coordination/decisions), Ops/Technical Lead (investigation/mitigation), Communications Lead (stakeholders), plus focused workstream owners.
4. Set a communication cadence and a next-update time. Name the current hypothesis as a hypothesis, not a fact.
5. Start parallel work only when tasks are independent. Avoid several people making uncoordinated changes to the same system.

## Decision discipline

- Mitigation is usually the priority: rollback, stop rollout, disable a feature, shift traffic, shed load, or fail over only if the action is understood and safe.
- Preserve evidence: deployment history, logs, metrics, traces, config diff and timestamps.
- Use bounded actions and define a stop/rollback condition before execution.
- Validate customer-facing success, not merely component status.
- Keep updates short: impact, current state, actions, risks, next update.

## Tabletop scenario

A deployment coincides with a sudden increase in 5xx and p99 latency across multiple regions. A dependency is slow; retries and queue depth rise. Monitoring is delayed by 2 minutes. A manager asks for an ETA. The rollback also changes schema compatibility.

You must decide: severity and roles; the first user-impact statement; the top three evidence sources; the safest mitigation options; what to do about retries/overload; how to handle schema-compatible rollback; what to tell stakeholders; and the criteria for declaring recovery.

## Recovery criteria

- User SLI returns to expected range for a defined observation period.
- Queue/backlog, saturation and downstream health are recovering.
- No unhandled side effects or data integrity risks are visible.
- Rollout/traffic state is understood; owner agrees on monitoring watch.
- Follow-up actions have owners and deadlines.
