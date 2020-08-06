
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

**In Use**

# Quickstart

## Deploying to Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

This will provision an Heroku app, and a Postgres add-on for persisting metrics etc.
Artifact store needs to be configured separately, see below.


## Use in mflow client

Assuming that you have [mlflow tracking integration](https://www.mlflow.org/docs/latest/quickstart.html#using-the-tracking-api) set up already.

Configure the client

    export MLFLOW_TRACKING_URI=https://my-mlflow-instance.herokuapp.com
    export MLFLOW_TRACKING_USERNAME=user
    export MLFLOW_TRACKING_PASSWORD=user

Create a new experiment

    mlflow experiments create -n test6
    export MLFLOW_EXPERIMENT_NAME=test6

Run your

    python3 example.py

Open the web browser at your newly deployed Heroku app.
You should now have runs tracked with metrics being logged.

## Enable artifact persistence

Using [Google Cloud Storage](https://cloud.google.com/storage/).

Create a new or find an existing Google Cloud Storage bucket.

Create a Service Account for API credentials. Download the credentials JSON file.

Add the Service Account to Permissions on the bucket.
It needs to have the following roles:
```
Storage Legacy Bucket Writer
Legacy Bucket Reader
Legacy Object Reader
```

Add the config to the backend on Heroku

    heroku config:set ARTIFACT_URL=gs://MY-BUCKET/SOME/FOLDER
    heroku config:set GOOGLE_APPLICATION_CREDENTIALS_JSON="`cat serviceaccount-fa31bc1bbb1d.json`"

Configure the mlflow client

    export GOOGLE_APPLICATION_CREDENTIALS=credentials.json

Note that artifact URL is per experiment, so after this you'd need to create a new experiment
to have it go to your GCS bucket.


# Deploying with Docker


Clone this git repo

```
git clone https://github.com/soundsensing/mlflow-easyauth.git
cd mlflow-easyauth.git
```

Build the image

```
docker build -t my-mlflow-easyauth:latest .

```

Create a .env file with settings

```bash
cat <<EOT >> settings.env
MLFLOW_TRACKING_USERNAME=user
MLFLOW_TRACKING_PASSWORD=pass
GOOGLE_APPLICATION_CREDENTIALS_JSON=None
ARTIFACT_URL=mlruns
DATABASE_URL=mlruns
EOT
"
```


Run it

```
docker run -it -p 8001:6000  --env-file=settings.env my-mlflow-easyauth:latest
```


# Developing

This command re-runs all the steps needed to build and run a new version

```
docker build -t mlflow-easytracking:latest . && docker run -it -p 8001:80  --env-file=`pwd`/dev.env    mlflow-easytracking:latest bash /app/entry-point.sh
```

# Tips & Tricks

## Waking up free Heroku dynos

If you are using Heroku Free dynos, they will go to sleep after inactivity,
and then wake up again.
Thus when the mlflow client connects the app may be sleeping,
causing a the communication timeout and failing the ML pipeline.
If using this in automated workflows, it may be smart to wakeup the server
a bit in advance by making an HTTP request to it.
For example before installing dependencies of the project, etc.
