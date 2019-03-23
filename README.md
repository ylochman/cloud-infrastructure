# Cloud Inrastructure Course 2019 at UCU | Homework

### HW to-do list
- [x] Сервіс та докерфайл
- [ ] Скрипти YAML для завантаження в Kubernetes
- [ ] Bash скрипт, який інсталює сервіс в MiniKube автоматично
- [ ] Kubernetes Readiness check + Liveness check
- [ ] Bash скрипт для локального деплою в minikube (без хмарного реєстру контейнерів)
- [ ] Memory scaling (імітувати задачу, що потребує багато пам'яті і вирішити проблему масштабування у випадку досягнення критичного розміру по використанню пам'яті)

## Start a service application
First choose one of two options:

### DockerHub
run `docker run -p 5000:5000 -it --rm ylochman/cloud-infra-hw:latest`

### GitHub
1. clone this repository: `git clone https://github.com/ylochman/apps-cloud-infra.git`
2. run `docker build -t hw1 .`
3. run `docker run -p 5000:5000 -it --rm hw1`

Then go to `localhost:5000` and follow the instructions

<!-- ### trash -->
<!-- `docker run -p 5000:5000 -it --rm --entrypoint=/bin/bash hw1` -->
