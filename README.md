
# mlflow with basic auth

Standard [mlflow](https://mlflow.org/) does not have any authentication for the web-interface.
This project adds basic HTTP authentication with a single username, password to the web interface and API.
And packages this up in a easy-to-install Docker image.

It can be used with just a Docker volume for persistence,
or using Google Cloud Storage as the artifact store,
and Heroku Postgres as the tracking store.
It should be easy to make work on other Docker providers,
with other supported mlflow backends for artifacts and database.
Pull requests are welcome to fix any compatibility issues.

## Status

**In Use**

# Quickstart

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
#GOOGLE_APPLICATION_CREDENTIALS_JSON=None
ARTIFACT_URL=mlruns
DATABASE_URL=mlruns
EOT
"
```


Run it

```
docker run -it -p 8001:6000  --env-file=settings.env my-mlflow-easyauth:latest
```

## Use in mflow client

Assuming that you have
[mlflow tracking integration](https://www.mlflow.org/docs/latest/quickstart.html#using-the-tracking-api)
set up already.

Configure the client

    export MLFLOW_TRACKING_URI=https://my-mlflow-instance.herokuapp.com
    export MLFLOW_TRACKING_USERNAME=user
    export MLFLOW_TRACKING_PASSWORD=pass

Run your code. There is an example included in this repo

    export MLFLOW_EXPERIMENT_NAME=test6
    python3 example.py

Open the web browser and go to your deployed .
You should now have runs tracked with metrics being logged.

## Using Google Cloud Storage for artifact persistence

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

Modify configuration to

    ARTIFACT_URL=gs://MY-BUCKET/SOME/FOLDER
    GOOGLE_APPLICATION_CREDENTIALS_JSON="`cat serviceaccount-fa31bc1bbb1d.json`"


# Developing

This command re-runs all the steps needed to build and run a new version

```
docker build -t mlflow-easytracking:latest . && docker run -it -p 8001:6000  --env-file=`pwd`/dev.env    mlflow-easytracking:latest bash /app/entry-point.sh
```

# Tips & Tricks

## Deploying to Heroku

See [jordandelbar/mlflow-heroku/](https://github.com/jordandelbar/mlflow-heroku/) for a fork that focuses on this.

