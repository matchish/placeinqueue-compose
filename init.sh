#!/bin/bash
docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git --user $(id -u):$(id -g) alpine/git clone https://github.com/matchish/placeinqueue.git frontend
docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git --user $(id -u):$(id -g) alpine/git clone https://github.com/matchish/placeinqueue-api.git api
docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git --user $(id -u):$(id -g) alpine/git clone https://github.com/matchish/placeinqueue-lambda.git browser
docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git --user $(id -u):$(id -g) alpine/git clone https://github.com/matchish/placeinqueue-dispatcher.git dispatcher

# TODO: remove hack
mkdir frontend/dist
sudo chown 1000:1000 frontend/dist

docker-compose -f docker-compose.yml -f prod.docker-compose.yml up -d api nginx
docker-compose -f docker-compose.yml -f prod.docker-compose.yml run --rm frontend npm run build
docker-compose -f docker-compose.yml -f prod.docker-compose.yml run --rm browser deploy
docker-compose -f docker-compose.yml -f prod.docker-compose.yml run --rm dispatcher deploy
docker-compose exec api npm run migrate