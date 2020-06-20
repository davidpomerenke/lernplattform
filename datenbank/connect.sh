# role is readonly, password safe to be published
PGPASSWORD='notreallyapassword' \
psql \
   --host=lernplattform.cn2ksamauz39.eu-central-1.rds.amazonaws.com \
   --port=5432 \
   --username=anonymous \
   --dbname=lernplattform 