#!/bin/bash
docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git --user $(id -u):$(id -g) alpine/git clone https://github.com/matchish/placeinqueue.git frontend
docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git --user $(id -u):$(id -g) alpine/git clone https://github.com/matchish/placeinqueue-api.git api
docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git --user $(id -u):$(id -g) alpine/git clone https://github.com/matchish/placeinqueue-api.git browser

docker-compose up -d mariadb api frontend browser
docker-compose exec api npm migrate
