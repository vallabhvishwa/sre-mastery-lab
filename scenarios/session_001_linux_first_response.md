# Session 001 — Linux first response (Ubuntu, 60 minutes)

## Goal
Create a trustworthy baseline and distinguish host symptoms from root cause.

## Minutes
- 0–5: run `./labctl.sh preflight`; list unavailable commands.
- 5–15: run `./labctl.sh setup` and `./labctl.sh baseline`; identify three notable results and three normal results.
- 15–25: inspect `~/sre-lab/logs/app.log` with `grep`, `awk`, `sort` and `wc`. Report request IDs that failed.
- 25–35: run `./labctl.sh case http_5xx` then `./labctl.sh diagnose`. Do not read answer key yet.
- 35–45: write at least two hypotheses and the safest test that distinguishes them.
- 45–55: write the incident report and state mitigation/validation/prevention.
- 55–60: run `./labctl.sh report`; save notes outside playground.

## Pass criteria
You can explain what each command measures, what it cannot prove, why `/vets` being healthy matters, and what further evidence is needed before choosing a fix.
