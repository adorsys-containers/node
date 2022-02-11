FROM registry.access.redhat.com/ubi8/ubi:latest AS TZDATA

FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

LABEL maintainer="adorsys GmbH & Co. KG" \
      vendor="adorsys GmbH & Co. KG" \
      name="adorsys/node:12" \
      org.label-schema.vendor="adorsys GmbH & Co. KG" \
      org.label-schema.name="adorsys/node:12-ubi-8" \
      io.k8s.display-name="adorsys/node:12-ubi-8" \
      summary="adorsys/node:12-ubi-8" \
      io.k8s.description="adorsys/node:12-ubi-8" \
      org.label-schema.description="adorsys/node:12-ubi-8" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.usage="" \
      org.label-schema.license="" \
      org.label-schema.build-date=""

EXPOSE 3000

# discard npm update warnings
ENV TZ=Europe/Berlin \
    LC_ALL=C.UTF-8 \
    NO_UPDATE_NOTIFIER=1 \
    ENABLE_AUTO_NODE_MEMORY_LIMIT=true \
    NODE_MEMORY_LIMIT_PERCENT=80

# https://bugzilla.redhat.com/show_bug.cgi?id=1211117
COPY --from=TZDATA /usr/share/zoneinfo/UTC /usr/share/zoneinfo/UTC
COPY --from=TZDATA /usr/share/zoneinfo/Europe/Berlin /usr/share/zoneinfo/Europe/Berlin

WORKDIR /opt/app-root

RUN set -euxo pipefail \
    && microdnf --noplugins module disable nodejs \
    && microdnf --noplugins update -y && microdnf --noplugins clean all && rm -rf /var/cache/yum \
    && echo -e '[nodesource]\nname=nodesource\nbaseurl=https://rpm.nodesource.com/pub_12.x/el/8/$basearch\nenabled=1\ngpgcheck=1\ngpgkey=https://rpm.nodesource.com/pub/el/NODESOURCE-GPG-SIGNING-KEY-EL' > /etc/yum.repos.d/nodesource.repo \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && microdnf --noplugins install --nodocs -y openssl nodejs \
    && microdnf --noplugins clean all -y \
    && npm install -g npm \
    && npm install -g yarn \
    && npm cache clear --force \
    && chmod g=u /etc/passwd \
    && mkdir -p /opt/app-root && chown -R 1001:0 /opt/app-root && chmod -R ug+rwx /opt/app-root

COPY root /

ENTRYPOINT ["/docker-entrypoint.sh"]

USER 1001
