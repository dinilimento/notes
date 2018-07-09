#!/bin/sh
set -e -> abort on error

echo "ENTRYPOINT EXECUTED!!!"

export WEB_COUNTER_MSG="${WEB_COUNTER_MSG:-default text msg here}"

exec "$@" -> shell magic, very important. Zorgt ervoor dat elke regel in dit .sh script wordt uitgevoerd in CMD