# GCP/GKE practice with restricted playground

First read the KodeKloud playground's own **Allowed Services / View Limits** and confirm which services, regions, quotas and identities are provided. The sandbox is temporary but not an invitation to bypass its restrictions.

Order:
1. GCP project/resource hierarchy; regions and zones.
2. IAM principals, roles, service accounts, least privilege.
3. VPC/subnets/routes/firewall rules and DNS.
4. Compute Engine instance/metadata/logs concepts.
5. Artifact Registry and image authentication.
6. GKE workloads, nodes, deployments, services, ingress and upgrades.
7. Cloud Logging/Monitoring and alerting.
8. GitHub Actions → GCP authentication: learn Workload Identity Federation conceptually first; configure only if the lab gives authorized support.

For each operation, record the project, region, resource created, likely cost, cleanup command and confirmation of cleanup. Never paste service-account keys into a public repo or GitHub Actions file. If Cloud Build or any service is not allowed, use a local/mock version and note the limitation.
