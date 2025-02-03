#!/bin/bash
# Comando ad_hoc
ansible servidores_de_aplicaciones -m setup -a "filter=processor" -i inventory.ini
echo
# Comando ad_hoc
ansible servidores_de_aplicaciones -m setup -a "filter=processor" -i inventory.ini | grep -A 2 "processor"
echo
echo
# Comando ad_hoc
ansible servidores_de_aplicaciones -m setup -a "filter=processor" -i inventory.ini | grep -A 3 "processor"
echo
# Comando playbook
ansible-playbook pract_5.yaml -i inventory.ini