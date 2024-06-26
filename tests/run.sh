#!/bin/bash
set -e
 
# Load docker defaults and check conf
docker info

# Change folder to the root folder
PARENTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/../ && pwd )"
cd $PARENTDIR

# Delete any instance if previously existent
docker rm -f httpbin-inst || echo ''
docker rm -f evilshell-inst || echo ''
docker network rm evilshell-testnet || echo ''

# Create the network
docker network create evilshell-testnet

# Run httpbin container for local testing
docker pull kennethreitz/httpbin
docker run -p 8888:80 --net=evilshell-testnet --rm --name httpbin-inst -d kennethreitz/httpbin

# Wait until the http server is serving
until $(curl --output /dev/null --silent --head http://localhost:8888/); do
    sleep 1
done

# Build evilshell container
docker build -f tests/docker/Dockerfile . -t evilshell
docker run  --rm --net=evilshell-testnet --name evilshell-inst -v `pwd`:/app/ -p 80:80 -d evilshell

# Wait until the http server is serving
until $(curl --output /dev/null --silent --head http://localhost/); do
    sleep 1
done

if [ "$1" = "bash" ]; then
  docker exec -e "AGENT=$AGENT" -it evilshell-inst /bin/bash
else
  for AGENT in agent.php agent.phar; do
    if [ -z "$1" ]; then
      docker exec -e "AGENT=$AGENT" -it evilshell-inst python -m unittest discover ./tests/ "test_*.py"
    else
      docker exec -e "AGENT=$AGENT" -it evilshell-inst python -m unittest discover ./tests/ "test_$1.py"
    fi
  done
fi

docker rm -f evilshell-inst 
docker rm -f httpbin-inst
docker network rm evilshell-testnet