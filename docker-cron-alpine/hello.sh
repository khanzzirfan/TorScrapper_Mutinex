#!/bin/bash

echo 'hello world (from a job)'
sudo docker exec -it freshonions-torscraper-crawler /bin/bash ./scripts/docker_haproxy_harvest_scrape.sh