# Домашнее задание к занятию "3. MySQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/blob/virt-11/additional/README.md).

## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

```
alexandr_shtykov@Ubuntu-Netology:~$ docker pull mysql:8
8: Pulling from library/mysql
328ba678bf27: Pull complete 
f3f5ff008d73: Pull complete 
dd7054d6d0c7: Pull complete 
70b5d4e8750e: Pull complete 
cdc4a7b43bdd: Pull complete 
3e9c0b61a8f3: Pull complete 
806a08b6c085: Pull complete 
021b2cebd832: Pull complete 
ad31ba45b26b: Pull complete 
0d4c2bd59d1c: Pull complete 
148dcef42e3b: Pull complete 
Digest: sha256:f496c25da703053a6e0717f1d52092205775304ea57535cc9fcaa6f35867800b
Status: Downloaded newer image for mysql:8
docker.io/library/mysql:8
__________________________________
volumes:
   database:

services:
 mysql:
   container_name: mysql8
   image: mysql:8
   environment:
     MYSQL_DATABASE: "test_db"
     MYSQL_USER: myuser
     MYSQL_PASSWORD: 123456
     MYSQL_ROOT_PASSWORD: 123456
   volumes:      
     - database:/home/database/
___________________________________

alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/06-db-03-mysql$ docker-compose up -d
[+] Running 3/3
 ⠿ Network 06-db-03-mysql_default    C...                                  0.3s
 ⠿ Volume "06-db-03-mysql_database"  Created                               0.1s
 ⠿ Container mysql8                  Started                               3.8s
```

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-03-mysql/test_data) и 
восстановитесь из него.
```
alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/06-db-03-mysql$ docker cp test_dump.sql mysql8:/home/database/
Preparing to copy...
Copying to container - 4.096kB
Successfully copied 4.096kB to mysql8:/home/database/


alexandr_shtykov@Ubuntu-Netology:~/Netology/DB/06-db-03-mysql$ docker exec -it mysql8 bash
bash-4.4# mysql -u myuser -p test_db
bash-4.4# ls /home/database/
test_dump.sql

bash-4.4# mysql -u myuser -p test_db < /home/database/test_dump.sql 
Enter password: 
bash-4.4# 
```

Перейдите в управляющую консоль `mysql` внутри контейнера.
```
bash-4.4# mysql -u myuser -p test_db                        
Enter password:
...
mysql> 
```
Используя команду `\h` получите список управляющих команд.
```
mysql> \h

For information about MySQL products and services, visit:
   http://www.mysql.com/
For developer information, including the MySQL Reference Manual, visit:
   http://dev.mysql.com/
To buy MySQL Enterprise support, training, or other products, visit:
   https://shop.mysql.com/

List of all MySQL commands:
Note that all text commands must be first on line and end with ';'
?         (\?) Synonym for `help'.
clear     (\c) Clear the current input statement.
connect   (\r) Reconnect to the server. Optional arguments are db and host.
delimiter (\d) Set statement delimiter.
edit      (\e) Edit command with $EDITOR.
ego       (\G) Send command to mysql server, display result vertically.
exit      (\q) Exit mysql. Same as quit.
go        (\g) Send command to mysql server.
help      (\h) Display this help.
nopager   (\n) Disable pager, print to stdout.
notee     (\t) Don't write into outfile.
pager     (\P) Set PAGER [to_pager]. Print the query results via PAGER.
print     (\p) Print current command.
prompt    (\R) Change your mysql prompt.
quit      (\q) Quit mysql.
rehash    (\#) Rebuild completion hash.
source    (\.) Execute an SQL script file. Takes a file name as an argument.
status    (\s) Get status information from the server.
system    (\!) Execute a system shell command.
tee       (\T) Set outfile [to_outfile]. Append everything into given outfile.
use       (\u) Use another database. Takes database name as argument.
charset   (\C) Switch to another charset. Might be needed for processing binlog with multi-byte charsets.
warnings  (\W) Show warnings after every statement.
nowarning (\w) Don't show warnings after every statement.
resetconnection(\x) Clean session context.
query_attributes Sets string parameters (name1 value1 name2 value2 ...) for the next query to pick up.
ssl_session_data_print Serializes the current SSL session data to stdout or file

For server side help, type 'help contents'
```
Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.
```
status    (\s) Get status information from the server.

mysql> \s
--------------
mysql  Ver 8.0.32 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:		11
Current database:	test_db
Current user:		myuser@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		8.0.32 MySQL Community Server - GPL
Protocol version:	10
Connection:		Localhost via UNIX socket
Server characterset:	utf8mb4
Db     characterset:	utf8mb4
Client characterset:	latin1
Conn.  characterset:	latin1
UNIX socket:		/var/run/mysqld/mysqld.sock
Binary data as:		Hexadecimal
Uptime:			1 hour 58 min 46 sec

Threads: 2  Questions: 50  Slow queries: 0  Opens: 174  Flush tables: 3  Open tables: 92  Queries per second avg: 0.007
--------------
```
Подключитесь к восстановленной БД и получите список таблиц из этой БД.
```
mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)
```
**Приведите в ответе** количество записей с `price` > 300.
```
mysql> select count(*) from orders where price > 300;
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)
```
В следующих заданиях мы будем продолжать работу с данным контейнером.

## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"
```
bash-4.4# mysql -u root -p test_db
Enter password: 
mysql> CREATE USER 'test'@'localhost'
    -> IDENTIFIED WITH mysql_native_password BY '123456'
    -> WITH MAX_QUERIES_PER_HOUR 100
    -> PASSWORD EXPIRE INTERVAL 180 DAY
    -> FAILED_LOGIN_ATTEMPTS 3
    -> ATTRIBUTE '{"first_name":"James", "last_name":"Pretty"}';
