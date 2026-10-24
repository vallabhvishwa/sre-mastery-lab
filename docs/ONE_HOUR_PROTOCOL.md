# The 60-minute playground protocol

Because the playground is ephemeral and only one can be open at a time, every session should produce a durable artifact in GitHub.

## Before opening a playground (5 minutes, outside the timer if possible)

- Pick exactly one lab card from `sessions/24_WEEK_PLAN.md` and `sessions/PLAYGROUND_SESSION_CARDS.md`.
- Write: the learning objective, success condition, and what will be submitted to GitHub.
- Open the last session's notes in your repository.
- Make sure you know which commands are read-only and which can mutate lab resources.

## Inside the one-hour playground

| Minutes | Activity | Rule |
|---|---|---|
| 00–05 | Confirm environment | `pwd`, `date -u`, OS/tool inventory, context/namespace if Kubernetes. Never assume the cluster context. |
| 05–12 | Baseline | Capture state before changing anything. |
| 12–25 | Build/inspect | Learn one concept and execute a small controlled exercise. |
| 25–42 | Incident drill | Solve one fault using evidence. Try without hints for at least 5 minutes. |
| 42–50 | Recovery and validation | Apply a reversible fix only in your disposable lab; re-run health checks. |
| 50–56 | Explain it | Write observations, hypotheses, tests, root cause, mitigation and prevention. |
| 56–60 | Preserve work | Copy sanitized notes/results to GitHub, commit scripts/docs, note the next session. |

If the environment is slow or resource-limited, simplify the exercise; do not spend the hour fighting setup. Move to a suitable playground from `PLAYGROUND_MAP.md`.

## Durable notes template

Create `journal/YYYY-MM-DD-labNN.md`:

```markdown
# Lab NN — title
- Playground:
- Objective / success condition:
- Baseline:
- User impact (for an incident drill):
- Observed facts (with commands/output):
- Hypothesis A / test / result:
- Hypothesis B / test / result:
- Root cause or best-supported conclusion:
- Mitigation / why it is safe:
- Recovery validation:
- Prevention / alert / test / automation:
- What I could not explain yet:
- Score (0–5):
- Next lab:
```

Do not commit credentials, kubeconfig files, tokens, cloud keys, unredacted internal logs, IPs/hostnames belonging to an employer, or generated machine snapshots. Keep raw output in gitignored `data/` and commit only sanitized takeaways.

## Use the playgrounds as separate specialist stations

Do not expect Docker, Kubernetes, Terraform, GCP, Prometheus and Ansible tools to coexist in one environment. The `PLAYGROUND_MAP.md` tells you which playground to pick for each task. One lab session = one primary playground, one measurable result, one note.
