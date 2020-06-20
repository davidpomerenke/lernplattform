# role is readonly, password safe to be published
PGPASSWORD='notreallyapassword' \
pg_dump  \
  --host=lernplattform.cn2ksamauz39.eu-central-1.rds.amazonaws.com \
  --port=5432 \
  --username=anonymous \
  --dbname=lernplattform \
  --schema-only \
  --exclude-schema "hdb_*" \
  --no-owner \
  --no-privileges \
  --file datenbank/schema.sql;
# role is readonly, password safe to be published
PGPASSWORD='notreallyapassword' \
pg_dump  \
  --host=lernplattform.cn2ksamauz39.eu-central-1.rds.amazonaws.com \
  --port=5432 \
  --username=anonymous \
  --dbname=lernplattform \
  --table=schulartenbedeutung \
  --no-owner \
  --no-privileges \
  --file datenbank/tabelle-schulartenbedeutung.sql;