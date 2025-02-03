#!/bin/bash

# Clave SSH para la autenticación
SSH_PASSWORD="lepanto"

# Lista de hosts
hosts=(
  "debian2"
  "debian1"
  "rocky1"
  "rocky2"
  "ubuntu1"
  "mysql1"
  "mysql2"
  "tomcat1"
  "tomcat2"
)

echo "Verificando conexión con los hosts..."

# Agregar llaves SSH y configurar el idioma
for host in "${hosts[@]}"; do
  if ping -c 1 -W 1 "$host" &>/dev/null; then
    echo "Conectando a $host..."
    # Agregar clave SSH
    sshpass -p "$SSH_PASSWORD" ssh-copy-id -o ConnectTimeout=5 "ansible@$host" &>/dev/null
    if [ $? -eq 0 ]; then
      echo "Clave SSH agregada correctamente a $host"
      
      # Configurar el idioma sin requerir contraseña en sudo
      sshpass -p "$SSH_PASSWORD" ssh -o ConnectTimeout=5 "ansible@$host" "echo 'lepanto' | sudo -S tee /etc/default/locale <<< 'LANG=\"en_US.UTF-8\"' &>/dev/null"
      
      echo "Idioma configurado en $host"
    else
      echo "⚠️ No se pudo agregar la clave SSH a $host"
    fi
  else
    echo "⚠️ Host $host apagado o inaccesible"
  fi
done

# Retirar permisos de sudo en los contenedores si están activos
if [[ -f maquinas.txt ]]; then
  echo "Procesando contenedores desde maquinas.txt..."
  while IFS= read -r container; do
    if docker ps --format '{{.Names}}' | grep -q "^$container$"; then
      docker exec "$container" bash -c 'echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'
      echo "Permiso sudo ajustado en $container"
    else
      echo "⚠️ Contenedor $container no está en ejecución"
    fi
  done < maquinas.txt
else
  echo "⚠️ Archivo maquinas.txt no encontrado"
fi

echo "Proceso finalizado."
