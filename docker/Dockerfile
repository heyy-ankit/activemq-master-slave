FROM eclipse-temurin:17-jre-jammy

ARG ACTIVEMQ_VERSION=5.18.4
ARG ACTIVEMQ_ARCHIVE_URL=https://archive.apache.org/dist/activemq/${ACTIVEMQ_VERSION}/apache-activemq-${ACTIVEMQ_VERSION}-bin.tar.gz

ENV ACTIVEMQ_HOME=/opt/activemq \
    ACTIVEMQ_BASE=/opt/activemq \
    ACTIVEMQ_TMP=/opt/activemq/tmp \
    ACTIVEMQ_DATA=/opt/activemq/data \
    ACTIVEMQ_CONF=/opt/activemq/conf

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /opt \
    && curl -fsSL "${ACTIVEMQ_ARCHIVE_URL}" -o /tmp/activemq.tgz \
    && tar -xzf /tmp/activemq.tgz -C /opt \
    && mv "/opt/apache-activemq-${ACTIVEMQ_VERSION}" "${ACTIVEMQ_HOME}" \
    && rm -f /tmp/activemq.tgz \
    && mkdir -p "${ACTIVEMQ_DATA}" "${ACTIVEMQ_TMP}"

COPY docker/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 61616 8161
VOLUME ["/opt/activemq/data"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bin/activemq", "console"]
