# Session 002 — DNS vs TCP vs TLS vs HTTP (Linux, 60 minutes)

## Goal
Separate failure layers without changing any firewall or route.

- 0–5 preflight and state safety boundary.
- 5–15 `ip addr`, `ip route`, `/etc/resolv.conf`, `ss -lntup`.
- 15–25 `getent hosts example.com`; use `curl -sv --max-time 4 https://example.com -o /dev/null` only if outbound network is permitted.
- 25–35 explain four scenarios: NXDOMAIN, connection refused, timeout, certificate hostname mismatch.
- 35–45 write a decision tree: which command narrows which layer?
- 45–55 complete lab report; mention sandbox network restrictions as an alternate explanation.
- 55–60 save notes and cleanup scratch files.

Pass criteria: no claim that “network is down” based on one command; clear distinction between DNS, route, listener, TCP, TLS and application status.
