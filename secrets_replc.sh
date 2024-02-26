#!/bin/bash
set -x

# Obtén los nombres de los archivos y los secretos desde las variables de entorno
files="${filenames}"
echo "${secrets}" | jq -r 'to_entries | .[] | .key + "=" + .value' > secrets.txt


# Reemplaza los valores en cada archivo
while IFS= read -r line; do
    key=$(echo "$line" | cut -d'=' -f1)
    value=$(echo "$line" | cut -d'=' -f2)
    echo $key
    echo $value
    # Itera sobre cada archivo
    for file in $files; do
        # Reemplaza la clave del secreto con su valor en el archivo
        sed -i "s/__${key}__/${value}/g" "$file"
    done
done < "secrets.txt"


cat apps/pro/k8s/asd.yaml

cat apps/pro/k8s/asding.yaml