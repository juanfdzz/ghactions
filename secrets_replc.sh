#!/bin/bash
set -x
file="${filenames}"
echo "${secrets}" | jq -r 'to_entries | .[] | .key + "=" + .value' > secrets.txt
cat secrets.txt

Reemplaza los valores en cada archivo
while IFS= read -r line; do
    key=$(echo "$line" | cut -d'=' -f1)
    value=$(echo "$line" | cut -d'=' -f2)
    echo $key
    echo $value
    if [[ ! "$key" == *"PRIVATE_KEY"* ]]; then
        sed -i "s/__${key}__/${value}/g" "$file"
    else
        echo "$value" | awk '{print "                          " $0}' > key.pem
        sed -i "/__${key}__/r key.pem" $file
        sed -i "/__${key}__/d" $file
    fi
done < "secrets.txt"


