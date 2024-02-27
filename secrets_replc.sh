#!/bin/bash
file="${filenames}"
# keys=$(echo "${secrets}" | jq -r 'keys[]')
# values=$(echo "${secrets}" | jq -r '.[]')

# Extraer las claves y valores de la cadena JSON
keys=$(echo "${secrets}" | jq -r 'keys[]')
values=$(echo "${secrets}" | jq -r '.[]')

# Imprimir las claves y valores
for key in $keys; do
    value=$(echo "$json_string" | jq -r ".$key")
    echo "Clave: $key"
    echo "Valor: $value"
done
# while IFS= read -r line; do
#     key=$(echo "$line" | cut -d'=' -f1)
#     value=$(echo "$line" | cut -d'=' -f2)
#     echo $key
#     echo $value
#     if [[ ! "$key" == *"PRIVATE_KEY"* ]]; then
#         sed -i "s/__${key}__/${value}/g" "$file"
#     else
#         echo "$value" | awk '{print "                          " $0}' > key.pem
#         sed -i "/__${key}__/r key.pem" $file
#         sed -i "/__${key}__/d" $file
#     fi
# done < "secrets.txt"


