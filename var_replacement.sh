#!/bin/bash

# Obtén los nombres de los archivos y los secretos de las variables de entorno
filenames=("${filename}")
secrets=("${secrets}")

# Recorre cada archivo
for file in "${filenames[@]}"; do
  # Busca el archivo en todos los directorios
  find / -type f -name $file 2>/dev/null | while read -r filepath; do
    echo "Procesando el archivo $filepath"
    # Recorre cada secreto
    for secret in "${secrets[@]}"; do
      # Reemplaza todas las ocurrencias del nombre del secreto en el archivo
      sed -i "s/$secret/$(eval echo \$$secret)/g" $filepath
    done
  done
  cat "$filepath"
done

