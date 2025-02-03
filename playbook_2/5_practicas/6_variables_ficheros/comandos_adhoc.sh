#!/bin/bash

# Ejecutar un comando en los hosts del grupo rocky1_group y rocky2_group
ansible-playbook -i inventory.ini variables_de_fichero.yaml

