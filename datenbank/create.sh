cat datenbank/schema.sql | heroku pg:psql -a lernplattform-api;
cat datenbank/tabelle-schulartenbedeutung.sql | heroku pg:psql -a lernplattform-api;