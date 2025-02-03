#!/bin/bash

# Ejecucion del playbook:
ansible-playbook -i inventory.ini pract_8.yaml

# Ejecucion adhoc variable local temporal
ansible all -i inventory.ini -m debug -a "msg={{ mensaje_local }}" -e "mensaje_local='Hola desde una variable extra'"