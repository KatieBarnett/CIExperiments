#!/bin/bash
exit_code=0

if [[ -z ${GITHUB_REF} ]]; then
    echo "Missing GITHUB_REF variable"
    exit 1
fi

echo "Current branch: $GITHUB_REF"
if [[ $GITHUB_REF = *"android/release/"* ]]; then
  echo "In a release branch"
  IFS='/' read -ra REF_ARRAY <<< "$GITHUB_REF"
  RELEASE_NUMBER=${REF_ARRAY[-1]}
  echo "Release number: $RELEASE_NUMBER"
  echo "REPORT_NAME=Health check report - $RELEASE_NUMBER.md" >> $GITHUB_ENV
else
  echo "REPORT_NAME=Health check report - $branch_name.md" >> $GITHUB_OUTPUT
fi
echo "Report name is: $REPORT_NAME"

export REPORT_NAME

echo -e "\nDone."
exit $exit_code
