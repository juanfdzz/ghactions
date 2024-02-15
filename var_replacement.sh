#!/bin/bash

# Define the function before calling it
replace_secrets() {
  local file="$1"
  for i in "${!SECRET_NAMES[@]}"; do
    # Obtain the secret value from environment variables
    secret_value="${!SECRET_NAMES[$i]}"

    # Prepare the regular expression to search for the environment variable in the format ${{ variable }}
    regex="\${{ ${SECRET_NAMES[$i]} }}}"

    # Use sed to replace the variables in the file
    sed -i "s|$regex|$secret_value|g" "$file"
  done
}

# The list of secret names separated by spaces
SECRETS_NAMES=$1

# Recover the secret names and store them in an array
IFS=' ' read -ra SECRET_NAMES <<< "$SECRETS_NAMES"

# Search for files by name and apply the replacement function
for file_pattern in "$@"; do
  find . -type f -name "$file_pattern" -exec bash -c 'replace_secrets "{}"' \;
done

# Dividimos los nombres de los archivos en un array
IFS=' ' read -ra FILES_ARRAY <<< "$FILES_TO_UPDATE"

# Buscamos los archivos por nombre y aplicamos la función de reemplazo
for file_pattern in "${FILES_ARRAY[@]}"; do
  find . -type f -name "$file_pattern" -exec bash -c 'replace_secrets "{}"' \;
done

cat apps/pro/k8s/configmap.yaml