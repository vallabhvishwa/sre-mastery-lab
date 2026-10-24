# Docker/container session cards

Use the Docker or Podman playground. Check `docker info` / `podman info` first. Do not assume the host has privileged access.

1. Image vs container, registry vs tag/digest; inspect layers and size.
2. Read a Dockerfile; identify build context, cache invalidation, user, port, command and environment variables.
3. Run a known sample container and inspect `ps`, `logs`, `inspect`, exit code and restart policy.
4. Networking: published port vs container port, container DNS, listen address, host firewall boundaries.
5. Persistence: bind mount vs named volume; never delete volumes without understanding data impact.
6. Security: non-root user, read-only filesystem where suitable, minimal base, secrets never baked into image.
7. Debug a container that exits quickly using logs, command, exit code and dependency health—not random restarts.

Cleanup only lab-created resources. `docker system prune -a --volumes` is intentionally not provided because it may delete unrelated data.
