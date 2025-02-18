#!/bin/bash

# 🛑 Detener el script si hay un error
set -e

# ✅ Actualizar Fedora
echo "🔄 Actualizando Fedora..."
sudo dnf update -y

# ✅ Instalar dependencias necesarias para Ansible
echo "📦 Instalando dependencias..."
sudo dnf install -y python3 python3-setuptools python3-pip python3-virtualenv \
                    sshpass git curl

# ✅ Instalar Ansible desde los repositorios de Fedora
echo "📦 Instalando Ansible..."
sudo dnf install -y ansible

# ✅ Verificar la instalación de Ansible
echo "🔍 Verificando la versión de Ansible..."
ansible --version

# ✅ Mensaje de éxito
echo "✅ Ansible y sus requisitos esenciales se han instalado correctamente en Fedora. 🚀"
