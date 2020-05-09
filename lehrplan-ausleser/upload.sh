echo 'delete from lehrplan *; delete from lehrplandetails *;' | heroku pg:psql -a lernplattform-api;
cat bw.sql | heroku pg:psql -a lernplattform-api &> upload.log;
cat by.sql | heroku pg:psql -a lernplattform-api &> upload.log;