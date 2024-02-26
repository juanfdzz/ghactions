#!/bin/bash

# Obtén los nombres de los archivos y los secretos desde las variables de entorno
files="${filenames}"
secrets="${secrets}"

# Convierte el JSON de los secretos en un array asociativo en Bash
declare -A secret_array
eval "declare -A secret_array=$(echo "$secrets" | jq -r 'to_entries | .[] | .key + "=" + (.value|tostring)' | sed 's/\"//g')"

# Itera sobre cada archivo especificado
for file in $files; do
    # Itera sobre cada secreto
    for secret_key in "${!secret_array[@]}"; do
        # Reemplaza la clave del secreto con su valor en el archivo
        sed -i "s/__${secret_key}__/${secret_array[$secret_key]}/g" "$file"
    done
done
cat /apps/pro/k8s/asd.yaml
cat /apps/pro/k8s/asding.yaml