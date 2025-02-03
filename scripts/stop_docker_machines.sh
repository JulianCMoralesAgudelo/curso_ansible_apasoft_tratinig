#!/bin/bash

# Lista de nombres de contenedores a gestionar
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

# Validar argumento (start o stop)
case "$1" in
  start|stop) action="$1" ;;
  *) 
    echo "Uso: $0 {start|stop}"
    exit 1
    ;;
esac

# Ejecutar la acción solo en contenedores en ejecución
for container in "${containers[@]}"; do
  running=$(docker ps --format '{{.Names}}' | grep -w "$container")

  if [[ -n "$running" ]]; then
    echo "${action^}ing contenedor: $container"
    docker "$action" "$container"
    
    if [ $? -eq 0 ]; then
      echo "✅ Contenedor $container ${action^} con éxito."
    else
      echo "❌ Error al ${action} el contenedor $container."
    fi
  else
    echo "⚠️ Contenedor $container no está en ejecución o no existe."
  fi
  
  echo "--------------------------------"
done

echo "🎯 Todos los contenedores han sido procesados."
