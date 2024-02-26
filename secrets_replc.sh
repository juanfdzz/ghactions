#!/bin/bash

# Obtén los nombres de los archivos y los secretos desde las variables de entorno
files="${filenames}"
secrets_json="${secrets}"

# Decodifica los secretos desde el formato JSON
secrets=$(echo "$secrets_json" | jq -r 'to_entries | .[] | "--" + .key + "=" + .value')

# Reemplaza los valores en cada archivo
for file in $files; do
    while IFS= read -r line; do
        for secret in $secrets; do
            name="${secret%%=*}"
            value="${secret#*=}"
            line="${line//__$name__/$value}"
        done
        echo "$line"
        echo $name
        echo $value
    done < "$file" > "$file.tmp" && mv "$file.tmp" "$file"
    echo "Secretos reemplazados en $file"
done


cat apps/pro/k8s/asd.yaml
cat apps/pro/k8s/asding.yaml