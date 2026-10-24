# PetClinic microservices practice path

Official repository: https://github.com/spring-petclinic/spring-petclinic-microservices

## Stage 0 — Inspect, don't guess

```bash
git clone https://github.com/spring-petclinic/spring-petclinic-microservices.git
cd spring-petclinic-microservices
git status --short
sed -n '1,240p' README.md
sed -n '1,260p' docker-compose.yml
```

Read the current upstream README before starting because dependencies and setup can change. Check `docker --version`, `docker compose version`, memory and disk first. A one-hour playground may not provide daemon permissions or sufficient memory; use your Mac with Docker Desktop or a suitable container playground if necessary.

## Stage 1 — Establish healthy baseline

1. Identify gateway, config server, discovery server, business services and storage dependencies.
2. Draw the dependency graph and critical user journeys.
3. Capture `docker compose ps`, service logs, gateway HTTP code/latency and available health endpoints.
4. Record normal startup time, resource usage, ports and known limitations.
5. Save baseline before trying a fault.

Follow the repository's current instructions to build/run; do not assume previous commands remain valid. Stop with `docker compose down` when done if using a disposable compose environment. Do not use `down -v` unless you explicitly intend to delete lab data.

## Stage 2 — one fault at a time

- Gateway 5xx: correlate route/request ID and upstream service state.
- Discovery failure: service registration, DNS/name, discovery endpoint.
- Slow dependency: queue/pool depth, latency budget, retry multiplication.
- Bad configuration: missing property/profile and config server health.
- Failed build/image: tag/digest, build logs, architecture, registry auth.
- Release regression: compare deployment markers and good/bad versions; define rollback trigger.

Prefer synthetic log scenarios first. Do not stop/kills services unless you control the isolated compose environment and have recorded how to restore it. Avoid official Chaos Monkey until healthy startup, cleanup, and exact flags are understood.
