#!/bin/sh

mkdir ~/.ssh
echo "$APPSERVER_SSH_KEY" > ~/.ssh/aws.pem
chmod 0600 ~/.ssh/aws.pem

ansible-playbook -i ansible/inventories/production ansible/playbook.yml -vvvv