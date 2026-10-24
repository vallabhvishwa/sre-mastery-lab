# Networking field guide for SREs

## Layered fault-isolation sequence

1. **Name:** Is the hostname correct? `getent hosts name` / `dig name` when available. Distinguish NXDOMAIN, SERVFAIL and timeout.
2. **Route:** Does the host have the expected address and route? `ip addr`, `ip route`.
3. **Listener:** Is there a process bound to the expected port/address? `ss -lntup`; check loopback vs 0.0.0.0 vs pod IP.
4. **TCP:** Connection refused usually means a reachable endpoint rejected/no listener; timeout may mean routing, policy, packet drop or overloaded endpoint. Neither alone proves root cause.
5. **TLS:** Validate SNI/hostname, certificate dates/chain, trust store and protocol mismatch. Avoid `curl -k` as a “fix”.
6. **HTTP:** Inspect status, headers, redirects, response body, retries and total time. 4xx often points to request/auth; 5xx can be proxy, app or dependency—correlate logs.
7. **Application/dependency:** Check request ID, server timing, downstream latency, pool/queue saturation and error rates.

## Useful commands (read-only unless noted)

```bash
ip addr show
ip route show
cat /etc/resolv.conf
getent hosts example.com
ss -lntup
curl -sv --max-time 4 https://example.com -o /dev/null
```

`curl` uses outbound network access. In isolated playgrounds, failure may reflect sandbox policy, not your diagnosis. Do not alter firewall/routes in a shared environment.

## Interview exercise
A service returns 504 at the gateway, but direct service requests sometimes succeed. Describe a plan to separate gateway timeout configuration, downstream latency, connection pool exhaustion, packet loss and load-related saturation. Define what evidence would falsify each hypothesis.
