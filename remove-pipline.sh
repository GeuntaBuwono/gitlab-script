#!/bin/bash
set -e

TOKEN="" # Create access token on https://gitlab.com/profile/personal_access_tokens
PROJECT="" # Project ID
# How many to delete from the oldest.
PER_PAGE=4

for PIPELINE in $(curl --header "PRIVATE-TOKEN: $TOKEN" "https://gitlab.com/api/v4/projects/$PROJECT/pipelines?per_page=$PER_PAGE&sort=asc" | jq '.[].id') ; do
    echo "Deleting pipeline $PIPELINE"
    curl --header "PRIVATE-TOKEN: $TOKEN" --request "DELETE" "https://gitlab.com/api/v4/projects/$PROJECT/pipelines/$PIPELINE"
done
