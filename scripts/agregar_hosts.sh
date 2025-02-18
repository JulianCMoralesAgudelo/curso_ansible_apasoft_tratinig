#!/bin/bash

# 🛑 Detener el script si hay un error
set -e

# ✅ Definir el archivo de hosts
HOSTS_FILE="/etc/hosts"

# ✅ Lista de máquinas con sus IPs y nombres
declare -A HOSTS=(
    ["172.18.0.2"]="debian1"
    ["172.18.0.3"]="debian2"
    ["172.18.0.5"]="rocky1"
    ["172.18.0.6"]="rocky2"
    ["172.18.0.8"]="ubuntu1"
    ["172.18.0.10"]="mysql1"
    ["172.18.0.11"]="mysql2"
    ["172.18.0.12"]="tomcat1"
    ["172.18.0.13"]="tomcat2"
)

# ✅ Agregar cada máquina al /etc/hosts si no está presente
echo "🔄 Agregando hosts a $HOSTS_FILE..."

for IP in "${!HOSTS[@]}"; do
    HOSTNAME="${HOSTS[$IP]}"
    
    # Verificar si la entrada ya existe en /etc/hosts
    if grep -q "$IP" "$HOSTS_FILE"; then
        echo "✔ $HOSTNAME ($IP) ya está en $HOSTS_FILE"
    else
        echo "$IP $HOSTNAME" | sudo tee -a "$HOSTS_FILE" > /dev/null
        echo "➕ Agregado: $IP $HOSTNAME"
    fi
done

echo "✅ Proceso completado. Verifica con: cat /etc/hosts"
