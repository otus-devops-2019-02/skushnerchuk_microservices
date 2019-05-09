[![Build Status](https://travis-ci.com/otus-devops-2019-02/skushnerchuk_microservices.svg?branch=docker-2)](https://travis-ci.com/otus-devops-2019-02/skushnerchuk_microservices)
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


<details>
<summary>Homework 12 (docker-1)</summary>

**Основное задание**

- Установлены docker, docker-compose, docker-machine;
- Рассмотрели жизненные циклы контейнера на примере стандартных образов (hello-world, ubuntu, nginx);

**Задания со \***
- Рассмотрены различия между образом и конейнером.
</details>
