#!/bin/bash

# Extraer las claves y valores de la cadena JSON
# keys=$(echo "${secrets}" | jq -r 'keys[]')
# values=$(echo "${secrets}" | jq -r '.[]')

file="${filenames}"
secrets="${secrets}"
excluded_keys=(${excluded_keys})
echo $secrets > secretos.json
cat secretos.json

# Extraer las claves y valores de la cadena JSON
keys=$(echo "$secrets" | jq -r 'keys[]')
values=$(echo "$secrets" | jq -r '.[]')

# Iterar sobre las claves y valores
for key in $keys; do

    if [[ " ${excluded_keys[@]} " =~ " ${key} " ]]; then
        continue # Si la key está en la lista, salta a la siguiente iteración del bucle
    fi

    value=$(echo "$secrets" | jq -r ".$key")
    if [[ ! "$key" == *"PRIVATE_KEY"* ]]; then
        sed -i "s/__${key}__/${value}/g" "$file"
    else
        echo "$value" | awk '{print "                          " $0}' > key.pem
        sed -i "/__${key}__/r key.pem" $file
        sed -i "/__${key}__/d" $file
    fi
done


cat $file
