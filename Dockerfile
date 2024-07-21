FROM prom/node-exporter:v1.8.1@sha256:fa7fa12a57eff607176d5c363d8bb08dfbf636b36ac3cb5613a202f3c61a6631 AS node-exporter

FROM crashvb/supervisord:202402150134@sha256:c05da5b946d637ee406a2372b8855e1b93ecccee84efd3226c5219430ef020ea
ARG org_opencontainers_image_created=undefined
ARG org_opencontainers_image_revision=undefined
LABEL \
	org.opencontainers.image.authors="Richard Davis <crashvb@gmail.com>" \
	org.opencontainers.image.base.digest="sha256:c05da5b946d637ee406a2372b8855e1b93ecccee84efd3226c5219430ef020ea" \
	org.opencontainers.image.base.name="crashvb/supervisord:202402150134" \
	org.opencontainers.image.created="${org_opencontainers_image_created}" \
	org.opencontainers.image.description="Image containing node exporter." \
	org.opencontainers.image.licenses="Apache-2.0" \
	org.opencontainers.image.source="https://github.com/crashvb/node-exporter-docker" \
	org.opencontainers.image.revision="${org_opencontainers_image_revision}" \
	org.opencontainers.image.title="crashvb/node-exporter" \
	org.opencontainers.image.url="https://github.com/crashvb/node-exporter-docker"

# Install packages, download files ...
RUN docker-apt apache2-utils ssl-cert

# Configure: node-exporter
ENV NODE_EXPORTER_CONFIG=/etc/node-exporter
COPY --from=node-exporter /bin/node_exporter /bin/
COPY web-config* /usr/local/share/node-exporter/
RUN usermod --append --groups=ssl-cert nobody

# Configure: supervisor
COPY supervisord.node-exporter.conf /etc/supervisor/conf.d/node-exporter.conf

# Configure: entrypoint
COPY entrypoint.node-exporter /etc/entrypoint.d/node-exporter

# Configure: healthcheck
COPY healthcheck.node-exporter /etc/healthcheck.d/node-exporter

EXPOSE 9100/tcp

VOLUME ${NODE_EXPORTER_CONFIG}
