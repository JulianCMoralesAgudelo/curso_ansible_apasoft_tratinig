#!/bin/bash



# Crea un archivo seguro con la contraseña:
ansible-vault create secret.yml

# Dentro, escribe:
ansible_become_password: "tu_password"

# Carga el vault en Ansible
ansible-playbook playbook.yml --ask-vault-pass

# Acción	Comando
# Eliminar el archivo rm -f secret.yml
# Editar el archivo cifrado	ansible-vault edit secret.yml
# Ver contenido sin editar	ansible-vault view secret.yml
# Cambiar la contraseña del vault	ansible-vault rekey secret.yml
# Desencriptar y guardar en texto plano	ansible-vault decrypt secret.yml

# Si quieres que te pida la contraseña interactivamente
ansible rocky -i inventory.ini -m lineinfile -a "path=/etc/sudoers line='ansible ALL=(ALL) NOPASSWD: ALL' validate='/usr/sbin/visudo -cf %s'" --become --ask-vault-pass

# comando con el archivo secreto
ansible rocky -i inventory.ini -m dnf -a "name=mysql-server state=present" --become --vault-password-file=secret.yml

# comando alternativa para que Ansible te pida la contraseña de Vault cuando ejecutes el comando
ansible rocky -i inventory.ini -m dnf -a "name=mysql-server state=present" --become --ask-vault-pass

# Comando ad_hoc ansible rocky → Aplica la acción a todos los hosts del grupo rocky definido en el invetario y pide la contraseña del secreto
ansible rocky -i inventory.ini -m dnf -a "name=mysql-server state=present" --become --ask-vault-pass
echo
# Comando ad_hoc Si en lugar de dnf usas yum, el comando sería:
ansible rocky -i inventory.ini -m yum -a "name=mysql-server state=present" --become --ask-vault-pass
echo
# Puedes verificar si MySQL está instalado con:
ansible rocky -i inventory.ini -m shell -a "mysql --version"
echo
# Comando playbook
ansible-playbook pract_7.yaml -i inventory.ini

# Reinstalar el servicio ssh dentro del contenedor
dnf remove -y openssh-server && dnf install -y openssh-server && systemctl restart sshd

# Iniciar y validar el servicio mysql dentro del contenedor
sudo systemctl start mysqld.service && systemctl status mysqld
