#!/bin/bash -x

# FIXME: write google credentials to disk from envvar


if [[ -z "${ARTIFACT_URL}" ]]; then
    export ARTIFACT_URL="mlruns"
fi

if [[ -z "${DATABASE_URL}" ]]; then
    export DATABASE_URL="./mlruns"
fi

# Fix naming convention mismatch between Heroku and mlflow
DATABASE_URL=${DATABASE_URL//postgres:/postgresql:} 

# Credentials for Google Cloud Storage
if [[ -z "${GOOGLE_APPLICATION_CREDENTIALS}" ]]; then
    export GOOGLE_APPLICATION_CREDENTIALS=/app/credentials.json
fi

if [[ -z "${GOOGLE_APPLICATION_CREDENTIALS_JSON}" ]]; then
    echo ""
else
    echo ${GOOGLE_APPLICATION_CREDENTIALS_JSON} > ${GOOGLE_APPLICATION_CREDENTIALS}
    echo "Wrote to ${GOOGLE_APPLICATION_CREDENTIALS}"
fi


exec mlflow server --backend-store-uri=$DATABASE_URL --default-artifact-root=$ARTIFACT_URL
