#!/bin/bash
exit_code=0

if [[ -z ${GITHUB_REF} ]]; then
    echo "Missing GITHUB_REF variable"
    exit 1
fi

echo "Current branch: $GITHUB_REF"
IFS='/' read -ra REF_ARRAY <<< "$GITHUB_REF"
LAST_PART_OF_BRANCH=${REF_ARRAY[-1]}
echo "REPORT_NAME=Health check report - $LAST_PART_OF_BRANCH.md" >> $GITHUB_OUTPUT

export REPORT_NAME

echo -e "\nDone."
exit $exit_code
