# dcss-web-docker

Dockerized web version of Dungeon Crawl Stone Soup

# To run

1. Install `docker-compose`
3. Run `docker-compose pull`
    1.  Alternatively if you don't trust the image on docker hub, skip this and run `git submodule update --init --recursive`, as dcss has a lot of subrepos
5. Run `docker-compose up`
6. Point a browser to `http://localhost:9090` locally, or `http://your-ip:9090`
   from somewhere else on the LAN.
