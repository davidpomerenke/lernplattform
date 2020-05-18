# backup via heroku
yarn heroku pg:backups:capture -a lernplattform-api && yarn heroku pg:backups:download -a lernplattform-api -o datenbank/backups/$(date +%Y-%m-%d.%H:%M).dump;
# backup via sql dump
yarn -s heroku run 'pg_dump $DATABASE_URL' -a lernplattform-api > datenbank/backups/$(date +%Y-%m-%d.%H:%M).sql;