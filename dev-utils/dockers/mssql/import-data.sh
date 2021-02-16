#!/bin/bash

#wait for the SQL Server to come up
sleep 45s

echo "CREATING DATABASE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

#run the setup script to create the DB and the schema in the DB
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P DEV-pw-123 -d master -i setup.sql
