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
  --file database/schema.sql;
# role is readonly, password safe to be published
PGPASSWORD='notreallyapassword' \
pg_dump  \
  --host=lernplattform.cn2ksamauz39.eu-central-1.rds.amazonaws.com \
  --port=5432 \
  --username=anonymous \
  --dbname=lernplattform \
  --table=school_aliases \
  --no-owner \
  --no-privileges \
  --file database/school-aliases.sql;