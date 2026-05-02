# CloudOps Test Project

## Requirements
- Ansible >= 2.15
- SSH access to VM
- Python 3.10+
- Docker installed on VM

## VM Inventory
Edit:
inventories/production/hosts.yml

Example:
vm1 ansible_host=192.168.56.3 ansible_user=user (change to your)

## Run Deployment
ansible-playbook -i inventories/production/hosts.yml playbooks/provision.yml

## Test Deployment

App health:
curl http://192.168.56.3:8000/health

Nginx:
curl http://192.168.56.3/

Containers:
docker ps

## What is installed
- Docker app stack (app, postgres, redis)
- Nginx reverse proxy
- UFW firewall
- Journald config
- Backup cron job
- Systemd service

## Notes
- Safe to rerun playbook
- "already exists" messages are normal





# Avidity Cloud Infrastructure Engineer Test

1. Clone this repository
2. Make the necessary changes / deliverables
3. Create a Pull Request or e-mail us the link to your fork for evaluation

## Description

This test objective is to serve as a base for discussion where we can assess your expertise about Ansible and the automation of Containerized Applications. The submitted code does not have to be syntactically correct or executable. We are looking at the overall picture of code organization and the ability to create code that could potentially be integrated into production grade environments. Pseudo results and/or outputs for tasks are okay to be expected in certain requirements. You are not expected to deliver a single file, but multiple files that deliver the overall objective. 

* Assume that the playbooks will be run on Debian-derived hosts.
* Assume the web application is reachable with **TLS/HTTPS only**.
* Assume the host has **secure private access**, allowing only access with ssh-keys pulled from a specific directory.
* Assume that software configuration can be changed using ansible variables per host and group.

Clone the repository https://github.com/avidity/cloudops-test

Create an ansible-playbook to provision a host to serve web application requests. 
This application requires:
* `PostgreSQL +18` with the custom configuration and two unique users, one with all privileges in the database `app` and another with only `read-only`.
* `Redis +8` with the custom configuration settings and disk persistence.
* `Nginx +1.29` with the custom configuration settings to serve the application and proxy requests to it. Configure an Nginx status page (`stub_status`) restricted to local access for monitoring.
* Use **Ansible Vault** or a mock secret manager to handle sensitive data like database credentials and SSH private keys.

Create an user called `deploy` which will be used to access the server and release new application versions.
User `deploy` should be able to elevate privileges via `sudo` and only be accessible with ssh-key.
Application contents are stored in `/opt/app`.
The application runs on `Docker +29`. 
Use `docker-compose` to manage the application stack (app, postgres, redis) and implement **Docker healthchecks** for all services to ensure availability before Nginx starts proxying.
Application volumes are stored in `/opt/storage`.
Application binds on localhost port only at `127.0.0.1:8000`.
The application runs on an image **based on the code from a git repository**, in case no tag is provided, use `app:latest`.
Configure Journalctl to make daily log files and retention of 6 months.
Application logs should be in **JSON format** for structured logging.
Create a custom Systemd service to handle application reloads.
Create custom firewall rules to block any traffic that's not ssh/http/https
Configure sshd to not allow root login nor password logins.
Create a custom script that generates a compressed full database backup hourly and uploads it to an **S3-compatible storage bucket**.

1. Create an ansible-playbook to deploy new application updates.
2. Use Github Actions to make automatic deployment on code changes. The pipeline must include **linting steps** (`ansible-lint`, `shellcheck`) and handle **multiple environments** (e.g., staging vs production) using GitHub Environments and Secrets.
3. The deployment process should be able to handle database migration from frameworks that support ORMs like Rails or Django with a pseudo step.
