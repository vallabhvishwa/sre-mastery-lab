# SRE Mastery Lab — Linux → Distributed Systems → Production SRE

This repository is a **repeatable practice system**, not a promise that a fixed list of labs makes someone an expert. It is designed around your KodeKloud access: **one playground at a time, sessions limited to about 1 hour**, often with ephemeral environments.

The aim is to build the habits of a strong Google-level SRE: reason from evidence, understand systems deeply, write useful software, protect user-facing reliability, coordinate incidents, and prevent recurrence. No single lab can cover every P0; competence comes from repeated practice, feedback, reading, and real operational experience.

## First 60 minutes

From a Linux or Python playground, clone your GitHub repository (after you push this kit) or upload/unzip it into the playground. Then run:

```bash
./labctl.sh preflight
./labctl.sh setup
./labctl.sh baseline
./labctl.sh case http_5xx
./labctl.sh diagnose
./labctl.sh report
```

Read `docs/ONE_HOUR_PROTOCOL.md` before every session and choose a card from `sessions/PLAYGROUND_SESSION_CARDS.md`. On every reset, clone/pull the repository again; never assume a playground's filesystem persists. Store session notes in Git or another persistent location, not only in the playground.

## Non-negotiable safety rules

- Practice only in disposable environments you control. Never inject faults into employer/customer systems, shared clusters, or production.
- Most drills here are **synthetic or read-only by default**. There are no scripts that intentionally fill disks, kill critical processes, disable networking, delete cloud resources, or corrupt cluster state.
- Before any exercise that creates cloud resources, inspect cost/permission limits, budgets and cleanup commands. Do not put credentials, kubeconfigs, state files or tokens in Git.
- Use a separate branch or disposable namespace/cluster for experiments. Record the before-state. Make one change at a time and verify rollback.
- In an actual P0: follow your incident process, declare roles, communicate clearly, mitigate first, preserve evidence, and avoid uncontrolled changes. This lab is not an emergency-response substitute.

## Lab kit map

- `sessions/` — one-hour operating protocol, 24-week progression and playground-specific session cards for the exact lab types you listed.
- `01-linux/`, `02-networking/`, `03-bash/` — first-principles troubleshooting and safe practice tasks.
- `04-python/`, `16-go/` — SRE automation exercises and starter implementations; Python first for general SRE, Go foundations for platform-engineering roles that prefer it.
- `05-docker/`, `07-kubernetes/`, `06-ci-cd/`, `14-gitops/` — container and deployment operations.
- `08-observability/`, `10-sre/`, `09-incident-response/` — golden signals, PromQL, a tested SLO/error-budget calculator, production-readiness reviews, incident command and postmortems.
- `17-system-design/` — distributed-system design, capacity, overload and reliability trade-offs.
- `12-terraform/`, `13-ansible/`, `15-gcp/` — focused infrastructure and cloud practice. The GCP playground may not permit every service. Check before use.
- `11-petclinic/` — a controlled microservices project path.
- `scenarios/` — synthetic incident briefs; try before reading the answer key.
- `scorecards/` — measure learning by evidence and independent performance, not videos watched.
- `scripts/` — setup, preflight, session notes, wrap-up helpers and syntax/unit checks.

## The incident loop (use it every time)

1. **Impact:** Which users / actions / regions / dependencies are affected? Since when?
2. **Stabilize:** Assign incident commander, operations/technical lead, and communications lead when appropriate. Start a timeline. State what is known and unknown.
3. **Observe:** Gather the least invasive evidence; compare symptoms with a baseline.
4. **Hypothesize:** At least two plausible causes, and what evidence would distinguish them.
5. **Test:** One low-risk, reversible diagnostic at a time.
6. **Mitigate:** Choose the safest action likely to restore user impact. Avoid simultaneous speculative changes.
7. **Validate:** Verify user-visible success, dependencies, saturation, and rollback safety; watch for recurrence.
8. **Learn:** Root/contributing causes, detection gaps, action owners and due dates; blameless review.

A quick command is not a diagnosis. Record the output and explain what it proves—and what it does not prove.

## One-hour session contract

- 0–5 min: inspect environment, set target and safety boundary.
- 5–15 min: state expected normal behavior and take baseline evidence.
- 15–35 min: conduct the focused lab; no unrelated topic switching.
- 35–45 min: troubleshoot one deliberate/synthetic fault or answer a design question.
- 45–55 min: validate, clean up and write a short report.
- 55–60 min: score yourself, commit notes, name the next session.

If the playground resets early or lacks a tool, convert the task to a read-only reasoning exercise and record the limitation rather than fighting the sandbox.

## Validate the kit

Run `./labctl.sh test` on a machine with Bash and Python 3. The checks validate Bash syntax and run Python unit tests; they do not test every KodeKloud playground, cloud provider, Kubernetes version or the upstream PetClinic app.

## Useful official reading (free online)

- [Google SRE Books](https://sre.google/books/) — includes *Site Reliability Engineering*, *The Site Reliability Workbook*, and *Building Secure & Reliable Systems*. The SRE book site also announces a second edition; use it as a current reference when available.
- [Google SRE Workbook index](https://sre.google/workbook/index/) — SLOs, monitoring, alerting, toil, on-call, incident response, postmortems, load, and canarying.
- [Google SRE resources library](https://sre.google/resources/) — incident management, capacity planning, distributed systems, production readiness, toil and other topics.
- [Google SRE principles](https://research.google/pubs/sre-principles/) — reliability, monitoring, automation, error budgets and blameless postmortems.

Suggested reading cadence: one relevant chapter/article per week, then apply one idea in a lab. Don't read passively.

## A realistic definition of mastery

You are progressing when you can solve a new scenario without hints, collect evidence efficiently, describe uncertainty, choose a reversible mitigation, validate the user outcome, automate repeated work, and explain the trade-offs to another engineer. Google-level roles also expect strong coding/problem-solving and system-design skills; this plan includes those, but it cannot guarantee a role or replace substantial real-world practice.
