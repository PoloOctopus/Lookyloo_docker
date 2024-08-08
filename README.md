# Dockerfile for Lookyloo

**This repository is *unofficial*, it is not developed and maintained by Lookyloo developers.** This repository aims to provide a Dockerfile and docker compose file to deploy Lookyloo : https://github.com/Lookyloo/lookyloo

## Installation

Clone the repository<br>
```
git clone https://github.com/PoloOctopus/Lookyloo_docker
cd Lookyloo_docker
```

Build the docker image
```
sudo docker build -t lookyloo .
```

Start the docker compose
```
sudo docker compose up -d
```

By default, Lookyloo is accessible at http://127.0.0.1:5100/

## Lookyloo configurations

Lookyloo configuration is passed thought `lookyloo` folder. The folder `lookyloo/config/` has 3 config file:
- `generic.json` is by default
- `modules.json` is by default
- `logging.json` has been changed to redirects all logs to `lookyloo/logs/lookyloo.log`

## Q&A

Various questions and insights on this repository.

### What is the `Dockerfile_v2` file ?

The `Dockerfile_v2` is not functionnal. It aims to use Docker best pratices. The main objective of this v2 is to use a non-root user inside the Docker container.