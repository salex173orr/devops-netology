# Домашнее задание к занятию "4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.
```
alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/06-db-04-postgresql$ docker pull postgres:13
13: Pulling from library/postgres
f1f26f570256: Already exists 
1c04f8741265: Already exists 
dffc353b86eb: Already exists 
18c4a9e6c414: Already exists 
81f47e7b3852: Already exists 
5e26c947960d: Already exists 
a2c3dc85e8c3: Already exists 
17df73636f01: Already exists 
124bb42a3852: Pull complete 
dfb19482a052: Pull complete 
bbb12a596105: Pull complete 
aa8960c4e383: Pull complete 
fdbdb6eba8dc: Pull complete 
Digest: sha256:00f455399f30cc3f2fe4185476601438b7a4959c74653665582d7c313a783d51
Status: Downloaded newer image for postgres:13
docker.io/library/postgres:13
_______________________________________________________________________________
volumes:
   database:

services:
 postgres:
   container_name: postgres13
   image: postgres:13
   environment:
     POSTGRES_USER: myuser
     POSTGRES_PASSWORD: 123456
   ports:
     - "5432:5432"
   volumes:      
     - database:/home/database/
_________________________________________________________________________________
alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/06-db-04-postgresql$ docker-compose up -d
[+] Running 3/3
 ⠿ Network 06-db-04-postgresql_default    Created                          0.4s
 ⠿ Volume "06-db-04-postgresql_database"  Created                          0.1s
 ⠿ Container postgres13                   Starte...                        3.9s

alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/06-db-04-postgresql$ docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED         STATUS         PORTS                                       NAMES
235cb3ebac90   postgres:13   "docker-entrypoint.s…"   4 minutes ago   Up 3 minutes   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   postgres13
```
Подключитесь к БД PostgreSQL используя `psql`.
```
alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/06-db-04-postgresql$ docker exec -it postgres13 bash
root@235cb3ebac90:/# psql -U myuser
psql (13.10 (Debian 13.10-1.pgdg110+1))
Type "help" for help.

myuser=# 
```
Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.
**Найдите и приведите** управляющие команды для:
- вывода списка БД
```
\l[+]   [PATTERN]      list databases
_____________________________________________________________________________________________
myuser=# \l
                              List of databases
   Name    | Owner  | Encoding |  Collate   |   Ctype    | Access privileges 
-----------+--------+----------+------------+------------+-------------------
 myuser    | myuser | UTF8     | en_US.utf8 | en_US.utf8 | 
 postgres  | myuser | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | myuser | UTF8     | en_US.utf8 | en_US.utf8 | =c/myuser        +
           |        |          |            |            | myuser=CTc/myuser
 template1 | myuser | UTF8     | en_US.utf8 | en_US.utf8 | =c/myuser        +
           |        |          |            |            | myuser=CTc/myuser
(4 rows)
```
- подключения к БД
```
\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
                         connect to new database (currently "myuser")
_______________________________________________________________________________________
myuser=# \connect postgres 
You are now connected to database "postgres" as user "myuser".
```
- вывода списка таблиц
```
 \dt[S+] [PATTERN]      list tables
________________________________________________________________________________________
myuser=# \dtS
                   List of relations
   Schema   |          Name           | Type  | Owner  
------------+-------------------------+-------+--------
 pg_catalog | pg_aggregate            | table | myuser
 pg_catalog | pg_am                   | table | myuser
 pg_catalog | pg_amop                 | table | myuser
 pg_catalog | pg_amproc               | table | myuser
 pg_catalog | pg_attrdef              | table | myuser
 pg_catalog | pg_attribute            | table | myuser
 pg_catalog | pg_auth_members         | table | myuser
 pg_catalog | pg_authid               | table | myuser
 pg_catalog | pg_cast                 | table | myuser
 pg_catalog | pg_class                | table | myuser
 pg_catalog | pg_collation            | table | myuser
 pg_catalog | pg_constraint           | table | myuser
 pg_catalog | pg_conversion           | table | myuser
 pg_catalog | pg_database             | table | myuser
 pg_catalog | pg_db_role_setting      | table | myuser
 pg_catalog | pg_default_acl          | table | myuser
 pg_catalog | pg_depend               | table | myuser
 pg_catalog | pg_description          | table | myuser
 pg_catalog | pg_enum                 | table | myuser
 pg_catalog | pg_event_trigger        | table | myuser
 pg_catalog | pg_extension            | table | myuser
 pg_catalog | pg_foreign_data_wrapper | table | myuser
 pg_catalog | pg_foreign_server       | table | myuser
 pg_catalog | pg_foreign_table        | table | myuser
 pg_catalog | pg_index                | table | myuser
 pg_catalog | pg_inherits             | table | myuser
 pg_catalog | pg_init_privs           | table | myuser
 pg_catalog | pg_language             | table | myuser
 pg_catalog | pg_largeobject          | table | myuser
 pg_catalog | pg_largeobject_metadata | table | myuser
 pg_catalog | pg_namespace            | table | myuser
 pg_catalog | pg_opclass              | table | myuser
 pg_catalog | pg_operator             | table | myuser
 pg_catalog | pg_opfamily             | table | myuser
 pg_catalog | pg_partitioned_table    | table | myuser
 pg_catalog | pg_policy               | table | myuser
 pg_catalog | pg_proc                 | table | myuser
 pg_catalog | pg_publication          | table | myuser
 pg_catalog | pg_publication_rel      | table | myuser
 pg_catalog | pg_range                | table | myuser
 pg_catalog | pg_replication_origin   | table | myuser
 pg_catalog | pg_rewrite              | table | myuser
 pg_catalog | pg_seclabel             | table | myuser
 pg_catalog | pg_sequence             | table | myuser
 pg_catalog | pg_shdepend             | table | myuser
 pg_catalog | pg_shdescription        | table | myuser
 pg_catalog | pg_shseclabel           | table | myuser
 pg_catalog | pg_statistic            | table | myuser
 pg_catalog | pg_statistic_ext        | table | myuser
 pg_catalog | pg_statistic_ext_data   | table | myuser
 pg_catalog | pg_subscription         | table | myuser
 pg_catalog | pg_subscription_rel     | table | myuser
 pg_catalog | pg_tablespace           | table | myuser
 pg_catalog | pg_transform            | table | myuser
 pg_catalog | pg_trigger              | table | myuser
 pg_catalog | pg_ts_config            | table | myuser
 pg_catalog | pg_ts_config_map        | table | myuser
 pg_catalog | pg_ts_dict              | table | myuser
 pg_catalog | pg_ts_parser            | table | myuser
 pg_catalog | pg_ts_template          | table | myuser
 pg_catalog | pg_type                 | table | myuser
 pg_catalog | pg_user_mapping         | table | myuser
(62 rows)
```
- вывода описания содержимого таблиц
```
\d[S+]  NAME           describe table, view, sequence, or index
___________________________________________________________________________________________________________
myuser=# \dS+ pg_am
                                  Table "pg_catalog.pg_am"
  Column   |  Type   | Collation | Nullable | Default | Storage | Stats target | Description 
-----------+---------+-----------+----------+---------+---------+--------------+-------------
 oid       | oid     |           | not null |         | plain   |              | 
 amname    | name    |           | not null |         | plain   |              | 
 amhandler | regproc |           | not null |         | plain   |              | 
 amtype    | "char"  |           | not null |         | plain   |              | 
Indexes:
    "pg_am_name_index" UNIQUE, btree (amname)
    "pg_am_oid_index" UNIQUE, btree (oid)
Access method: heap
```
- выхода из psql
```
 \q                     quit psql
________________________________________________________________________________________________________
myuser=# \q
root@235cb3ebac90:/# 
```

