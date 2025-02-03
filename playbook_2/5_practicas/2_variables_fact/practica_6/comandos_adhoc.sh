#!/bin/bash
# Comando ad_hoc
ansible servidores_de_aplicaciones -m setup -a "filter=ansible_memory_mb" -i inventory.ini
echo
# Comando ad_hoc Si solo quieres ver la memoria total, usa
ansible servidores_de_aplicaciones -m setup -a "filter=ansible_memory_mb" -i inventory.ini | grep -A 2 '"real"'
echo
# Comando playbook
ansible-playbook pract_6.yaml -i inventory.ini

# En Ansible, cuando usas ansible_memory_mb, obtienes un diccionario con tres categorías principales de memoria:
# 
# 🔹 1. Memoria "real" (real)
# Se refiere a la memoria física (RAM) instalada en el sistema.
# Tiene tres valores clave:
# total → Cantidad total de RAM en MB.
# used → Cantidad de RAM utilizada.
# free → Cantidad de RAM disponible.
# 🔹 2. Memoria "swap" (swap)
# Es la memoria virtual que el sistema usa cuando la RAM se llena.
# También tiene tres valores clave:
# total → Tamaño total del área de intercambio.
# used → Cantidad de swap en uso.
# free → Swap disponible.
# 🔹 3. Memoria "nocache" (nocache)
# Representa la memoria utilizada sin contar el uso de caché y buffers.
# Tiene dos valores clave:
# used → RAM en uso sin incluir caché/buffers.
# free → RAM realmente disponible para procesos nuevos.