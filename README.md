
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

**Not working yet**

## TODO

- Test tracking locally
- Add basic auth in nginx
- Try deploy on Heroku
- Ensure HTTP web auth works
- Ensure HTTP API auth works

- Allow passing Google Cloud credentials as envvar (base64?)
- Test with Google Cloud bucket 

- Add Heroku button
- Finish README file
- Write blogpost announcement
- Advertise solution on relevant channels
https://github.com/mlflow/mlflow/issues/9 ?
https://stackoverflow.com/questions/58956459/how-to-run-authentication-on-a-mlflow-server


apache-tools
sudo htpasswd -c /etc/nginx/.htpasswd nginx

## Settings
MLFLOW_TRACKING_TOKEN=foo
MLFLOW_WEB_USERNAME=
MLFLOW_WEB_PASSWORD


export GOOGLE_APPLICATION_CREDENTIALS=soundquality-fa31bc1bbb1d.json
export ARTIFACT_URL=gs://soundquality-mlflow/test1
export DATABASE_URL=postgresql://mlflow_test:pass@localhost

mlflow server --backend-store-uri $DATABASE_URL --default-artifact-root $ARTIFACT_URL

## Deploying to Heroku

... TODO

## Deploying with Docker

... TODO

## On the client


    export MLFLOW_TRACKING_URI=http://176.58.97.239:5000
    export MLFLOW_TRACKING_TOKEN=token
    
    export GOOGLE_APPLICATION_CREDENTIALS=soundquality-fa31bc1bbb1d.json
    export MLFLOW_EXPERIMENT_NAME=test5

    experiments create -n test6
