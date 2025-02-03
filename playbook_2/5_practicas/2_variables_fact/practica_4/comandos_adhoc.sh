#!/bin/bash
# Comando ad_hoc
ansible servidores_de_aplicaciones -m setup -a "filter=ansible_default_ipv4" -i inventory.ini

# Comando playbook
ansible-playbook pract_4.yaml -i inventory.ini