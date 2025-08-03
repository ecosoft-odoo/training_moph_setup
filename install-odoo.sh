#!/bin/bash

docker compose -f ./docker-compose.yml up -d
chown -R $USER ./odoo
docker exec -it -u 0 odoo chown -R odoo /var/lib/odoo
cp ./odoo.conf ./odoo/config/odoo.conf
docker restart odoo postgres
