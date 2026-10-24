# One-hour KodeKloud playground cards

Select exactly one card and one playground per session. Use `sessions/ONE_HOUR_PROTOCOL.md`. If the listed tool isn't installed or the playground disallows a feature, document that and perform a tabletop/mock version instead.

## Linux playgrounds

### Ubuntu / Ubuntu 22.04 / Ubuntu 24.04 — first line SRE
- 0–5: preflight OS/tools.
- 5–15: `bash 01-linux/baseline.sh`; identify load, memory, block/inode, sockets, routes.
- 15–30: choose one from `01-linux/practice_tasks.md`.
- 30–42: investigate a synthetic scenario.
- 42–52: complete the incident template.
- 52–60: copy notes to Git; note one unknown.

### Ubuntu 24.04 Multi-Node — client/server
- 0–5: identify each node and access constraints.
- 5–15: record addresses, routes, name resolution, listening ports on both nodes.
- 15–30: reason through client → server request path; perform only allowed connectivity tests.
- 30–42: diagnose a provided DNS/TCP/refused/timeout scenario.
- 42–55: write a safe remediation/validation plan, not an unapproved firewall change.
- 55–60: clean up and save the diagram.

### Rocky / CentOS Stream / openSUSE / Alpine / Arch
- 0–10: identify distro, package manager, init system, core tools.
- 10–25: locate service logs and inspect process/service state.
- 25–40: complete one permissions, package, shell portability or systemd reasoning task.
- 40–50: explain which commands are GNU-specific and what differs across distros.
- 50–60: write a distro-neutral runbook with branches for missing commands.

## Kubernetes

### Single-node Kubernetes
- 0–5: `kubectl config current-context` and namespace/context verification.
- 5–15: baseline `get nodes,pods,deploy,svc -A` and events.
- 15–35: complete one card from `07-kubernetes/session_cards.md`.
- 35–45: write mitigation and rollback conditions.
- 45–55: validate the user-facing symptom using the evidence available.
- 55–60: record findings and cleanup.

### Multi-node / latest
- Focus on scheduler events, requests/limits, taints/tolerations, node conditions, capacity and PDB-safe maintenance planning. Avoid cluster-wide settings changes unless explicitly part of a guided disposable exercise.

### Multi-cluster
- Start by proving current context and cluster identity. Compare health using read-only commands. Build a checklist that prevents applying a command to the wrong cluster.

### HA etcd
- Study quorum, member health, leader/follower, snapshot and restore logic. Treat membership changes and restore commands as high-risk: follow the playground's exact guide; this card is primarily observational/tabletop.

### Calico / Flannel / gVisor / Kata / CRI-O / EFK
- Choose one stack per session. Draw the network/runtime/logging path, inspect current health, then diagnose one provided symptom. Do not reconfigure CNI or runtime at cluster scope without the lab guide.

### Helm
- Inspect chart templates/values, render output, compare revisions, identify configuration drift and propose rollback criteria.

### Istio / Linkerd
- Trace request through ingress/gateway, sidecar/proxy and workload. Explain 503/504, timeout/retry interaction, mTLS and destination health. Do not add retries to an already saturated dependency without a budget.

## Containers and programming

### Docker / Podman / containerd
- Preflight runtime; inspect one lab image/container; capture logs, exit code, command, port mapping, resource limits; explain the likely fault. Clean up only resources you created.

### Python
- Complete one programming task: log summarizer, health checker, JSON validator or SLO calculator. Write tests and exercise invalid input. Don't use the hour only to watch videos.

### Golang
- Complete one topic and one small coding task; run `go test ./...`; use explicit errors and bounded contexts/timeouts for network calls.

## CI/CD and GitOps

### Git / GitLab / Jenkins / CI/CD Sandbox
- Reproduce a failed build in a branch or sample job; inspect trigger, runner, checkout, permissions, environment, artifacts and logs; fix and revert. Never commit credentials.

### ArgoCD / FluxCD
- Compare Git desired state with cluster observed state; explain reconciliation, sync failure, drift and rollback strategy. Inspect current context before modifying anything.

## Observability

### Prometheus & Grafana / Prometheus with Helm
- Check scrape targets; inspect metric names/labels; write a request-rate query, error ratio and latency query if histogram data exists; design one actionable alert and a runbook.

### ELK / Nagios
- Follow an event from source to collection/index/search/alert. Explain sampling/retention, clock skew, ingestion lag and missing telemetry; don't assume no logs means no fault.

## Cloud and infrastructure

### Google Cloud / Terraform + GCP
- Read allowed-service limits first. Review project, identity, region, network and resource costs. Practise IAM, VPC, GKE, Artifact Registry, logs/monitoring and secure CI federation only if allowed. No uncontrolled `apply` or secrets in Git.

### Azure / Terraform with Azure
- Use your existing Azure knowledge to practise resource hierarchy, RBAC, VNets, AKS, diagnostics and plan review. Avoid employer subscriptions; use only assigned sandbox resources.

### Terraform + LocalStack / OpenTofu / Terragrunt / Pulumi
- Format, validate, inspect provider/backend/state, produce and explain a plan, detect unintended destroys and discuss drift. Apply only in a disposable authorized lab.

### Ansible / Chef / Puppet / SaltStack
- Inventory, connectivity, facts, idempotent file/package/service configuration, handlers, check/diff and secret handling. Use only provided target nodes.

### Vault / Consul
- Study identity, secret lifecycle, leases, rotation, policy and service health. Keep lab secrets out of notes and Git; never paste real secrets into a tool.

### PostgreSQL / MySQL / MariaDB / MongoDB / Redis
- Practice connection failures, pool exhaustion, slow query/latency symptoms, authentication and dependency timeout reasoning. Use only disposable data and avoid destructive statements.

### Kafka
- Study partitions, consumer groups, offsets, lag, throughput, broker health and backpressure. Use disposable topics; do not delete shared topics.

## AI playgrounds

Use AI tools as assistants, not authorities. Ask for an explanation/test plan, review each command/code diff, run tests in sandbox, and document any hallucinated or unsafe output. Never grant autonomous agents real production credentials or permission to deploy to live environments.
