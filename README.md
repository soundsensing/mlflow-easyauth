
# mlflow with basic auth

Standard [mlflow](https://mlflow.org/) does not have any authentication
for the web-interface.
This project adds basic HTTP authentication with a single username, password to the web interface.
And packages this up in a easy-to-install Docker image.

Primarily for use on Heroku with using Google Cloud Storage as the artifact store,
and Heroku Postgres as the tracking store.
It should be easy to make work on other Docker providers,
with other supported mlflow backends for artifacts and database.
Pull requests are welcome to fix any compatibility issues.

## Status

**Prototype**

# Quickstart

## Deploying to Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

This will provision an Heroku app, and

## Use as

    export MLFLOW_TRACKING_URI=http://176.58.97.239:5000
    export MLFLOW_TRACKING_USERNAME=user
    export MLFLOW_TRACKING_PASSWORD=user

    mlflow experiments create -n test6

    export MLFLOW_EXPERIMENT_NAME=test5

## Enable artifact persistence

Using Google Cloud Storage.

Configure Heroku server

    heroku config:set ARTIFACT_URL=gs://MY-BUCKET/SOME/FOLDER
    heroku config:set GOOGLE_APPLICATION_CREDENTIALS_JSON=`cat foo-fa31bc1bbb1d.json`

Configure the mlflow client

    export GOOGLE_APPLICATION_CREDENTIALS=credentials.json


# Reference


## Deploying with Docker

Clone this git repo

```

```

Build the image

```
docker build -t my-mlflow-easyauth:latest .

```

Create a .env file with settings


Run it

```
docker run -it -p 8001:6000  --env-file=settings.env my-mlflow-easyauth:latest
```

## Settings


```
MLFLOW_TRACKING_USERNAME=
MLFLOW_TRACKING_PASSWORD=
GOOGLE_APPLICATION_CREDENTIALS=
ARTIFACT_URL=
DATABASE_URL=
```

# Developing
```

docker build -t mlflow-easytracking:latest . && docker run -it -p 8001:80  --env-file=`pwd`/dev.env    mlflow-easytracking:latest bash /app/entry-point.sh

```
