#!/bin/bash
exit_code=0

if [[ -z ${FILENAME} ]]; then
    echo "Missing FILENAME variable"
    exit 1
fi

INDEX_FILENAME="Health Checks Reports.md"
FILENAME_WITHOUT_EXTENSION="${FILENAME//\.md/}"

echo "Filename without extension: $FILENAME_WITHOUT_EXTENSION"

if [ ! -f "$INDEX_FILENAME" ]; then
  echo "Index file not found. Creating."
  echo "" >> "$INDEX_FILENAME"
else
  echo "Index file is available. Removing previous checks for this branch."
  sed -i '/$FILENAME_WITHOUT_EXTENSION/d' "$INDEX_FILENAME"
fi

#Append new file link to top of file
echo -e "- [[$FILENAME_WITHOUT_EXTENSION]] - Updated: $(date +'%Y-%m-%d %H:%M:%S')\n" | cat - "$INDEX_FILENAME"> temp && mv temp "$INDEX_FILENAME"

echo -e "\nDone."
exit $exit_code
