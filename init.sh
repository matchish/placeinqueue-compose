#!/bin/bash
docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git --user $(id -u):$(id -g) alpine/git clone https://github.com/matchish/placeinqueue.git frontend
docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git --user $(id -u):$(id -g) alpine/git clone https://github.com/matchish/placeinqueue-api.git api
docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git --user $(id -u):$(id -g) alpine/git clone https://github.com/matchish/placeinqueue-lambda.git browser

# TODO: remove hack
mkdir frontend/dist
chown 1000:1000 frontend/dist

docker-compose -f docker-compose.yml -f prod.docker-compose.yml up -d db api frontend nginx
docker-compose exec api npm run migrate
