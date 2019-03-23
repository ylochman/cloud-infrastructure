# Work In Progress (to-do list:)
- [x] Сервіс та докерфайл
- [ ] Скрипти YAML для завантаження в Kubernetes
- [ ] Bash скрипт, який інсталює сервіс в MiniKube автоматично
- [ ] Kubernetes Readiness check + Liveness check
- [ ] Bash скрипт для локального деплою в minikube (без хмарного реєстру контейнерів)
- [ ] Memory scaling (імітувати задачу, що потребує багато пам'яті і вирішити проблему масштабування у випадку досягнення критичного розміру по використанню пам'яті)

## Run an application in a single container (single service)
First choose one of two options:

### From Docker Hub
1. run `docker run -d -p 5000:5000 --rm --name ylochman-cloud-infra ylochman/apps-cloud-infra:latest`

### From GitHub
1. clone this repository: `git clone https://github.com/ylochman/apps-cloud-infra.git`
2. run `docker build -t ylochman-hw .`
3. run `docker run -d -p 5000:5000 --rm --name ylochman-cloud-infra ylochman-hw`


Then go to `localhost:5000` and follow the instructions.

Eventually run `docker container stop $(docker container ls -f "name=ylochman-cloud-infra" -q)` to stop and remove container.

## Deploy an application onto a Docker Machine Swarm Cluster
Go to `deploy-docker-machine`

Run `chmod +x ./deploy-app.sh ./stop-app.sh`

To deploy an application run `./deploy-app.sh`

To stop application run `./stop-app.sh`

<!-- ### trash -->
<!-- `docker run -p 5000:5000 -it --rm --entrypoint=/bin/bash ylochman-hw` -->
