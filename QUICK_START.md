# Quick start: first three one-hour sessions

## Before each session

Clone/pull the lab repo into the current KodeKloud playground. The lab environment may reset; do not assume it persists. Keep learning notes in tracked Markdown, and keep `data/` generated output out of Git.

## Session 1 — Linux baseline

1. Launch Ubuntu.
2. Run `./labctl.sh preflight`.
3. Run `./labctl.sh setup` and `./labctl.sh baseline`.
4. Examine `data/logs/petclinic_sample.log` with `./labctl.sh analyze data/logs/petclinic_sample.log`.
5. Complete `scenarios/session_001_linux_first_response.md`.
6. Create a report with `./labctl.sh report`; copy your sanitized conclusions into a tracked Markdown journal file.

## Session 2 — Network fault isolation

Follow `scenarios/session_002_network_fault_isolation.md`. Do not change routes or firewalls. Demonstrate DNS vs TCP vs TLS vs HTTP reasoning.

## Session 3 — P0 incident leadership tabletop

Follow `scenarios/session_003_p0_tabletop.md`. This is a tabletop, not real fault injection. Score yourself with `runbooks/p0_simulation_checklist.md`.

## Common commands

```bash
./labctl.sh preflight
./labctl.sh setup
./labctl.sh baseline
./labctl.sh case http_5xx
./labctl.sh diagnose
./labctl.sh report
./labctl.sh analyze data/logs/petclinic_sample.log
./labctl.sh slo --total 2000000 --bad 1400 --slo 99.9
./labctl.sh test
```

For other synthetic incidents, run `./labctl.sh case` with no argument to see available cases. Then diagnose the evidence before looking at `scenarios/answer_key.md`.

The synthetic scenario logs are not real incident data. Never use production credentials or run controlled failures outside a disposable lab.
