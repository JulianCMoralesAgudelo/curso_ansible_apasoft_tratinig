#!/bin/bash

# Lista de nombres de contenedores a iniciar
containers=(
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

# Iniciar cada contenedor
for container in "${containers[@]}"
do
  echo "Iniciando contenedor: $container"
  docker start "$container"
  if [ $? -eq 0 ]; then
    echo "Contenedor $container iniciado con éxito."
  else
    echo "Error al iniciar el contenedor $container."
  fi
  echo "--------------------------------"
done

echo "Todos los contenedores han sido procesados."

