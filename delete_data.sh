#!/bin/bash
odoo="egov-odoo"
postgres="egov-db"
database="prod"
postgres_conn="docker exec -i $postgres psql -U odoo $database"

echo "=========== Start ==========="
# Stop odoo
echo  "\033[33m★\033[0m Stopping odoo"
docker stop $odoo

# Restart postgres
echo "\n\033[33m★\033[0m Restarting $postgres"
docker restart $postgres

# Sleep 30 s
echo "\n\033[33m★\033[0m Sleeping next command 30 second"
sleep 30

############ Delete Transaction Data ############

$postgres_conn -c "delete from purchase_request_line"
$postgres_conn -c "delete from purchase_request"

#################################################

############### Delete Master Data ##############

#$postgres_conn -c "delete from res_partner where id not in (select partner_id from res_users union select partner_id from res_company)"

#################################################

# Start odoo
echo "\n\033[33m★\033[0m Starting $odoo"
docker start $odoo
echo "=========== Finish ==========="
