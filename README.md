# Avidity DevOps Engineer Test

1. Clone this repository
2. Make the necessary changes / deliverables
3. Create a Pull Request to deliver it

## Description

This test objective is to serve as a base for discussion where we can assess your expertise about Ansible and the automation of Containerized Applications. The submitted code does not have to be syntactically correct or executable. We are looking at the overall picture of code organization and the ability to create code that could potentially be integrated into production grade environments. Pseudo results and/or outputs for tasks are okay to be expected in certain requirements. You are not expected to deliver a single file, but multiple files that deliver the overall objective. 

* Assume that the playbooks will be run on Debian-derived hosts.
* Assume the web application runs with **TLS/HTTPS only**.
* Assume the host has **secure private access**, allowing only access with ssh-keys pulled from a specific directory.
* Assume that software configuration can be changed using ansible variables per host and group.

Clone the repository https://github.com/avidity/cloudops-test

Create an ansible-playbook to provision a host to serve web application requests. 
This application requires:
* PostgreSQL +13 with the custom configuration.
* Redis +6 with the custom configuration settings.
* Nginx +1.10 with the custom configuration settings.

The application runs on Docker `+18.09`. 
Application binds on localhost port only at `127.0.0.1:8000`. 
The application runs on an image **based on the code from a git repository**, in case no tag is provided, use `app:latest`.

1. Create an ansible-playbook to deploy new application updates.
2. Use Github Actions to make automatic deployment on code changes.
3. The deployment process should be able to handle database migration from frameworks that support ORMs like Rails or Django.

**The delivery should be via a Pull Request on the cloned repository.**

