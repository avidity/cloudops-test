# Avidity DevOps Engineer Test

# Production Deployment with Ansible and GitHub Actions

This repository provides a solution for automating the production deployment of a web application using Ansible for infrastructure provisioning and configuration and GitHub Actions for CI/CD.

## Project Components

- Ansible Playbooks: The `ansible/` directory contains Ansible playbooks for provisioning AWS EC2 instances, deploying the web application, and configuring services like Docker, PostgreSQL, Nginx, and Redis.

- GitHub Actions Workflows: The `.github/workflows/` directory includes two GitHub Actions workflows: `deploy.yml` for deployment to production.

- Roles: The `ansible/roles/` directory organizes tasks into reusable Ansible roles for modularity and maintainability.

- Scripts: The `app/` directory stores custom scripts or utilities used in the deployment process.

## Getting Started

To set up and use this project:

1. Clone the repository to local machine:

   git clone https://github.com/avidity/cloudops-test.git

2. Install Ansible on local machine if not already installed:
   pip install ansible

3. Create AWS credentials file (ansible/vars/aws_credentials.yml) with AWS access key, secret key, and region:
    aws_access_key_id: AWS_ACCESS_KEY_ID
    aws_secret_access_key: AWS_SECRET_ACCESS_KEY
    aws_default_region: AWS_REGION

4. Create Docker registry credentials file (ansible/vars/docker_registry_credentials.yml) with Docker registry username and password:

    docker_registry_username: DOCKER_REGISTRY_USERNAME
    docker_registry_password: DOCKER_REGISTRY_PASSWORD

5. Configure the inventory.ini file in the ansible/ directory with target EC2 instance(s).

6. Customize the Ansible playbooks and roles in the ansible/ directory to match application and infrastructure requirements.

7. Push changes to repository and trigger the GitHub Actions workflows.


# GitHub Secrets

Add the following secrets to GitHub repository for secure access to credentials:

AWS_ACCESS_KEY_ID: AWS access key ID.
AWS_SECRET_ACCESS_KEY: AWS secret access key.
AWS_DEFAULT_REGION: AWS region.
DOCKER_REGISTRY_USERNAME: Docker registry username.
DOCKER_REGISTRY_PASSWORD: Docker registry password.

# Workflow Details

The deploy.yml workflow is triggered on pushes to the main branch. It provisions an EC2 instance, installs Docker, deploys the web application, and configures services.



