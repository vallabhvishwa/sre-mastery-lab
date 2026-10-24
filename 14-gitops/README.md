# GitOps — Learning Module

## Goal

Understand how Git becomes the source of truth for infrastructure
and application deployments, and how controllers reconcile the
declared desired state with the live cluster state.

## Prerequisites

- Basic Git commands and branching
- Kubernetes Deployments, Services and namespaces
- YAML manifests
- kubectl basics

## Lab 1 — Declarative deployment

1. Inspect a Kubernetes Deployment and Service manifest.
2. Explain the desired state declared in each manifest.
3. Make a change in a disposable lab repository.
4. Review the diff before applying it.
5. Verify the live resources after applying the manifest.

## Lab 2 — Drift detection

1. Record the declared replica count in a manifest.
2. Compare it with the live Deployment.
3. In a disposable namespace, change the live replica count.
4. Observe the difference between declared and live state.
5. Reapply the desired configuration and verify the result.

## Lab 3 — GitOps controller

Use Argo CD or Flux if the playground supports it.

1. Connect a sample repository to a disposable cluster.
2. Observe application sync and health status.
3. Change a manifest in Git and observe reconciliation.
4. Compare manual sync with automatic sync.
5. Understand pruning, rollback and drift correction.

If the playground cannot run a controller, complete the lab as a
design exercise. Do not create cloud resources or install cluster
components without checking permissions and cost limits.

## Lab 4 — Production readiness

Explain:

- Repository permissions and least-privilege access
- Secret management without committing credentials
- Review and approval before deployment
- Rollback and recovery from a bad manifest
- How to investigate a failed reconciliation
- How to avoid accidental deletion of live resources

## Completion criteria

You can explain the reconciliation loop, distinguish desired state
from live state, diagnose sync failures, identify drift, and describe
a safe rollback strategy.

Use disposable environments only. Never experiment on production
or shared clusters.
