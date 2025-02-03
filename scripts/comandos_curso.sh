#!/bin/bash

# Comando 1: Verifica la conectividad con todas las máquinas definidas en el inventario "maquinas.txt"
# utilizando el módulo "ping".
ansible -i maquinas.txt all -m ping

# Comando 2: Ejecuta el comando "date" en todas las máquinas definidas en el inventario "maquinas.txt".
# Esto devuelve la fecha y hora actuales de cada máquina.
ansible -i maquinas.txt all -a date

# Comando 3: Lista los archivos y directorios del directorio raíz ("/") con detalles (modo largo) en todas
# las máquinas definidas en el inventario "maquinas.txt".
ansible -i maquinas.txt all -a "ls -l /"

# Comando 4: Ejecuta el comando "ls -l / | grep p" en todas las máquinas definidas en el inventario "maquinas.txt".
# Esto lista los archivos y directorios del directorio raíz que contienen la letra "p" en su nombre.
ansible -i maquinas.txt all -m shell -a "ls -l / | grep p"

# Comando 5: Recupera información detallada de la máquina "tomcat1" definida en el inventario "maquinas.txt"
# utilizando el módulo "setup". Este módulo devuelve datos sobre hardware, software y configuraciones del sistema.
ansible -i maquinas.txt tomcat1 -m setup

# Comando 6: Copia el archivo "prueba.txt" desde el controlador hacia la máquina "debian1" definida en el inventario
# "maquinas.txt". El archivo se colocará en "/tmp/prueba.txt" en la máquina de destino.
ansible debian1 -i maquinas.txt -m copy -a "src=prueba.txt dest=/tmp/prueba.txt"

# Comando 7: Copia el archivo "prueba.txt" desde el controlador hacia la máquina "debian1" definida en el inventario
# "maquinas.txt" con permisos "777". El archivo se colocará en "/tmp/prueba_1.txt" en la máquina de destino.
ansible debian1 -i maquinas.txt -m copy -a "src=prueba.txt dest=/tmp/prueba_1.txt mode=777"

# Retirar permisos de sudo en los contenedores
# Leer el archivo maquinas.txt línea por línea
while IFS= read -r container; do
  # Ejecutar el comando en cada contenedor sin -it
  docker exec "$container" bash -c 'echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'
done < maquinas.txt

# Si prefieres no agregar el --become manualmente cada vez, puedes configurar Ansible para que siempre use sudo (o become) por defecto. Para ello, agrega lo siguiente en tu archivo ansible.cfg
sudo vi /etc/ansible/ansible.cfg

# Agrega las siguientes líneas al final del archivo (o en la sección [defaults] si ya existe):
[defaults]
become = true
become_method = sudo
become_user = root

# Ejecutar comandos
# usar la opción become para ejecutar el comando como superusuario (root). Esto le indicará a Ansible que utilice sudo para ejecutar el comando con privilegios elevados.
ansible -i maquinas.txt rocky1 -m yum -a "name=httpd state=present" --become

# Si el contenedor tiene configurado un usuario con privilegios sudo (como parece ser tu caso, si agregaste ansible ALL=(ALL) NOPASSWD: ALL al archivo /etc/sudoers), 
# puedes especificar el usuario que debe usarse para ejecutar el comando:
ansible -i maquinas.txt rocky1 -m yum -a "name=httpd state=present" --become --become-user=ansible

# Iniciar servicio
ansible -i maquinas.txt rocky1 -m service -a "name=httpd state=started" --become

# Ejecutar comandos
# usar la opción become para ejecutar el comando como superusuario (root). Esto le indicará a Ansible que utilice sudo para ejecutar el comando con privilegios elevados.
ansible -i maquinas.txt debian1 -m apt -a "name=apache2 state=present" --become

# Ejecutar comandos
# usar la opción become para ejecutar el comando como superusuario (root). Esto le indicará a Ansible que utilice sudo para ejecutar el comando con privilegios elevados.
ansible -i maquinas.txt rocky1 -m dnf -a "name=httpd state=present" -b --ask-become-pass

# Explicación de los valores válidos para state en el módulo apt:
# present: Asegura que el paquete esté instalado.
# absent: Asegura que el paquete no esté instalado.
# latest: Asegura que el paquete esté instalado y actualizado a la última versión.
# build-dep: Instala las dependencias necesarias para la construcción de un paquete.
# fixed: Asegura que el paquete esté instalado con una versión fija.
# Al usar state=present, estás indicando que deseas instalar el paquete si no está ya instalado.

# Generar entorno y asociar las llaves ssh
. /home/ansible/curso_ansible_apasoft_tratinig/scripts/generar_entorno.sh && . /home/ansible/curso_ansible_apasoft_tratinig/scripts/hosts_ssh.sh