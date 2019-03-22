# apps-Cloud-Infrastructure

This is a homework for the Cloud Inrastructure Course 2019 at UCU

## Start a service application
Choose one of two options:

### DockerHub
run `docker run -p 5000:5000 -it --rm ylochman/cloud-infra-hw:latest`

### GitHub
1. clone this repository: `git clone https://github.com/ylochman/apps-cloud-infra.git`
2. run `docker build -t hw1 .`
3. run `docker run -p 5000:5000 -it --rm hw1`

Go to `localhost:5000` and follow the instructions

<!-- ### trash -->
<!-- `docker run -p 5000:5000 -it --rm --entrypoint=/bin/bash hw1` -->
