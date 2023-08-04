Here you place ansible files, playbooks, roles, everything needed for it to work

Step 1: Inventory
Created an Ansible inventory file (hosts) with the details of the target hosts. 
For this scenario, let's assume the host is named "webserver" and has the necessary SSH access set up

Step 2: Provisioning playbook 
Created an Ansible playbook (provision.yml) to provision the host with the required software and custom configurations. 

Step 3: In this playbook, we install the required packages, copy custom configuration files for PostgreSQL, Redis, and Nginx, and then enable and restart the services.

Step 4: Application Deployment playbook 
Created an Ansible playbook (deploy-app.yml) to deploy the application updates using GitHub Actions.


Step 5: 
Github Actions:
created a .github/workflows/deploy.yml file in your repository to trigger the deployment on code changes.

Note: With this configuration, every time you push changes to the master branch, the Github Actions workflow will trigger, and it will execute the Ansible playbook to deploy the application and perform database migrations if necessary. Make sure you have Ansible installed on the deployment runner machine to execute the playbook successfully.