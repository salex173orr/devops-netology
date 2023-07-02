# Домашнее задание к занятию 3 «Использование Ansible»

## Подготовка к выполнению

1. Подготовьте в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.
2. Репозиторий LightHouse находится [по ссылке](https://github.com/VKCOM/lighthouse).

## Основная часть

1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse.
2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.
3. Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.
4. Подготовьте свой inventory-файл `prod.yml`.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
## Playbook 
скачивает необходимые дистрибутивы и производит установку Clickhouse, Vector, Nginx и Lighthouse на соответствующие hosts (указанные в inventory/prod.yml)  
Hosts и inventory/prod.yml создаются при помощи terraform  
 Состоит из 4 PLAY (Install Clickhouse, Install Vector, Install nginx, Install lighthouse):
### PLAY [Install Clickhouse] 
содержит handlers и tasks, необходимые для установки Clickhouse и БД для него
- handlers [Start clickhouse service]: - выполняет рестарт сервиса Clickhouse, если какая-либо задача произвела изменение конфигурации и сообщила об этом
- tasks:
  - [Get clickhouse distrib] - block из из двух tasks для скачивания дистрибутивов. rescue применяется для продолжения работы следующей task в случае ошибки выполения предыдущей
  - [Install clickhouse packages] - установка Clickhouse из скачанных дистрибутивов (черех notify обращаемся к handlers для рестарта сервиса в случае изменения конфигурации)
  - [Flush handlers] - принудительно запустить все handlers на этом этапе, не дожидаясь обычных точек синхронизации
  - [Create database] - создание БД 
### PLAY [Install Vector]
содержит tasks, необходимые для установки и настройки Vector
- tasks:
  - [Install Vector] - установка Vector
  - [Vector | Template Config] - добавление конфига
  - [Vector | Create systemd unit] - создание vector.service
  - [Vector | Start Service] - запуск Vector
### PLAY [Install nginx]  
содержит handlers и tasks, необходимые для установки и настройки nginx
- handlers 
  - [start-nginx]: старт сервиса nginx
  - [reload-nginx]: перезапуск сервиса nginx
- tasks:
  - [NGINX | Install epel-release] - Установка репозиториев epel
  - [NGINX | Install NGINX] - Установка nginx
  - [NGINX | Create general config] - Добавление конфига nginx
### PLAY [Install lighthouse]  
содержит handlers и tasks, необходимые для установки и настройки lighthouse
- handlers [reload-nginx]: - перезапуск сервиса nginx
- pre_tasks:
    - [Lighthouse | Install dependencies] - установка git (выполняется до основных tasks в данном play)
- tasks:
    - [Lighthouse | Copy from git] - копирование Lighthouse в выбранную директорию
    - [Lighthouse | Create lighthouse config] - создание конфига lighthouse
### tags:
- clickhouse - выполнить PLAY [Install Clickhouse]
```ansible-playbook site.yml -i inventory/prod.yml --tags clickhouse```
- vector - выполнить PLAY [Install Vector]
```ansible-playbook site.yml -i inventory/prod.yml --tags vector```
- nginx - выполнить PLAY [Install nginx]
```ansible-playbook site.yml -i inventory/prod.yml --tags nginx```
- lighthouse - выполнить PLAY [Install lighthouse]
```ansible-playbook site.yml -i inventory/prod.yml --tags lighthouse```
### group_vars
- Clickhouse: 
  - clickhouse_version - версия Clickhouse
  - clickhouse_packages - тип дистрибутива
- Vector:
  - vector_version - версия Vector
- Lighthouse:
    - lighthouse_vcs - ссылка на lighthouse (git)
    - lighthouse_location_dir - директория для копирования lighthouse
    - lighthouse_access_log_name - имя для .log файла
    - nginx_user_name - пользователь nginx
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
