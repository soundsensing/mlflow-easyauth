
# mlflow with basic auth

Standard [mlflow](https://mlflow.org/) does not have any authentication for the web-interface.
This project adds basic HTTP authentication with a single username, password to the web interface and API.
And packages this up in a easy-to-install Docker image.

The simplest configuration uses just a Docker volume for persistence.
Alternatively one can configure Google Cloud Storage as the artifact store,
and Heroku Postgres as the tracking store.

It should be easy to deploy to most Docker providers,
such as Dokku, Fly.io, Heroku, Amazon ECS, Docker Cloud Run, DigitalOcean App Platform, et.c.

with other supported mlflow backends for artifacts and database.
Pull requests are welcome to fix any compatibility issues.

## License
[Licensed](./LICENSE.txt) under Apache 2.0, as mlflow itself.

## Status

**In Use**

# Quickstart

## Run with Docker

Clone this git repo

```
git clone https://github.com/soundsensing/mlflow-easyauth.git
cd mlflow-easyauth
```

Build the image

```
docker build -t mlflow-easyauth:latest .

```

Create a .env file with settings

```bash
cat <<EOT >> settings.env
MLFLOW_TRACKING_USERNAME=user
MLFLOW_TRACKING_PASSWORD=pass
#GOOGLE_APPLICATION_CREDENTIALS_JSON=None
#ARTIFACT_URL=mlruns
#DATABASE_URL=mlruns
EOT
"
```

Create a Docker volume for persistence

```
docker volume create my-mlflow-server-volume
```

Run it

```
docker run -it -p 8001:6000 --mount source=my-mlflow-server-volume,target=/mlruns --env-file=settings.env mlflow-easyauth:latest
```

## Use in mlflow client

Configure the client

    export MLFLOW_TRACKING_URI=http://localhost:8001
    export MLFLOW_TRACKING_USERNAME=user
    export MLFLOW_TRACKING_PASSWORD=pass

Run some code using the mlflow tracking API. There is an example included in this repo

    export MLFLOW_EXPERIMENT_NAME=test6
    python3 example.py

Open the web browser and go to your deployed .
You should now have runs tracked with metrics being logged.

For more details see official documentation on
[mlflow tracking integration](https://www.mlflow.org/docs/latest/quickstart.html#using-the-tracking-api).

# Configuration options

All configuration is done as environment variables.
Set them using the preferred method for your Docker host.

## Using PostgreSQL for metrics persistence

Setup PostgeSQL in your preferred way.

Configure the host and credentials using `DATABASE_URL`
```
DATABASE_URL=postgres://user:pass@host:port/path
```

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

```
ARTIFACT_URL=gs://MY-BUCKET/SOME/FOLDER
GOOGLE_APPLICATION_CREDENTIALS_JSON="`cat serviceaccount-fa31bc1bbb1d.json`"
```

# Developing

This command re-runs all the steps needed to build and run a new version.
It is useful when iterating on the Docker files.

```
docker build -t mlflow-easytracking:latest . && docker run -it -p 8001:6000  --env-file=`pwd`/dev.env    mlflow-easytracking:latest bash /app/entry-point.sh
```

# Tips & Tricks

## Deploying to Heroku

See [jordandelbar/mlflow-heroku/](https://github.com/jordandelbar/mlflow-heroku/) for a fork that focuses on this.

