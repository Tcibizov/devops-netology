# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
```
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)

postgres=# 
```
- подключения к БД
```
postgres=# \c postgres
Password: 
You are now connected to database "postgres" as user "postgres".
postgres=# postgres-# \dtS
                    List of relations
   Schema   |          Name           | Type  |  Owner   
------------+-------------------------+-------+----------
 pg_catalog | pg_aggregate            | table | postgres
 pg_catalog | pg_am                   | table | postgres
 pg_catalog | pg_amop                 | table | postgres
 pg_catalog | pg_amproc               | table | postgres
```
- вывода списка таблиц
```
postgres-# \dtS
                    List of relations
   Schema   |          Name           | Type  |  Owner   
------------+-------------------------+-------+----------
 pg_catalog | pg_aggregate            | table | postgres
 pg_catalog | pg_am                   | table | postgres
 pg_catalog | pg_amop                 | table | postgres
 pg_catalog | pg_amproc               | table | postgres
 pg_catalog | pg_attrdef              | table | postgres
 pg_catalog | pg_attribute            | table | postgres
 pg_catalog | pg_auth_members         | table | postgres
 pg_catalog | pg_authid               | table | postgres
 pg_catalog | pg_cast                 | table | postgres
 pg_catalog | pg_class                | table | postgres
 pg_catalog | pg_collation            | table | postgres
 pg_catalog | pg_constraint           | table | postgres
```
- вывода описания содержимого таблиц
```
postgres-# \dS+ pg_index
                                      Table "pg_catalog.pg_index"
     Column     |     Type     | Collation | Nullable | Default | Storage  | Stats target | Description 
----------------+--------------+-----------+----------+---------+----------+--------------+-------------
 indexrelid     | oid          |           | not null |         | plain    |              | 
 indrelid       | oid          |           | not null |         | plain    |              | 
 indnatts       | smallint     |           | not null |         | plain    |              | 
 indnkeyatts    | smallint     |           | not null |         | plain    |              | 
 indisunique    | boolean      |           | not null |         | plain    |              | 
 indisprimary   | boolean      |           | not null |         | plain    |              | 
 indisexclusion | boolean      |           | not null |         | plain    |              | 
 indimmediate   | boolean      |           | not null |         | plain    |              | 
 indisclustered | boolean      |           | not null |         | plain    |              | 
 indisvalid     | boolean      |           | not null |         | plain    |              | 
 indcheckxmin   | boolean      |           | not null |         | plain    |              | 
 indisready     | boolean      |           | not null |         | plain    |              | 
 indislive      | boolean      |           | not null |         | plain    |              | 
 indisreplident | boolean      |           | not null |         | plain    |              | 
 indkey         | int2vector   |           | not null |         | plain    |              | 
 indcollation   | oidvector    |           | not null |         | plain    |              | 
 indclass       | oidvector    |           | not null |         | plain    |              | 
 indoption      | int2vector   |           | not null |         | plain    |              | 
 indexprs       | pg_node_tree | C         |          |         | extended |              | 
 indpred        | pg_node_tree | C         |          |         | extended |              | 
Indexes:
    "pg_index_indexrelid_index" UNIQUE, btree (indexrelid)
    "pg_index_indrelid_index" btree (indrelid)
Access method: heap

postgres-# 
```
- выхода из psql
```
postgres-# \q
.root@f02f409de6b0:/# 
```

## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.
```
test_database=# \dt
         List of relations
 Schema |  Name  | Type  |  Owner   
--------+--------+-------+----------
 public | orders | table | postgres
(1 row)

test_database=# ANALYZE VERBOSE public.orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
test_database=# select avg_width from pg_stats where tablename='orders';
 avg_width 
-----------
         4
        16
         4
(3 rows)

test_database=# 
```

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?
```
test_database=# alter table orders rename to orders_simple;
ALTER TABLE
test_database=# create table orders (id integer, title varchar(80), price integer) partition by range(price);
CREATE TABLE
test_database=# create table orders_less499 partition of orders for values from (0) to (499);
CREATE TABLE
test_database=# create table orders_more499 partition of orders for values from (499) to (999999999);
CREATE TABLE
test_database=# insert into orders (id, title, price) select * from orders_simple;
INSERT 0 8
test_database=# 
```
> При изначальном проектировании таблиц можно было сделать ее секционированной, тогда не пришлось бы переименовывать исходную таблицу и переносить данные в новую. 

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.
```
root@f02f409de6b0:/# pg_dump -U postgres -d test_database >test_database_dump.sql
```
Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?
> Ограничения уникальности в секционированных таблицах должны включать все столбцы ключа разбиения. Поэтому придется сделать составное ограничение для секционированной таблицы, которое будет включать title и price:
```
alter table orders add unique (title, price);
```
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
