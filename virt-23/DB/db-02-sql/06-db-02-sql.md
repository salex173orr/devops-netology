# Домашнее задание к занятию "2. SQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/blob/virt-11/additional/README.md).

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

``` 
version: '3.9'

volumes:
   database:
   backup:

services:
 postgres:
   container_name: psql12
   image: postgres:12
   environment:
     POSTGRES_DB: "test"
     POSTGRES_USER: myuser
     POSTGRES_PASSWORD: 123456
   ports:
     - "5432:5432"
   volumes:      
     - database:/home/database/
     - backup:/home/backup/

alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/db-02-sql$ docker-compose up -d
[+] Running 4/4
 ⠿ Network db-02-sql_default    Created                                                                                0.3s
 ⠿ Volume "db-02-sql_database"  Created                                                                                0.0s
 ⠿ Volume "db-02-sql_backup"    Created                                                                                0.0s
 ⠿ Container psql12             Started                                                                                2.6s


alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/db-02-sql$ docker exec -it psql12 bash
root@965152e0a6d4:/#

```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db

```
test=# create user "test-admin-user";
CREATE ROLE
test=# create database test_db;
CREATE DATABASE

```
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)

```
test_db=> create table orders (id serial primary key, наименование text, цена integer);
CREATE TABLE
test_db=> create table clients (id serial primary key, фамилия text, страна_проживания text, заказ INT, foreign  key (заказ) references orders (id));
CREATE TABLE
test_db=> create index ON clients (страна_проживания);
CREATE INDEX

```
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
```
test_db=> GRANT ALL ON TABLE orders TO "test-admin-user";
GRANT
test_db=> GRANT ALL ON TABLE clients TO "test-admin-user";
GRANT
```
- создайте пользователя test-simple-user

```
test_db=# CREATE USER "test-simple-user";
CREATE ROLE

```
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

```
test_db=# GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE orders TO "test-simple-user";
GRANT
test_db=# GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE clients TO "test-simple-user";
GRANT
```

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,
```
test_db=> \l
                              List of databases
   Name    | Owner  | Encoding |  Collate   |   Ctype    | Access privileges 
-----------+--------+----------+------------+------------+-------------------
 postgres  | myuser | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | myuser | UTF8     | en_US.utf8 | en_US.utf8 | =c/myuser        +
           |        |          |            |            | myuser=CTc/myuser
 template1 | myuser | UTF8     | en_US.utf8 | en_US.utf8 | =c/myuser        +
           |        |          |            |            | myuser=CTc/myuser
 test      | myuser | UTF8     | en_US.utf8 | en_US.utf8 | 
 test_db   | myuser | UTF8     | en_US.utf8 | en_US.utf8 | 
(5 rows)
```
- описание таблиц (describe)
```
test_db=> \d orders
                               Table "public.orders"
    Column    |  Type   | Collation | Nullable |              Default               
--------------+---------+-----------+----------+------------------------------------
 id           | integer |           | not null | nextval('orders_id_seq'::regclass)
 наименование | text    |           |          | 
 цена         | integer |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)

test_db=> \d clients
                                  Table "public.clients"
      Column       |  Type   | Collation | Nullable |               Default               
-------------------+---------+-----------+----------+-------------------------------------
 id                | integer |           | not null | nextval('clients_id_seq'::regclass)
 фамилия           | text    |           |          | 
 страна_проживания | text    |           |          | 
 заказ             | integer |           |          | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "clients_страна_проживания_idx" btree ("страна_проживания")
Foreign-key constraints:
    "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
```
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
```
test_db=> SELECT grantee, table_catalog, table_name, privilege_type FROM information_schema.table_privileges 
WHERE table_name IN ('orders','clients');
```
- список пользователей с правами над таблицами test_db
```
    grantee      | table_catalog | table_name | privilege_type 
------------------+---------------+------------+----------------
 test-admin-user  | test_db       | orders     | INSERT
 test-admin-user  | test_db       | orders     | SELECT
 test-admin-user  | test_db       | orders     | UPDATE
 test-admin-user  | test_db       | orders     | DELETE
 test-admin-user  | test_db       | orders     | TRUNCATE
 test-admin-user  | test_db       | orders     | REFERENCES
 test-admin-user  | test_db       | orders     | TRIGGER
 test-simple-user | test_db       | orders     | INSERT
 test-simple-user | test_db       | orders     | SELECT
 test-simple-user | test_db       | orders     | UPDATE
 test-simple-user | test_db       | orders     | DELETE
 test-admin-user  | test_db       | clients    | INSERT
 test-admin-user  | test_db       | clients    | SELECT
 test-admin-user  | test_db       | clients    | UPDATE
 test-admin-user  | test_db       | clients    | DELETE
 test-admin-user  | test_db       | clients    | TRUNCATE
 test-admin-user  | test_db       | clients    | REFERENCES
 test-admin-user  | test_db       | clients    | TRIGGER
 test-simple-user | test_db       | clients    | INSERT
 test-simple-user | test_db       | clients    | SELECT
 test-simple-user | test_db       | clients    | UPDATE
 test-simple-user | test_db       | clients    | DELETE
(22 rows)
```

## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

```
test_db=> INSERT INTO orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
INSERT 0 5
```

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

```
test_db=> INSERT INTO clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
INSERT 0 5
```

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

```
test_db=> SELECT COUNT (*) FROM orders;
 count 
-------
     5
(1 row)

test_db=> SELECT COUNT (*) FROM clients;
 count 
-------
     5
(1 row)
```

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

```
test_db=> UPDATE clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Книга') WHERE "фамилия"='Иванов Иван Иванович';
UPDATE 1
test_db=> UPDATE clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Монитор') WHERE "фамилия"='Петров Петр Петрович';
UPDATE 1
test_db=> UPDATE clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Гитара') WHERE "фамилия"='Иоганн Себастьян Бах';
UPDATE 1
```

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.

```
test_db=> SELECT* FROM clients WHERE заказ IS NOT NULL;
 id |       фамилия        | страна_проживания | заказ 
----+----------------------+-------------------+-------
  1 | Иванов Иван Иванович | USA               |     3
  2 | Петров Петр Петрович | Canada            |     4
  3 | Иоганн Себастьян Бах | Japan             |     5
(3 rows)
```

Подсказк - используйте директиву `UPDATE`.

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

```
test_db=> EXPLAIN SELECT* FROM clients WHERE заказ IS NOT NULL;
                        QUERY PLAN                         
-----------------------------------------------------------
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)
   Filter: ("заказ" IS NOT NULL)
(2 rows)

Чтение данных из таблицы может выполняться несколькими способами. В нашем случае EXPLAIN сообщает, что используется 
Seq Scan - последовательное, блок за блоком, чтение данных таблицы clients.
cost - Это некое понятие, призванное оценить затратность операции. Первое значение 0.00 - затраты на получение первой 
строки. Второе — 18.10 - затраты на получение всех строк.
Rows - приблизительное количество возвращаемых строк при выполнении операции Seq Scan. Это значение возвращает 
планировщик. Width - средний размер одной строки в байтах.
Каждая запись сравнивается с условием "заказ" IS NOT NULL. Если условие выполняется, запись вводится в результат. 
Иначе — отбрасывается.



test_db=> EXPLAIN (ANALYZE) SELECT* FROM clients WHERE заказ IS NOT NULL;
                                             QUERY PLAN                                              
-----------------------------------------------------------------------------------------------------
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72) (actual time=0.022..0.025 rows=3 loops=1)
   Filter: ("заказ" IS NOT NULL)
   Rows Removed by Filter: 2
 Planning Time: 0.118 ms
 Execution Time: 0.061 ms
(5 rows)

Теперь уже видны реальные затраты на обработку первой и всех строк, количество выведенных строк (3), удовлетворяющих 
фильру "заказ" IS NOT NULL, количество проходов (1), количество строк, которые были удалены из запроса по фильтру (2), 
планируемое и затраченное время, а также общее количество строк, по которым производилась выборка.
```

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

``` 
root@965152e0a6d4:/# pg_dump -U test-admin-user test_db > /home/backup/test_db.backup

root@965152e0a6d4:/# ls /home/backup/
test_db.backup

alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/db-02-sql$ docker stop psql12 
psql12

alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/db-02-sql$ docker ps -a
CONTAINER ID   IMAGE              COMMAND                  CREATED       STATUS                      PORTS     NAMES
965152e0a6d4   postgres:12        "docker-entrypoint.s…"   2 hours ago   Exited (0) 13 seconds ago             psql12

alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/db-02-sql$ docker run --name psql12_ver2 -e POSTGRES_PASSWORD=123456 -d postgres:12
7a9c085faeedbdc28365583886d58c41c8d2104347e62e50db85ccb59f395827

alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/db-02-sql$ docker ps -a
CONTAINER ID   IMAGE              COMMAND                  CREATED          STATUS                      PORTS                                       NAMES
02c2290a3633   postgres:12        "docker-entrypoint.s…"   15 minutes ago   Up 15 minutes               0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   psql_ver2
965152e0a6d4   postgres:12        "docker-entrypoint.s…"   4 hours ago      Exited (0) 26 minutes ago   

alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/db-02-sql$ mkdir box

alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/db-02-sql$ docker cp psql12:/home/backup/test_db.backup  box/
Preparing to copy...
Successfully copied 6.144kB to /home/alexandr_shtykov/Netology/DB/db-02-sql/box/

alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/db-02-sql$ docker cp box/test_db.backup  psql12_ver2:/home/
Preparing to copy...
Copying to container - 6.144kB
Successfully copied 6.144kB to psql12_ver2:/home/

alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/db-02-sql$ docker exec -it psql_ver2 bash

root@02c2290a3633:/# psql -U postgres -d test_db -f /home/test_db.backup
...
test_db=# 
```
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
