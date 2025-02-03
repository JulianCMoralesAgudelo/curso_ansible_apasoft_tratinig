#!/bin/bash

# Verifica si el script se está ejecutando como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script como root o con sudo."
  exit 1
fi

# Elimina cualquier instalación previa de Docker
echo "Eliminando versiones anteriores de Docker..."
sudo dnf remove -y \
  docker \
  docker-client \
  docker-client-latest \
  docker-common \
  docker-latest \
  docker-latest-logrotate \
  docker-logrotate \
  docker-selinux \
  docker-engine-selinux \
  docker-engine

# Instala paquetes necesarios para usar repositorios adicionales
echo "Instalando paquetes requeridos..."
sudo dnf -y install dnf-plugins-core

# Agrega el repositorio oficial de Docker
echo "Agregando repositorio de Docker..."
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

# Instala Docker Engine y sus dependencias
echo "Instalando Docker..."
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Inicia y habilita el servicio de Docker
echo "Iniciando y habilitando Docker..."
sudo systemctl enable --now docker

# Agrega el usuario actual al grupo docker (si no es root)
echo "Agregando al usuario actual al grupo docker..."
sudo usermod -aG docker $USER

echo "Por favor, cierra y vuelve a iniciar sesión para que los cambios surtan efecto."

echo "Verificando instalación de Docker..."
docker run hello-world

echo "Instalación completada. Docker está listo para usar."

