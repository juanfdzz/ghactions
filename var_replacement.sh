#!/bin/bash

# Obtén los nombres de los archivos y los secretos de las variables de entorno
filenames=("${filename}")
secrets=("${secrets}")

# Recorre cada archivo
for file in "${filenames[@]}"; do
  # Asegúrate de que el archivo existe antes de intentar modificarlo
  if [[ -f $file ]]; then
    echo "Procesando el archivo $file"
    # Recorre cada secreto
    for secret in "${secrets[@]}"; do
      # Reemplaza todas las ocurrencias del nombre del secreto en el archivo
      sed -i "s/$secret/$(eval echo \$$secret)/g" $file
    done
  else
    echo "El archivo $file no existe"
  fi
done
