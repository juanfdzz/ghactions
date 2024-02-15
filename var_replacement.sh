#!/bin/bash
set -x
# Obtén los nombres de los archivos y los secretos de las variables de entorno
filenames=("${filename}")
secrets=("${secrets}")
secrets_name=("${secrets_names}")
echo $secrets_name
echo $secrets
echo $filenames
# Recorre cada archivo
for file in "${filenames[@]}"; do
  # Busca el archivo en todos los directorios
  find / -type f -name $file 2>/dev/null | while read -r filepath; do
    echo "Procesando el archivo $filepath"
    # Recorre cada nombre de secreto
    for index in "${!secret_names[@]}"; do
      # Obtiene el nombre y el valor del secreto
      secret_name=${secret_names[index]}
      secret_value=${secrets[index]}
      # Reemplaza todas las ocurrencias del nombre del secreto en el archivo, sin tener en cuenta mayúsculas o minúsculas
      sed -i "s/\$\{\{ $secret_name \}\}/$secret_value/Ig" $filepath
    done
    # Muestra el contenido del archivo
    cat "$filepath"
  done
done

cat apps/pro/k8s/configmap.yaml
