#!/bin/bash


# IFS=' ' read -ra SECRET_NAMES_ARRAY <<< "${secrets_names}"
# IFS=' ' read -ra FILES_ARRAY <<< "${filenames}"
# IFS=' ' read -ra SECRETS_ARRAY <<< "${secrets_replacement}"

# length=${#SECRETS_ARRAY[@]}
# for ((i=0; i<$length; i++)); do

#   secret_value="${SECRETS_ARRAY[$i]}"
#   echo $secret_value

#   regex="\${{ ${SECRET_NAMES_ARRAY[$i]} }}"
#   echo $regex

#   for file in $filenames; do
#     find . -type f -name "$file" | while read -r filepath; do sed -i "s|$regex|$secret_value|Ig" "$filepath"; done
#   done
# done
echo ${secrets}