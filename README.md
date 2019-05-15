

[![Build Status](https://travis-ci.com/otus-devops-2019-02/skushnerchuk_microservices.svg?branch=docker-4)](https://travis-ci.com/otus-devops-2019-02/skushnerchuk_microservices)

### Homework 15 (docker-4)

После выполнения команды
```
docker run --network host -d nginx
```
ее повтор приведет к провалу запуска, так как первый контейнер уже занял нужные адрес/порт:
```
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
```

**docker-compose**

Базовое имя проекта можно задать с помощью ключа -p при старте:
```bash
docker-compose -p my_project up -d
```
По умолчанию в качестве имени проекта используется имя директории, откуда осуществляется запуск.

**Задание со \***

Для того чтобы иметь возможность изменения кода, не меняя образ, мы можем смонтировать папки с исходниками с помощью конструкции:
```Dockerfile
volumes:
  - type: bind
    source: ./post-py
    target: /app
```
Эта возможность, а также ручной запуск **puma** вынесены в файл **docker-compose.override.yml**

<details>
<summary>Homework 14 (docker-3)</summary>
**Основное задание**

Создана новая структура приложения для формирования микросервисной архитектуры

**Задание со \***

Для изменения значения переменных используем ключ "-e":
```bash
$ docker run -d --network=reddit --network-alias=post_db_alt --network-alias=comment_db_alt mongo:latest
$ docker run -d --network=reddit --network-alias=post_alt -e POST_DATABASE_HOST=post_db_alt skushnerchuk/post:1.0
$ docker run -d --network=reddit --network-alias=comment_alt -e COMMENT_DATABASE_HOST=comment_db_alt skushnerchuk/comment:1.0
$ docker run -d --network=reddit -p 9292:9292 -e POST_SERVICE_HOST=post_alt -e COMMENT_SERVICE_HOST=comment_alt skushnerchuk/ui:1.0
```

Подключено внешнее хранилище к контейнеру с mongo:
```
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest
```
Все образы пересобраны на основе alpine:
```bash
REPOSITORY                TAG                 SIZE
drcoyote/post             1.0                 67.1MB
drcoyote/comment          1.0                 63.4MB
drcoyote/ui               1.0                 66.2MB
```
</details>

<details>
<summary>Homework 13 (docker-2)</summary>
**Основное задание**

Выполнено создание нового проекта в GCP

Повторил практику из лекции:
$ docker run -d --network=reddit --network-alias=post_db_alt --network-alias=comment_db_alt mongo:latest
$ docker run -d --network=reddit --network-alias=post_alt -e POST_DATABASE_HOST=post_db_alt skushnerchuk/post:1.0
$ docker run -d --network=reddit --network-alias=comment_alt -e COMMENT_DATABASE_HOST=comment_db_alt skushnerchuk/
comment:1.0
$ docker run -d --network=reddit -p 9292:9292 -e POST_SERVICE_HOST=post_alt -e COMMENT_SERVICE_HOST=comment_alt
skushnerchuk/ui:1.0
```

Подключено внешнее хранилище к контейнеру с mongo:
```
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest
```

Все образы пересобраны на основе alpine:
```
REPOSITORY                TAG                 SIZE
drcoyote/post             1.0                 67.1MB
drcoyote/comment          1.0                 63.4MB
drcoyote/ui               1.0                 66.2MB
```

<details>
<summary>Homework 13 (docker-2)</summary>
### Homework 13 (docker-2)
**Основное задание**

Выполнено создание нового проекта в GCP

Повторил практику из лекции:
- PID namespace (изоляция процессов)
- net namespace (изоляция сети)
- user namespaces (изоляция пользователей)

Результаты сравнения
```docker
docker run --rm -ti tehbilly/htop
docker run --rm --pid host -ti tehbilly/htop
```
В первом случае htop отображает только только PID 1 контейнера, во втором - множество процессов хостовой системы.

Создан Dockerfile с приложением, на его основе построен образ и залит на Docker Hub

**Задания со \***

Написан шаблон пакера, создающий оброаз с уже установленным docker

С использованием этого шаблона создана конфигурация terraform, которая используется для поднятия приложения с указанным количеством экземпляров ВМ.

Написаны ansible playbooks для установки докера в образ и для запуска контейнера после поднятия инфраструктуры.
</details>

<details>
<summary>Homework 12 (docker-1)</summary>

**Основное задание**

- Установлены docker, docker-compose, docker-machine;
- Рассмотрели жизненные циклы контейнера на примере стандартных образов (hello-world, ubuntu, nginx);

**Задания со \***
- Рассмотрены различия между образом и конейнером.
</details>
