# Avidity DevOps Engineer Test

# CloudOps Test

This repository contains Ansible playbooks and configurations for provisioning and deploying a web application.

## Provisioning

To provision a host for serving web application requests, use the following command:

```bash
make provision

## TODOs
- Replace configurations in the roles/common/templates with the actual production ready configuration for nginx, postgresql and redis
- Create Python App with docker image pushed to registry and update the url in ansible/roles/app/tasks