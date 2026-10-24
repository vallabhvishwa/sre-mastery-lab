# KodeKloud Playground map

Choose one playground per session. This is a decision guide, not a claim that every listed capability is enabled in every plan/session. Verify commands and permissions after launch.

## Linux playgrounds

| Playground | Best labs | What to save |
|---|---|---|
| Ubuntu / Ubuntu 22.04 / Ubuntu 24.04 | Linux fundamentals, systemd, logs, disk/inodes, users, Bash, networking | Sanitized command notes and incident report |
| Ubuntu 24.04 Multi-Node | SSH between nodes, routing, service dependencies, node-to-node failure diagnosis | Topology sketch + proof of connectivity before/after |
| Rocky Linux / CentOS Stream / openSUSE | Linux portability, package/service differences, permissions and systemd comparisons | A “same task, different distro” comparison |
| Alpine Linux | Minimal OS, BusyBox/tool availability, containers and debugging with missing tools | Minimal-image troubleshooting checklist |
| Arch Linux | Optional comparison of rolling-release package/service lifecycle | Short risk/change plan; don't prioritise over Ubuntu/RHEL-like systems |

## Kubernetes playgrounds

| Playground | Best labs | Safety boundary |
|---|---|---|
| Kubernetes single-node | Deployments, probes, Services, ConfigMaps, labels, events, rollouts | Use only `sre-lab` namespace; avoid system namespaces |
| Kubernetes multi-node (latest) | Scheduling, resource requests, node conditions, PDB, drain/upgrade theory | Do not drain/delete nodes unless the exercise explicitly provides a disposable cluster and recovery plan |
| Kubernetes Multi-Cluster | Context hygiene, cluster comparison, promotion, GitOps concepts | Confirm `kubectl config current-context` before every mutation |
| Kubernetes with Calico | NetworkPolicy and pod connectivity | Isolate to test namespaces and labels |
| Kubernetes Flannel CNI | Pod network path and CNI troubleshooting concepts | Never change CNI configuration on a shared cluster |
| K8s with CRI-O / containerd | Runtime, image pulls, pod sandbox/startup problems | Read logs/events; do not change host runtime config without a dedicated exercise |
| HA ETCD Cluster | Quorum, leader, member health, backup/restore theory | Read-only inspection first. Never remove members or alter quorum as an experiment |
| Kubernetes with EFK | Log query, filtering, correlation, retention/volume concerns | Use synthetic logs only |
| Prometheus with Helm | Metrics scraping, ServiceMonitor/targets, alert rules | Never use production endpoints or credentials |
| Helm | Values, templates, release history, rollback | Use a throwaway namespace/release |
| Istio | mTLS, VirtualService/DestinationRule, gateways, retries/timeouts, telemetry | Prefer provided sample app and namespace; don't alter shared mesh settings |
| Linkerd | Service mesh metrics and request paths | Sample workloads only |
| gVisor / Kata Containers | Runtime isolation concepts and trade-offs | Learn/debug provided sample workloads; don't attempt to bypass sandbox restrictions |
| Jsonnet Tanka | Declarative config generation and environment overlays | Render/diff before apply |

## Containers

| Playground | Best labs | What success looks like |
|---|---|---|
| Docker | Build image, inspect image layers, container networking, volumes, logs and healthchecks | Explain difference between process exit, healthcheck failure and network failure |
| Podman | Rootless containers and Docker-compatible workflows | Run a small app without root and diagnose permissions |
| containerd | Runtime/container lifecycle concepts | Explain image, snapshot, container and task distinctions |
| Buildpacks.io | Reproducible app build without hand-written Dockerfile | Compare output artifact and build metadata with a Dockerfile approach |

## Cloud / IaC / automation

