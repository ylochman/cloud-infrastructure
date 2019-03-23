# Cloud Inrastructure Course 2019 at UCU | Homework

### HW to-do list
- [x] Сервіс та докерфайл
- [ ] Скрипти YAML для завантаження в Kubernetes
- [ ] Bash скрипт, який інсталює сервіс в MiniKube автоматично
- [ ] Kubernetes Readiness check + Liveness check
- [ ] Bash скрипт для локального деплою в minikube (без хмарного реєстру контейнерів)
- [ ] Memory scaling (імітувати задачу, що потребує багато пам'яті і вирішити проблему масштабування у випадку досягнення критичного розміру по використанню пам'яті)

## Run a service application in a single container
First choose one of two options:

### DockerHub
1. run `docker run -d -p 5000:5000 --rm --name ylochman-cloud-infra ylochman/apps-cloud-infra:latest`

### GitHub
1. clone this repository: `git clone https://github.com/ylochman/apps-cloud-infra.git`
2. run `docker build -t ylochman-hw .`
3. run `docker run -d -p 5000:5000 --rm --name ylochman-cloud-infra ylochman-hw`


Then go to `localhost:5000` and follow the instructions.

Eventually run `docker container stop $(docker container ls -f "name=ylochman-cloud-infra" -q)` to stop and remove container.

<!-- ### trash -->
<!-- `docker run -p 5000:5000 -it --rm --entrypoint=/bin/bash ylochman-hw` -->
