#!/bin/bash
set -e

# Create the extensions in the default database
psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
    CREATE EXTENSION IF NOT EXISTS postgis;
EOSQL
