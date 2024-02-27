#!/bin/bash

# Extraer las claves y valores de la cadena JSON
# keys=$(echo "${secrets}" | jq -r 'keys[]')
# values=$(echo "${secrets}" | jq -r '.[]')

file="${filenames}"
secrets="${secrets}"

echo $secrets > secretos.txt
cat secretos.txt

# Extraer las claves y valores de la cadena JSON
keys=$(echo "$secrets" | jq -r 'keys[]')
values=$(echo "$secrets" | jq -r '.[]')

# Iterar sobre las claves y valores
for key in $keys; do
    value=$(echo "$secrets" | jq -r ".$key")
    if [[ ! "$key" == *"PRIVATE_KEY"* ]]; then
        sed -i "s/__${key}__/${value}/g" "$file"
    else
        echo "$value" | awk '{print "                          " $0}' > key.pem
        sed -i "/__${key}__/r key.pem" $file
        sed -i "/__${key}__/d" $file
    fi
done



