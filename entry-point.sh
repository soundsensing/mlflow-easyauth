#!/bin/bash

# FIXME: create http users from envvars

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
