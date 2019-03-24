#!/bin/bash

if [ ! -f .env ]; then
  sh config_env.sh
fi

PG_VERSION="$(ls /etc/postgresql)"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
echo '-------------------'
echo "Configuring $PG_HBA"

sudo bash -c "echo '# TYPE  DATABASE        USER            ADDRESS                 METHOD' > $PG_HBA"
sudo bash -c "echo '' >> $PG_HBA"
sudo bash -c "echo '# Allow postgres user to connect to database without password' >> $PG_HBA"
sudo bash -c "echo 'local   all             postgres                                trust' >> $PG_HBA"
sudo bash -c "echo '' >> $PG_HBA"
sudo bash -c "echo 'local   all             all                                     trust' >> $PG_HBA"
sudo bash -c "echo '' >> $PG_HBA"
sudo bash -c "echo '# Full access to 0.0.0.0 (localhost) for pgAdmin host machine access' >> $PG_HBA"
sudo bash -c "echo '# IPv4 local connections:' >> $PG_HBA"
sudo bash -c "echo 'host    all             all             0.0.0.0/0               trust' >> $PG_HBA"
sudo bash -c "echo '' >> $PG_HBA"
sudo bash -c "echo '# IPv6 local connections:' >> $PG_HBA"
sudo bash -c "echo 'host    all             all             ::1/128                 trust' >> $PG_HBA"

sh pg-start.sh

echo '-----------------------------'
echo 'gem install bundler -v 1.17.3'
gem install bundler -v 1.17.3

echo '--------------'
echo 'bundle install'
bundle install

echo '----------------------------------------'
echo "sudo -u postgres createuser -d $USERNAME"
sudo -u postgres createuser -d $USERNAME

echo '-----------------------------------'
echo "Make the user $USERNAME a superuser"
psql -c "ALTER USER $USERNAME WITH SUPERUSER;" -U postgres

echo '-----------------------------------------------------'
echo "psql -c 'create database triage_development;' -U postgres"
psql -c 'create database triage_development;' -U postgres

echo '--------------------------------------------------'
echo "psql -c 'create database triage_test;' -U postgres"
psql -c 'create database triage_test;' -U postgres

echo '--------------------------------------------------'
echo 'cp config/database.example.yml config/database.yml'
cp config/database.example.yml config/database.yml

sh pg-start.sh

sh kill_spring.sh
sh all.sh
