#!/bin/bash

# Ejecutar un comando en los hosts del grupo rocky1_group y rocky2_group
ansible rocky1_group,rocky2_group -i inventory.ini -m debug -a "msg='Este es un mensaje desde el comando ad-hoc'"

# Si quieres ejecutar un comando ad-hoc y acceder a las variables definidas en el archivo
ansible rocky1_group -i inventory.ini -m debug -a "msg='{{ v1 }}'"

# Ejecutar el comando ad-hoc en un host específico usando una variable del host_vars:
ansible rocky1 -i inventory.ini -m debug -a "msg='{{ v1 }}'"