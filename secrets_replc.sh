#!/bin/bash

# Extraer las claves y valores de la cadena JSON
# keys=$(echo "${secrets}" | jq -r 'keys[]')
# values=$(echo "${secrets}" | jq -r '.[]')

file="${filenames}"

secretos="${secrets}"

# Extraer las claves y valores de la cadena JSON
keys=$(echo "$secretos" | jq -r 'keys[]')
values=$(echo "$secretos" | jq -r '.[]')

# Iterar sobre las claves y valores
for key in $keys; do
    value=$(echo "$secretos" | jq -r ".$key")
    # Sustituir el valor en el archivo
    sed -i "s/__${key}__/${value}/g" "$file"
done




cat $file




# abajo justo funciona
# for key in $keys; do
#     value=$(echo "${secrets}" | jq -r ".$key")
#     echo "Clave: $key"
#     echo "Valor: $value"
# done


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


