#!/bin/bash

P=$(pwd)

KC_ROOT_DB_PASSWORD=$(< /dev/urandom LC_CTYPE=C tr -dc _A-Z-a-z-0-9 | head -c6)
KC_DB_PASSWORD=$(< /dev/urandom LC_CTYPE=C tr -dc _A-Z-a-z-0-9 | head -c6)
KC_PASSWORD=$(< /dev/urandom LC_CTYPE=C tr -dc _A-Z-a-z-0-9 | head -c6)
AS_MYSQL_ROOT_PASSWORD=$(< /dev/urandom LC_CTYPE=C tr -dc _A-Z-a-z-0-9 | head -c6)
AS_DB_PASSWORD=$(< /dev/urandom LC_CTYPE=C tr -dc _A-Z-a-z-0-9 | head -c6)

SERVICE_CLIENT_SECRET=$(< /dev/urandom LC_CTYPE=C tr -dc _A-Z-a-z-0-9 | head -c64)

cp $P/.env.template .env

sed 's/$KC_ROOT_DB_PASSWORD/'"$KC_ROOT_DB_PASSWORD"'/g' $P/.env > $P/tmp; mv $P/tmp $P/.env
sed 's/$KC_DB_PASSWORD/'"$KC_DB_PASSWORD"'/g' $P/.env > $P/tmp; mv $P/tmp $P/.env
sed 's/$KC_PASSWORD/'"$KC_PASSWORD"'/g' $P/.env > $P/tmp; mv $P/tmp $P/.env
sed 's/$AS_MYSQL_ROOT_PASSWORD/'"$AS_MYSQL_ROOT_PASSWORD"'/g' $P/.env > $P/tmp; mv $P/tmp $P/.env
sed 's/$AS_DB_PASSWORD/'"$AS_DB_PASSWORD"'/g' $P/.env > $P/tmp; mv $P/tmp $P/.env
sed 's/$SERVICE_CLIENT_SECRET/'"$SERVICE_CLIENT_SECRET"'/g' $P/.env > $P/tmp; mv $P/tmp $P/.env

sed 's/$DB_TYPE/'"postgresql9"'/g' $P/.env > $P/tmp; mv $P/tmp $P/.env
sed 's/$DB_DRIVER/'"postgresql"'/g' $P/.env > $P/tmp; mv $P/tmp $P/.env
sed 's/$DB_CONN_URL/'"jdbc:postgresql:\\/\\/apicurio-studio-db\\/apicuriodb"'/g' $P/.env > $P/tmp; mv $P/tmp $P/.env



cp $P/config/keycloak/apicurio-realm.json.template $P/config/keycloak/apicurio-realm.json
cp $P/config/keycloak/microcks-realm.json.template $P/config/keycloak/microcks-realm.json.tmp
sed 's/$SERVICE_CLIENT_SECRET/'"$SERVICE_CLIENT_SECRET"'/g' $P/config/keycloak/microcks-realm.json.tmp > $P/config/keycloak/microcks-realm.json

rm -rf $P/config/keycloak/microcks-realm.json.tmp

echo "Keycloak username: admin"
echo "Keycloak password: $KC_PASSWORD"
echo "SUCCESS"