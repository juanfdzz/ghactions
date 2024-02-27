#!/bin/bash

# Extraer las claves y valores de la cadena JSON
# keys=$(echo "${secrets}" | jq -r 'keys[]')
# values=$(echo "${secrets}" | jq -r '.[]')

file="${filenames}"
secret_file="echo ${secrets}"
# Leer el archivo de secretos línea por línea
while IFS= read -r line; do
    # Extraer la clave y el valor de la línea
    key=$(echo "$line" | jq -r 'keys[]')
    value=$(echo "$line" | jq -r 'values[]')

    # Reemplazar cada ocurrencia de la clave en el archivo con su valor correspondiente
    if [[ ! "$key" == *"PRIVATE_KEY"* ]]; then
        sed -i "s/__${key}__/${value}/g" "$file"
    else
        # Guardar el valor en un archivo temporal respetando los saltos de línea
        echo "$value" > key_temp.pem
        # Insertar el contenido del archivo temporal en el lugar correspondiente en el archivo
        sed -i "/__${key}__/r key_temp.pem" "$file"
        # Eliminar la línea con la clave del archivo
        sed -i "/__${key}__/d" "$file"
        # Eliminar el archivo temporal
        rm key_temp.pem
    fi
done < "$secret_file"


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


