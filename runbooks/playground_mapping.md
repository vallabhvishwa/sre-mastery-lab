# KodeKloud playground-to-skill map

One playground per 1-hour session. Not every playground exposes every command or permission.

| Playground you listed | Best uses | Good first sessions | Cautions |
|---|---|---|---|
| Ubuntu / Ubuntu 22.04 / Ubuntu 24.04 | Linux, Bash, Python, networking | baseline, files/permissions, process/memory, DNS/HTTP | systemd may be absent; outbound net may be blocked |
| Ubuntu 24.04 Multi-Node | SSH, client/server, DNS, systemd/service troubleshooting | two-host request path, SSH, route/DNS reasoning | only change assigned lab nodes |
| Rocky Linux / CentOS Stream | RHEL-like service/log/package differences | systemd, logs, package/service troubleshooting | package manager/root access may vary |
| Alpine | BusyBox, minimal-container OS, shell portability | missing utility troubleshooting, POSIX shell | don't assume GNU flags |
| OpenSUSE | distribution comparison, system administration | service and package-manager comparison | syntax/package names differ |
| Kubernetes single-node | objects, deployments, services, pods | Pending, CrashLoopBackOff, rollout | read current context first |
| Kubernetes multi-node/latest | scheduler, node pressure, taints, drains | scheduling and node lifecycle | avoid destructive cluster-wide changes |
| Kubernetes Multi-Cluster | fleet context and cluster selection | context safety, compare cluster health | verify current context before every command |
| HA ETCD Cluster | control-plane state/consensus concepts | quorum, snapshot/restore theory | do not experiment with membership without exact lab guide |
| K8s with Calico / Flannel | CNI and pod connectivity | pod-to-pod vs service path | don't change cluster-wide CNI settings blindly |
| K8s with EFK | logs aggregation and troubleshooting | find service error across containers | check storage/retention scope |
| Prometheus & Grafana / Prometheus with Helm | metrics, PromQL, dashboards, alerting | scrape targets, rates, error ratio | metric names/exporters vary |
| Docker / Podman / containerd | images, containers, runtime/logs | exit codes, ports, image build | cleanup only lab-created resources |
| Istio / Linkerd | service mesh, traffic, mTLS, retries | 503/504 and timeout layers | multiple retries can cause overload |
| Helm / ArgoCD / FluxCD | packaging, GitOps, drift, rollback | chart/values, sync status | don't force-sync shared cluster resources |
| Git / GitLab / Jenkins / CI/CD Sandbox | SCM, pipelines, runner and build failure | branch, test, artifact, failed build | don't store secrets in repos/logs |
| Python / Golang | programming, tests, APIs, automation | log parser, health checker | isolate outbound HTTP and tokens |
| Ansible | inventories, modules, playbooks | ping, facts, idempotent file/package task | use only provided targets |
| Terraform + LocalStack | IaC plan/state/module workflow | fmt, validate, plan and drift | don't copy cloud credentials into repo |
| Terraform + GCP / Google Cloud | GCP resource/IAM/GKE concepts | IAM and network first | inspect allowed services, budgets and cleanup |
| Terraform with Azure | Azure provider, state and plans | understand existing plan | no applies against personal/employer subscriptions unless approved |
| Vault | secrets lifecycle and identity | read concepts, safe lab secret usage | never commit secrets or real tokens |
| Consul Datacenter | service discovery/health and KV concepts | health, service registration | avoid cluster reconfiguration without lab guide |
| PostgreSQL/MySQL/MariaDB/Redis/MongoDB | connection pools, latency, data dependencies | connection failure, query latency concepts | do not delete/alter data casually |
| Kafka | consumer lag, brokers, partitions and throughput | lag/producer/consumer signals | use only disposable topics |
| OpenAI/Codex/Claude Code/MCP/N8n | AI-assisted tools and controlled automation | ask AI to explain/write tests, review diff | never give agents production creds; verify every command |

## 1-hour playbook examples

- Linux session: 5 min preflight → 10 min baseline → 20 min selected task → 10 min synthetic fault → 10 min report/cleanup → 5 min notes.
- Kubernetes session: 5 min context and namespace verify → 10 min get/events baseline → 20 min incident → 10 min mitigation plan → 10 min validation/report → 5 min cleanup.
- Prometheus session: 5 min target check → 10 min inspect metrics → 20 min 2 queries and panel → 10 min alert design → 10 min explain false positives → 5 min save notes.
- Terraform session: 5 min inspect files/provider/workspace → 10 min fmt/validate → 20 min plan review → 10 min find unsafe changes → 10 min document cleanup → 5 min exit. Do not apply unless explicitly authorized.
