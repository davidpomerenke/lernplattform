yarn -s heroku run 'pg_dump -sOx $DATABASE_URL' -a lernplattform-api > datenbank/schema.sql;
yarn -s heroku run 'pg_dump $DATABASE_URL -t schulartenbedeutung -Ox' -a lernplattform-api > datenbank/tabelle-schulartenbedeutung.sql;
yarn -s heroku run 'pg_dump $DATABASE_URL' -a lernplattform-api > datenbank/backups/datenbank.sql;