#!/bin/bash

# 🛑 Detener el script si hay un error
set -e

# ✅ Actualizar la lista de paquetes
echo "🔄 Actualizando Debian..."
sudo apt update -y && sudo apt upgrade -y

# ✅ Instalar dependencias necesarias para Ansible
echo "📦 Instalando dependencias..."
sudo apt install -y python3 python3-setuptools python3-pip python3-venv \
                    software-properties-common git curl

# ✅ Agregar el repositorio oficial de Ansible
echo "➕ Agregando el repositorio oficial de Ansible..."
sudo apt-add-repository --yes --update ppa:ansible/ansible

# ✅ Instalar Ansible desde los repositorios de Debian
echo "📦 Instalando Ansible..."
sudo apt install -y ansible

# ✅ Verificar la instalación de Ansible
echo "🔍 Verificando la versión de Ansible..."
ansible --version

# ✅ Mensaje de éxito
echo "✅ Ansible y sus requisitos esenciales se han instalado correctamente en Debian. 🚀"