#!/bin/bash
# Comando ad_hoc
ansible debian1 -m debug -a "var=software" -i inventory.ini

# Comando playbook
ansible-playbook pract_2.yaml -i inventory.ini