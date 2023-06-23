# Домашнее задание к занятию 2 «Работа с Playbook»

## Подготовка к выполнению

1. * Необязательно. Изучите, что такое [ClickHouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) и [Vector](https://www.youtube.com/watch?v=CgEhyffisLY).
2. Создайте свой публичный репозиторий на GitHub с произвольным именем или используйте старый.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev).
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.
---
## Playbook 
скачивает необходимые дистрибутивы и производит установку Clickhouse и Vector на соответствующие hosts (указанные в inventory/prod.yml)  
 Состоит из 2 PLAY (Install Clickhouse и Install Vector):
### PLAY [Install Clickhouse] 
содержит handlers и tasks, необходимые для установки Clickhouse и БД для него
- handlers [Start clickhouse service]: - выполняет рестарт сервиса Clickhouse, если какая-либо задача произвела изменение конфигурации и сообщила об этом
- tasks:
  - [Get clickhouse distrib] - block из из двух task для скачивания дистрибутивов. rescue применяется для продолжения работы следующей task в случае ошибки выполения предыдущей
  - [Install clickhouse packages] - установка Clickhouse из скачанных дистрибутивов (черех notify обращаемся к handlers для рестарта сервиса в случае изменения конфигурации)
  - [Flush handlers] - принудительно запустить все handlers на этом этапе, не дожидаясь обычных точек синхронизации
  - [Create database] - создание БД 
### PLAY [Install Vector]
содержит handlers и tasks, необходимые для установки Clickhouse и БД для него
- handlers [Start Vector service]: - выполняет рестарт сервиса Vector, если какая-либо задача произвела изменение конфигурации и сообщила об этом
- tasks:
  - [Creates directory *vector*] - создание директории для скачивания дистрибутива
  - [Get Vector distrib] - скачивание дистрибутива в указанную директорию
  - [Install Vector] - установка Vector из скачанного дистрибутива (черех notify обращаемся к handlers для рестарта сервиса в случае изменения конфигурации)
### tags:
- clickhouse - выполнить PLAY [Install Clickhouse]
```ansible-playbook site.yml -i inventory/prod.yml --tags clickhouse```
- vector - выполнить PLAY [Install Vector]
```ansible-playbook site.yml -i inventory/prod.yml --tags vector```
### group_vars
- Clickhouse: 
  - clickhouse_version - версия Clickhouse
  - clickhouse_packages - тип дистрибутива
- Vector:
  - vector_version - версия Vector
### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
