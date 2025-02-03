#!/bin/bash

# Exportar JSON del host rocky1
ansible rocky1 -m setup -i inventory.ini > rocky1_fact.json

# Ejemplo con YAML como Extra Vars



