#!/bin/bash


IFS=' ' read -ra SECRET_NAMES_ARRAY <<< "${secrets_names}"
IFS=' ' read -ra FILES_ARRAY <<< "${filenames}"
IFS=' ' read -ra SECRETS_ARRAY <<< "${secrets_replacement}"

length=${#SECRETS_ARRAY[@]}
for ((i=0; i<$length; i++)); do
  # Obtenemos el valor del secreto desde las variables de entorno
  secret_value="${SECRETS_ARRAY[$i]}"
  echo $secret_value

  # Preparamos la expresión regular para buscar la variable de entorno en el formato ${{ variable }}
  regex="\${{ ${SECRET_NAMES_ARRAY[$i]} }}"
  echo $regex

  # Usamos sed para reemplazar las variables en los archivos
  for file in $filenames; do
    find . -type f -name "$file" | while read -r filepath; do sed -i "s|$regex|$secret_value|Ig" "$filepath"; done
  done
done

cat apps/pro/k8s/configmap.yaml
cat apps/pro/k8s/asd.yaml
cat apps/pro/k8s/asding.yaml