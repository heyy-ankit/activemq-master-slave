#!/usr/bin/env bash
set -euo pipefail

if [[ -n "${ACTIVEMQ_ADMIN_USERNAME:-}" && -n "${ACTIVEMQ_ADMIN_PASSWORD:-}" ]]; then
  sed -i "s/^admin: .*/${ACTIVEMQ_ADMIN_USERNAME}: ${ACTIVEMQ_ADMIN_PASSWORD}, admin/" "${ACTIVEMQ_CONF}/jetty-realm.properties"
fi

if [[ -n "${ACTIVEMQ_MIN_MEMORY:-}" || -n "${ACTIVEMQ_MAX_MEMORY:-}" ]]; then
  if [[ -n "${ACTIVEMQ_MIN_MEMORY:-}" ]]; then
    export ACTIVEMQ_OPTS_MEMORY="-Xms${ACTIVEMQ_MIN_MEMORY} ${ACTIVEMQ_OPTS_MEMORY:-}"
  fi

  if [[ -n "${ACTIVEMQ_MAX_MEMORY:-}" ]]; then
    export ACTIVEMQ_OPTS_MEMORY="-Xmx${ACTIVEMQ_MAX_MEMORY} ${ACTIVEMQ_OPTS_MEMORY:-}"
  fi
fi

exec "$@"
