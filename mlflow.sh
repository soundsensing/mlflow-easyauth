#!/bin/bash -x


# FIXME: write google credentials to disk from envvar

exec mlflow server --backend-store-uri $DATABASE_URL --default-artifact-root $ARTIFACT_URL
