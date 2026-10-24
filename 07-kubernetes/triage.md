# Kubernetes incident triage card

Run in the Kubernetes playground and only against the cluster your playground assigned to you. Start read-only.

```bash
kubectl config current-context
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl get events -A --sort-by=.lastTimestamp
kubectl get deploy,rs,svc,ep -A
kubectl describe pod -n <namespace> <pod>
kubectl logs -n <namespace> <pod> --all-containers --tail=100
kubectl logs -n <namespace> <pod> --all-containers --previous --tail=100
kubectl rollout status -n <namespace> deploy/<name>
kubectl rollout history -n <namespace> deploy/<name>
```

Before any change, write down the namespace, workload, current image, replica count, events, recent rollout, resource limits and observed user impact. Use `kubectl rollout undo` only in a disposable lab and only after capturing the current revision; do not use it automatically as a first reaction.

## Symptom tree

- `Pending`: scheduling events → requests/capacity → taints/tolerations → affinity/constraints → PVC.
- `ImagePullBackOff`: image ref/tag/digest → registry reachability → pull secret/service account → architecture.
- `CrashLoopBackOff`: current + previous logs → command/args/config/secret → dependency → probe/exit code → resource pressure.
- Service unreachable: pod ready? → service selector/endpoints → ports and bind address → NetworkPolicy → ingress/gateway → DNS.
- `OOMKilled`: container limit → working set/traffic → memory leak or load spike → other container/node pressure.
- DNS: test from source pod → service name/namespace → CoreDNS health and events → policy → upstream resolver.
- rollout stuck: readiness → unavailable replicas/PDB → image pull → startup duration → capacity.

After each mitigation, validate the user-facing endpoint and observe for recurrence. A `Running` pod is not the same as a healthy service.
