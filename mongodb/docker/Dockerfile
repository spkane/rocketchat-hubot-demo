FROM docker.io/zcube/bitnami-compat-mongodb:5.0
# Upstream Dockerfile:
# https://github.com/docker-library/mongo/blob/master/5.0/Dockerfile

COPY docker-healthcheck /usr/local/bin/

# Useful Information:
# https://docs.docker.com/engine/reference/builder/#healthcheck
# https://docs.docker.com/compose/compose-file/#healthcheck
HEALTHCHECK CMD ["docker-healthcheck"]
