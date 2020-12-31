echo 'delete from lehrplan *; delete from lehrplandetails *;' | heroku pg:psql -a lernplattform-api;
cat lehrplan-ausleser/bw.sql | heroku pg:psql -a lernplattform-api &> upload.log;
cat lehrplan-ausleser/by.sql | heroku pg:psql -a lernplattform-api &> upload.log;