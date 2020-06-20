# role is readonly, password safe to be published
PGPASSWORD='notreallyapassword' \
pg_dump  \
  --host=lernplattform.cn2ksamauz39.eu-central-1.rds.amazonaws.com \
  --port=5432 \
  --username=anonymous \
  --dbname=lernplattform \
  --exclude-schema "hdb_*" \
  --file datenbank/backups/$(date +%Y-%m-%d.%H:%M).sql;