#!/bin/bash
# Comando ad_hoc
ansible servidores_de_aplicaciones -m setup -a "filter=ansible_memfree_mb" -i inventory.ini

# Comando playbook
ansible-playbook pract_3.yaml -i inventory.ini