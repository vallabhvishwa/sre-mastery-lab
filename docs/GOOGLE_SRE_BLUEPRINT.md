# Google-level SRE blueprint: what “ready” means

## The bar is a combination, not a tool checklist

A strong SRE can move between software engineering and operations. The lab must build the following skills together:

1. **Software engineering:** write readable, testable Python/Bash (and later Go if the target roles expect it), review code, use Git, debug, handle errors, test edge cases, and understand data structures/algorithms.
2. **Linux and networking:** processes, memory, CPU scheduling, filesystems, file descriptors, syscalls at a conceptual level, DNS, TCP, TLS, HTTP, routing, sockets, packet loss and latency.
3. **Distributed systems:** partial failures, timeouts, retries/backoff/jitter, idempotency, queues, caching, replication, consistency, load balancing, rate limiting, backpressure and cascading failures.
4. **Production operations:** define impact, prioritise by user impact, communicate clearly, make reversible mitigations, validate recovery, protect evidence, and write blameless postmortems.
5. **Reliability engineering:** SLIs, SLOs, error budgets, alert quality, toil elimination, capacity planning, graceful degradation, load tests and failure testing.
6. **Cloud/platform operations:** containers, Kubernetes, infrastructure as code, configuration management, CI/CD, identity, networking, observability and safe lifecycle upgrades.
7. **System design:** design a service under load and explain dependencies, bottlenecks, failure domains, capacity, security, observability, data durability and recovery.

Google's published SRE role descriptions explicitly call out software development and data structures/algorithms, along with Unix/Linux, IP networking, performance/application issues and analysing complex systems. Requirements vary by level and team; prepare against the particular job description, not a generic “Google interview”.

## Official learning backbone

Read these free online materials in parallel with the labs. Use them to explain the *why*, not as a replacement for practice.

- Google SRE book: https://sre.google/sre-book/table-of-contents/ — SLOs, toil, monitoring, alerting, on-call, troubleshooting, emergency response, postmortems, testing, overload and cascading failures.
- Google SRE Workbook: https://sre.google/workbook/table-of-contents/ — SLO implementation, monitoring, alerting, incident response, postmortems, managing load, canarying and overload recovery.
- Google SRE resources hub: https://sre.google/resources/
- Google Careers SRE roles: https://www.google.com/about/careers/applications/jobs/results/?q=site%20reliability%20engineer

## What “strong enough” means in this lab

For each core domain, target level 4/5 on `scorecards/competency_matrix.md` for three different scenarios, including one unseen scenario. A 5 means you can diagnose and recover safely, explain alternatives, automate repeatable work, test the fix, and identify what evidence would falsify your hypothesis.

No lab kit can guarantee a Google offer or make someone ready for every possible P0. Production outages involve unfamiliar systems, ambiguous evidence and organisation-specific constraints. Our goal is to build a repeatable approach so you become calmer, safer and faster under pressure.
