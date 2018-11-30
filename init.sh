#!/bin/bash

git clone https://github.com/matchish/placeinqueue.git frontend
git clone https://github.com/matchish/placeinqueue-api.git api
git clone https://github.com/matchish/placeinqueue-api.git lambda

docker-compose exec serverless deploy
docker-compose exec api npm install && npm migrate
docker-compose up -d mariadb api frontend