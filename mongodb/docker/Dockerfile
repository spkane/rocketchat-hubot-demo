FROM docker.io/bitnami/mongodb:4.4
# Approxiamate Upstream Dockerfile:
# https://github.com/bitnami/bitnami-docker-mongodb/blob/879452aa052d33744384d43949958a3204ad5d29/4.4/debian-10/Dockerfile

COPY docker-healthcheck /usr/local/bin/

# Useful Information:
# https://docs.docker.com/engine/reference/builder/#healthcheck
# https://docs.docker.com/compose/compose-file/#healthcheck
HEALTHCHECK CMD ["docker-healthcheck"]
