provision:
	ansible-playbook -i ansible/inventories/production/hosts ansible/playbooks/provision_host.yml

deploy:
	ansible-playbook -i ansible/inventories/production/hosts ansible/playbooks/deploy_app.yml

.PHONY: provision deploy
