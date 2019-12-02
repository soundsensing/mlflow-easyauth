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

exec mlflow server --backend-store-uri=$DATABASE_URL --default-artifact-root=$ARTIFACT_URL
