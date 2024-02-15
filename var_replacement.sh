#!/bin/bash

set -x

# El nombre del archivo con la lista de nombres de secretos separados por espacios
SECRETS_NAMES=$1

# Los nombres de los archivos donde se realizará la sustitución
FILES_TO_UPDATE=$2

# Recuperamos los nombres de los secretos y los almacenamos en un array
IFS=' ' read -ra SECRET_NAMES <<< "$SECRETS_NAMES"

# Función para reemplazar las variables de entorno en un archivo
replace_secrets() {
  local file="$1"
  for i in "${!SECRET_NAMES[@]}"; do
    # Obtenemos el valor del secreto desde las variables de entorno
    secret_value="${!SECRET_NAMES[$i]}"

    # Preparamos la expresión regular para buscar la variable de entorno en el formato ${{ variable }}
    regex="\${{ ${SECRET_NAMES[$i]} }}}"

    # Usamos sed para reemplazar las variables en el archivo
    sed -i "s|$regex|$secret_value|g" "$file"
  done
}

# Dividimos los nombres de los archivos en un array
IFS=' ' read -ra FILES_ARRAY <<< "$FILES_TO_UPDATE"

# Buscamos los archivos por nombre y aplicamos la función de reemplazo
for file_pattern in "${FILES_ARRAY[@]}"; do
  find . -type f -name "$file_pattern" -exec bash -c 'replace_secrets "{}"' \;
done

cat apps/pro/k8s/configmap.yaml