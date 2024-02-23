FROM docker.io/zcube/bitnami-compat-mongodb:5.0
# Upstream Dockerfile:
# https://github.com/bitnami/containers/blob/f9fb3f8a6323fb768fd488c77d4f111b1330bd0e/bitnami/mongodb/5.0/debian-11/Dockerfile

COPY docker-healthcheck /usr/local/bin/

# Useful Information:
# https://docs.docker.com/engine/reference/builder/#healthcheck
# https://docs.docker.com/compose/compose-file/#healthcheck
HEALTHCHECK CMD ["docker-healthcheck"]
