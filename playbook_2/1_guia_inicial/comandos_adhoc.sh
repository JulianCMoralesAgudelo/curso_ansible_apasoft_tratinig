#!/bin/bash

# Listar inventario de maquinas del archivo de configuracion 
ansible all --list-hosts -i inventory.ini

# Exportar variables de configuracion filtradas
ansible debian1 -m setup -a "filter=ansible_system,ansible_os_family" -i inventory.ini


# Usa el módulo setup de Ansible, que recopila información del sistema remoto.
ansible debian1 -m setup -a "filter=ansible_proc_cmdline" -i inventory.ini