Query OK, 0 rows affected (0.19 sec)
```

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.
```
mysql> GRANT SELECT ON test_db.* TO 'test'@'localhost';
Query OK, 0 rows affected, 1 warning (0.27 sec)
```
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.
```
mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
+------+-----------+------------------------------------------------+
| USER | HOST      | ATTRIBUTE                                      |
+------+-----------+------------------------------------------------+
| test | localhost | {"last_name": "Pretty", "first_name": "James"} |
+------+-----------+------------------------------------------------+
1 row in set (0.00 sec)
```

## Задача 3

Установите профилирование `SET profiling = 1`.
```
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)
```
Изучите вывод профилирования команд `SHOW PROFILES;`.
```
mysql> show profiles;
+----------+------------+----------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                      |
+----------+------------+----------------------------------------------------------------------------+
|        1 | 0.00328000 | SELECT ENGINE FROM information_schema.TABLES where table_schema='test
_db' |
|        2 | 0.00023925 | SELECT ENGINE FROM information_schema.TABLES where table_schema='test'
jh  |
|        3 | 0.00322875 | SELECT ENGINE FROM information_schema.TABLES where table_schema='test'     |
|        4 | 0.00260900 | SELECT ENGINE FROM information_schema.TABLES where table_schema='test'     |
|        5 | 0.00109375 | SELECT * from INFORMATION_SCHEMA.USER_ATTRIBUTES where USER = 'test'       |
|        6 | 0.00029400 | set profiling = 1                                                          |
+----------+------------+----------------------------------------------------------------------------+
6 rows in set, 1 warning (0.00 sec)

mysql> SHOW PROFILE FOR QUERY 5;
+--------------------------------+----------+
| Status                         | Duration |
+--------------------------------+----------+
| starting                       | 0.000185 |
| Executing hook on transaction  | 0.000017 |
| starting                       | 0.000021 |
| checking permissions           | 0.000019 |
| Opening tables                 | 0.000320 |
| init                           | 0.000018 |
| System lock                    | 0.000021 |
| optimizing                     | 0.000034 |
| statistics                     | 0.000079 |
| preparing                      | 0.000055 |
| executing                      | 0.000109 |
| checking permissions           | 0.000071 |
| end                            | 0.000010 |
| query end                      | 0.000009 |
| waiting for handler commit     | 0.000022 |
| closing tables                 | 0.000027 |
| freeing items                  | 0.000044 |
| cleaning up                    | 0.000034 |
+--------------------------------+----------+
18 rows in set, 1 warning (0.00 sec)
```
Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.
```
mysql> SELECT ENGINE FROM information_schema.TABLES where table_schema='test_db';
+--------+
| ENGINE |
+--------+
| InnoDB |
+--------+
1 row in set (0.01 sec)
```
Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`
```
mysql> ALTER TABLE orders ENGINE = MyIsam;
Query OK, 5 rows affected (1.24 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE orders ENGINE = InnoDB;
Query OK, 5 rows affected (2.66 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SHOW PROFILES;
+----------+------------+----------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                      |
+----------+------------+----------------------------------------------------------------------------+
......................................................................................................
|        8 | 1.24445900 | ALTER TABLE orders ENGINE = MyIsam                                         |
|        9 | 0.00268725 | SELECT ENGINE FROM information_schema.TABLES where table_schema='test_db'  |
|       10 | 2.65542150 | ALTER TABLE orders ENGINE = InnoDB                                         |
|       11 | 0.00333200 | SELECT ENGINE FROM information_schema.TABLES where table_schema='test_db'  |
+----------+------------+----------------------------------------------------------------------------+
11 rows in set, 1 warning (0.00 sec)
```
## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных
```
innodb_flush_log_at_trx_commit = 2
```
- Нужна компрессия таблиц для экономии места на диске
```
innodb_file_per_table = ON
```
- Размер буффера с незакомиченными транзакциями 1 Мб
```
innodb_log_buffer_size = 1M
```
- Буффер кеширования 30% от ОЗУ
```
innodb_buffer_pool_size = 4G
```
- Размер файла логов операций 100 Мб
```
innodb_log_file_size = 100M
```

Приведите в ответе измененный файл `my.cnf`.
```
bash-4.4# cat /etc/my.cnf
# For advice on how to change settings please see
# http://dev.mysql.com/doc/refman/8.0/en/server-configuration-defaults.html

[mysqld]
#
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
# innodb_buffer_pool_size = 128M
#
# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin
#
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M

# Remove leading # to revert to previous value for default_authentication_plugin,
# this will increase compatibility with older clients. For background, see:
# https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin
# default-authentication-plugin=mysql_native_password
skip-host-cache
skip-name-resolve
datadir=/var/lib/mysql
socket=/var/run/mysqld/mysqld.sock
secure-file-priv=/var/lib/mysql-files

innodb_flush_log_at_trx_commit = 2
innodb_file_per_table = ON
innodb_log_buffer_size = 1M
innodb_buffer_pool_size = 4096M
innodb_log_file_size = 100M

user=mysql

pid-file=/var/run/mysqld/mysqld.pid
[client]
socket=/var/run/mysqld/mysqld.sock

!includedir /etc/mysql/conf.d/
```
---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
