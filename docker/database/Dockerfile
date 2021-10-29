FROM postgres:14-alpine

# Copy entrypoint
COPY ./docker/database/pg-init-scripts/create-multiple-postgresql-databases.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/create-multiple-postgresql-databases.sh