#!/bin/bash

# Ejemplo con JSON como Extra Vars
ansible-playbook -i inventory.ini variables_de_terminal.yaml --extra-vars '{"var1": "valor1", "var2": "valor2"}'

# Ejemplo con YAML como Extra Vars
ansible-playbook -i inventory.ini variables_de_terminal.yaml --extra-vars @archivo_variables.yaml