| Playground | Best labs | Guardrail |
|---|---|---|
| Google Cloud | GCP resource hierarchy, IAM/service accounts, VPC, Compute Engine, GKE and Cloud logging/monitoring concepts as enabled | Do only allowed services; verify costs/permissions. Do not assume Cloud Build is allowed just because GKE is listed |
| Azure | Azure identity, VNets, VMs, AKS concepts and cloud-to-cloud mapping | Use a sanctioned sandbox; no real subscription changes without approved scope/budget |
| AWS | IAM, networking, compute, container/observability concepts | Same: sandbox only, budget guardrails, inspect plans first |
| Terraform + GCP / Terraform with Azure / Terraform + AWS | HCL, plan/apply, state, drift, dependencies, variables and outputs | Start with `fmt`, `validate`, and `plan`; only apply disposable resources and delete via reviewed plan |
| Terraform + LocalStack | Local cloud APIs, Terraform lifecycle and state without public cloud resources | Verify endpoint is the local sandbox before apply |
| Terraform + LocalStack / OpenTofu / Terragrunt | State, module composition, dependency graph, plan review | Don't commit state or credentials |
| Ansible | Inventory, ping, playbooks, handlers, roles, templates, check mode and idempotency | Use provided target nodes or localhost lab files; never target employer hosts |
| HashiCorp Vault | Policies, auth methods, short-lived credentials, leases and rotation concepts | Never paste real secrets into terminal transcripts or GitHub |
| Consul 3-node | Service discovery, health checks, KV and quorum/availability concepts | Inspect the topology; never break quorum on a shared environment |
| Crossplane + AWS / Pulumi + AWS / Chef / Puppet / Salt | Compare reconciliation and configuration management models | Treat as optional after Terraform/Ansible core |

## CI/CD and GitOps

| Playground | Best labs | Durable output |
|---|---|---|
| Git | Branching, revert, reset vs revert, bisect, conflict recovery | Commit history and a short incident note |
| CI/CD Sandbox | Pipeline stages, artifacts, approvals, failure handling | Stage diagram and failed-build root cause |
| GitLab | Pipeline YAML, runners, variables, artifacts and environments | Equivalent pipeline compared with GitHub Actions |
| Jenkins | Declarative pipeline, agents, credentials, plugins and queue troubleshooting | Minimal Jenkinsfile + failure/fix notes |
| ArgoCD | Desired vs live state, sync, drift, health, rollback | Demonstrate reconciliation, not just manual `kubectl apply` |
| FluxCD | GitOps reconciliation, source/controller status and secrets concepts | Git commit → reconciliation → observed cluster state |
| Azure DevOps | YAML pipelines, service connections, approvals and environments | Compare with GitHub Actions concepts |
| GitHub Actions | Use the GitHub repository itself; actions runners are not necessarily a KodeKloud playground | Workflow file, run URL, tests, permissions and short postmortem for one failed run |

## Programming, data and observability

| Playground | Best labs | What to practise |
|---|---|---|
| Python | Scripting, JSON/API calls, health checks, log analysis, tests | Commit code + tests to repo; run `python3 -m unittest discover -s tests -v` |
| Golang | Syntax, HTTP server/client, errors, tests, concurrency, CLI tools | Write and test one small operational utility |
| Java / Maven | Understand PetClinic build/test and JVM memory/thread basics | Build/test output and a JVM troubleshooting note |
| Prometheus & Grafana | RED/USE metrics, PromQL, dashboards, alert windows | One dashboard and one actionable alert with a runbook |
| ELK Stack | Log parsing, fields, time ranges, correlation and noisy-alert reduction | Query examples and synthetic incident timeline |
| Kafka | Producer/consumer, partitions, offsets, consumer lag, rebalancing | Diagram and diagnosis of rising lag |
| PostgreSQL / MySQL / MariaDB | Connections, locks, slow queries, indexes, replication concepts | Query plan/lock analysis using provided sample data only |
| Redis | Cache hit ratio, eviction, TTL, latency, memory and cache stampede concepts | Small runbook for stale/slow cache or memory pressure |
| MongoDB | Query/index/connection and replication concepts | Diagnose using provided lab data |
| n8n / MCP / AI coding playgrounds | Tool-assisted incident workflow and safe AI-assisted coding | Include human approval, least privilege, evidence links and tests; AI output is not proof |

## Tool-selection rule

If a command is missing or a service is blocked, record the limitation and move to the matching playground. Do not install a large toolchain into a 1-hour session unless that installation is itself the objective.