## Задача 2

Используя `psql` создайте БД `test_database`.
```
myuser=# CREATE DATABASE test_database;
CREATE DATABASE
```
Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.
```
alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/06-db-04-postgresql$ docker cp ./test_data/test_dump.sql postgres13:/home/database/
Preparing to copy...
Copying to container - 4.096kB
Successfully copied 4.096kB to postgres13:/home/database/

root@235cb3ebac90:/# psql -U myuser -d test_database < /home/database/test_dump.sql 
SET
SET
SET
SET
SET
 set_config 
------------
 
(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ERROR:  role "postgres" does not exist
CREATE SEQUENCE
ERROR:  role "postgres" does not exist
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval 
--------
      8
(1 row)

ALTER TABLE
```
Перейдите в управляющую консоль `psql` внутри контейнера.
```
root@235cb3ebac90:/# psql -U myuser -d test_database
psql (13.10 (Debian 13.10-1.pgdg110+1))
Type "help" for help.

test_database=# 
```
Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.
```
test_database=# ANALYZE VERBOSE public.orders; 
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 8 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
```
Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.
```
test_database=# SELECT max(avg_width) AS avg_width  FROM pg_stats WHERE tablename='orders';
 avg_width 
-----------
        16
(1 row)

test_database=# SELECT attname, avg_width  FROM pg_stats WHERE avg_width=16;
 attname | avg_width 
---------+-----------
 title   |        16
(1 row)
```
**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.
```
test_database=# CREATE TABLE orders_price_more_499 (LIKE orders);
CREATE TABLE
test_database=# INSERT INTO orders_price_more_499 SELECT * FROM orders WHERE price > 499;
INSERT 0 3
test_database=# DELETE FROM orders WHERE price > 499;
DELETE 3
______________________________________________________________________________________________
test_database=# CREATE TABLE orders_price_less_499 (LIKE orders);
CREATE TABLE
test_database=# INSERT INTO orders_price_less_499 SELECT * FROM orders WHERE price <= 499;
INSERT 0 5
test_database=# DELETE FROM orders WHERE price <= 499;
DELETE 5
_______________________________________________________________________________________________
test_database=# SELECT * FROM orders_price_more_499; 
 id |       title        | price 
----+--------------------+-------
  2 | My little database |   500
  6 | WAL never lies     |   900
  8 | Dbiezdmin          |   501
(3 rows)

test_database=# SELECT * FROM orders_price_less_499; 
 id |        title         | price 
----+----------------------+-------
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  7 | Me and my bash-pet   |   499
(5 rows)

```
Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?
```
Можно. В официальной документации по PostgreSQL:13 это раздел "5.11. Table Partitioning"
```
## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.
```
root@235cb3ebac90:/# pg_dump -U myuser test_database > /tmp/test_database_backup.sql
```
Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?
```
Unique constraints ensure that the data contained in a column, or a group of columns, is unique among all the rows in 
the table.
_____________________________________________________________________________________________________________________
...
CREATE TABLE public.orders_price_less_499 (
    id integer NOT NULL,
    title character varying(80) NOT NULL UNIQUE,
    price integer
);

CREATE TABLE public.orders_price_more_499 (
    id integer NOT NULL,
    title character varying(80) NOT NULL UNIQUE,
    price integer
);
...
or
...
CREATE TABLE public.orders_price_less_499 (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer
    UNIQUE (title)
);

CREATE TABLE public.orders_price_more_499 (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer
    UNIQUE (title)
);
```
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
