Here you place ansible files, playbooks, roles, everything needed for it to work

NOTE: This specific stack of redis and postgres was new to me.

## Prerequisites

1. Obtain the deploy private key from your team's secret manager
2. `cp deploy_key ~/.ssh/deploy_key && chmod 600 ~/.ssh/deploy_key`
3. Obtain the vault password and place it at `~/.vault_pass`
4. `chmod 600 ~/.vault_pass`

## Running the Playbooks

```bash
# Provision staging
ansible-playbook ansible/provision.yaml -i ansible/inventories/staging/hosts.yaml

# Provision production
ansible-playbook ansible/provision.yaml -i ansible/inventories/production/hosts.yaml

# Deploy latest
ansible-playbook ansible/deploy.yaml -i ansible/inventories/staging/hosts.yaml

# Deploy specific tag
ansible-playbook ansible/deploy.yaml -i ansible/inventories/staging/hosts.yaml -e app_image_tag=v1.2.3
```

## Decisions

- Postgres and Redis run as containers, not bare metal installs
- Secrets in `group_vars/all/vault.yaml`, encrypted with ansible-vault
- Private key never stored in the repo, only the public key is in vault
- Postgres and Redis configs based on examples online
- [Redis Docs:] (https://redis.io/docs/latest/develop/reference/eviction/)
- [Postgres conf:] (https://konfy.io/config/redis-production-conf-persistence)
  documentation — they would need tuning based on real workload in production
- TLS cert paths in Nginx are placeholders — in production these would be
  provisioned via certbot, or alternatively use Caddy

## GitHub Actions

- `lint.yaml` runs ansible-lint and shellcheck on every push
- `deploy.yaml` deploys to staging first, then production on success
- `DEPLOY_SSH_PRIVATE_KEY` and `VAULT_PASSWORD` are configured in GitHub
  Environments and Secrets, never committed to the repo
