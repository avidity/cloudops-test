GitHub Actions workflows live here.

Expected workflow behavior:

- run `ansible-lint`, `shellcheck`, and playbook syntax checks on pull requests
- auto-deploy to the `staging` GitHub Environment on pushes to `main`
- allow manual deploys to `staging` or `production` through `workflow_dispatch`

Required GitHub Environment secrets for each environment:

- `DEPLOY_HOST`
- `DEPLOY_SSH_PRIVATE_KEY`
- `DEPLOY_KNOWN_HOSTS`
