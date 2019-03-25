- [x] Сервіс та докерфайл
- [x] Скрипти YAML для завантаження в Kubernetes
- [x] Bash скрипт, який інсталює сервіс в MiniKube автоматично
- [x] Kubernetes Readiness check + Liveness check
- [x] Bash скрипт для локального деплою в minikube (без хмарного реєстру контейнерів)
- [ ] Memory scaling (імітувати задачу, що потребує багато пам'яті і вирішити проблему масштабування у випадку досягнення критичного розміру по використанню пам'яті)

## 1. An application + Dockerfile
You can simply run an application in a single container:

### from Docker Hub:
- run `docker run -d -p 5000:5000 --rm --name ylochman-cloud-infra ylochman/apps-cloud-infra:latest`

### or locally:
- clone this repository: `git clone https://github.com/ylochman/apps-cloud-infra.git`
- run `docker build -t ylochman-hw .`
- run `docker run -d -p 5000:5000 --rm --name ylochman-cloud-infra ylochman-hw`

Then go to `localhost:5000` and follow the instructions. To stop and remove container run:

`docker container stop $(docker container ls -f "name=ylochman-cloud-infra" -q)` .

## 2. & 4. YAML maps
Located in `deploy-kubernetes`:
- deployment-cloud.yaml (with Readiness & Liveness check)
- deployment-local.yaml (with Readiness & Liveness check)
- deployment-service.yaml

## 3. & 5. Deploy an application with Minikube
Clone this repository and go to `deploy-kubernetes`

Run `chmod +x ./create-deploy-cloud.sh ./create-deploy-local.sh ./stop-deploy.sh`

To deploy an application:
- from cloud registry run `./create-deploy.sh -m`
- from local image simply add options `-l` and `-b`:  `./create-deploy.sh -mlb`.

Here: 

`-m` is to first start minikube

`-l` is to deploy an application from local image

`-b` is to build docker image locally before runing

To stop application run `./stop-depoly.sh -m`. Here `-m`is to stop minikube.

## Deploy an application onto a Docker Machine Swarm Cluster
It was done for practicing

Go to `deploy-docker-machine`

Run `chmod +x ./create-deploy.sh ./stop-deploy.sh`

To deploy an application run `./create-deploy.sh`

To stop application run `./stop-deploy.sh`

<!-- ### trash -->
<!-- `docker run -p 5000:5000 -it --rm --entrypoint=/bin/bash ylochman-hw` -->
