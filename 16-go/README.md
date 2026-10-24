# Go for platform engineering

Python is the main SRE automation language in this plan; Go is an additional priority when applying for roles that prefer Go. Start with the KodeKloud Go playground, one session per concept.

1. `go version`, `go env`, create module `go mod init example.com/sre-healthcheck`.
2. Variables, slices/maps, functions, structs, methods, pointers and interfaces.
3. Explicit error handling; wrap errors with context, don't panic for expected failures.
4. HTTP clients with request context/deadlines; never use unbounded requests.
5. JSON decoding and validation.
6. Unit tests (`go test ./...`), table-driven tests and `httptest`.
7. Goroutines/channels, cancellation, wait groups, race detection, goroutine leaks.
8. Graceful shutdown, signal handling, structured logs and small CLI tools.

Build: a concurrent endpoint health checker with a bounded worker pool, global timeout, per-request timeout, cancellation and table-driven tests. Never expose tokens in errors or logs.
