#!/bin/bash

docker compose -f ./docker-compose.yml up -d
chown -R $USER ./odoo
docker exec -it -u 0 odoo chown -R odoo /var/lib/odoo
cp ./odoo.conf ./odoo/config/odoo.conf
docker exec -it -u 0 odoo apt-get update && apt-get install -y  xfonts-thai xfonts-thai-etl xfonts-thai-manop xfonts-thai-nectec xfonts-thai-poonlap xfonts-thai-vor
docker restart odoo postgres
