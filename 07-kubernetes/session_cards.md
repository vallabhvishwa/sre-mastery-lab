# Kubernetes one-hour session cards

For each card: 5m environment/context check; 10m baseline; 20m investigation; 10m fix/design decision; 10m validation/cleanup; 5m report.

1. Architecture and objects: draw API server, scheduler, controllers, etcd, kubelet, pod, service and ingress.
2. Pending pod: inspect events and explain the specific scheduling blocker. Don't change node capacity blindly.
3. CrashLoopBackOff: collect logs/current+previous, describe, config and exit code. Use a throwaway workload if you create one.
4. ImagePullBackOff: distinguish bad image tag, registry auth, rate limit, network, and architecture.
5. Service unreachable: inspect selectors, endpoints, ports, pod readiness, policy and ingress path.
6. DNS failure: test from inside a disposable pod if allowed; reason from resolver, service FQDN and CoreDNS.
7. Memory pressure: compare requests, limits, restart reasons and metrics; explain QoS and OOM behavior.
8. Rollout blocked: examine readiness, unavailable replicas, PDB, node capacity and events; create rollback criteria.
9. HPA not scaling: inspect metrics API, targets, resource requests, min/max and time to scale.
10. Node drain/upgrade: create a plan that accounts for PDBs, capacity, daemonsets, local storage and maintenance window.
11. RBAC denied: use `kubectl auth can-i` with the lab identity where permitted; principle of least privilege.
12. NetworkPolicy: diagram allowed ingress/egress; do not apply untested default-deny to a shared namespace.
