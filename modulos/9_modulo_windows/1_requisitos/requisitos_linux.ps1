# instalar winRM
sudo dnf install python3-pip
sudo yum install python3-pip

# Debian
sudo apt update
sudo apt install python3-pip
sudo apt install pipx
pipx install pywinrm

# Si no hay sudo por comando
su -c "dnf install python3-pip"

# Instalar pywinrm
pip3 install pywinrm

# Verificar versiones
pip3 --version
pip3 show pywinrm
