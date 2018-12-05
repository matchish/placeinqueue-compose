#!/bin/bash
docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git --user $(id -u):$(id -g) alpine/git clone https://github.com/matchish/placeinqueue.git frontend
docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git --user $(id -u):$(id -g) alpine/git clone https://github.com/matchish/placeinqueue-api.git api
docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git --user $(id -u):$(id -g) alpine/git clone https://github.com/matchish/placeinqueue-api.git browser

docker-compose -f docker-compose-prod.yml up -d db api
docker-compose exec api npm run migrate
