#!/bin/bash -x


if [[ -z "${PORT}" ]]; then
    export PORT=6000
fi

envsubst '${PORT}' < /app/nginx.conf.template > /etc/nginx/nginx.conf

htpasswd -b -c /etc/nginx/.htpasswd ${MLFLOW_TRACKING_USERNAME} ${MLFLOW_TRACKING_PASSWORD}

exec nginx -g "daemon off;"
