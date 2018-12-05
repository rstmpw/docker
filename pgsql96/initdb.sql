CREATE ROLE dbuser
LOGIN
PASSWORD 'vagrant'
NOSUPERUSER
NOINHERIT
NOCREATEDB
NOCREATEROLE
NOREPLICATION;

CREATE DATABASE customdb
    WITH OWNER = postgres
    ENCODING = 'UTF8'
    TABLESPACE = pg_default
    LC_COLLATE = 'C'
    LC_CTYPE = 'ru_RU.UTF-8'
    CONNECTION LIMIT = -1;

ALTER ROLE dbuser IN DATABASE customdb
SET search_path = dbschema;

\c customdb
CREATE SCHEMA dbschema;

ALTER SCHEMA dbschema
    OWNER TO dbuser;