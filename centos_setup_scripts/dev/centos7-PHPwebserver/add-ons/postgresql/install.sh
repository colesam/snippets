#!/bin/bash

# install postgresql
yum install -y --enablerepo=remi-php72 php-pgsql
yum install -y postgresql-server postgresql-contrib

# initialize postgresql
postgresql-setup initdb

# copy configuration
cat ./setup-files/pg_hba.conf > /var/lib/pgsql/data/pg_hba.conf

# start postgresql service
systemctl start postgresql
systemctl enable postgresql

# from here you may run the following commands to create a user, database, and run the shell
# passwd postgres
# su postgres
# createuser --interactive
# createdb db-name (typically db-name will match the name of the user)