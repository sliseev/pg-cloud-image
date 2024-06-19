# Use the official PostgreSQL image as a base
FROM postgres:16

# Update the package list and install the required extensions
RUN apt-get update && \
    apt-get install -y curl && \
    curl https://install.citusdata.com/community/deb.sh > add-citus-repo.sh && \
    bash add-citus-repo.sh && \
    apt-get install -y postgresql-16-citus-12.1 && \
    apt-get install -y postgresql-contrib postgis && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the custom configuration file to the PostgreSQL config directory
# COPY postgresql.conf /etc/postgresql/postgresql.conf
COPY postgresql.conf /usr/share/postgresql/postgresql.conf.sample

# Add the extensions to the database initialization script
COPY init-db.sh /docker-entrypoint-initdb.d/

# Expose the PostgreSQL port
EXPOSE 5432

# Specify custom configuration file to use instead of the default one
# CMD [ "-c", "config_file=/etc/postgresql/postgresql.conf" ]
