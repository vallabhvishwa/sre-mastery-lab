# Ansible practice card

Use the Ansible playground and its assigned targets. Keep credentials supplied by the lab; do not store SSH keys or vault passwords in Git.

First hour: `ansible --version`; inspect the provided inventory; `ansible all -m ping`; inspect facts; write a playbook for a harmless package/file/service task only if the targets are disposable and authorized.

Checklist:
- Inventory/host groups; connection and privilege escalation.
- Modules vs shell commands; prefer idempotent modules.
- Variables, templates, handlers, roles and tag usage.
- `ansible-playbook --syntax-check`; `--check --diff` where supported.
- Ansible Vault concept and secret handling.
- Re-run playbook and explain why the second run should be unchanged.

Exit gate: configure two disposable hosts repeatably and show evidence that a second run creates no unnecessary changes.
