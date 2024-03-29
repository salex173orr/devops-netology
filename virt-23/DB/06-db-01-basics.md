# Домашнее задание к занятию "1. Типы и структура СУБД"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/tree/virt-11/additional).

## Задача 1

Архитектор ПО решил проконсультироваться у вас, какой тип БД 
лучше выбрать для хранения определенных данных.

Он вам предоставил следующие типы сущностей, которые нужно будет хранить в БД:

- Электронные чеки в json виде``: документо-ориентированные БД, например СУБД MongoDB (для хранения объектов в одной 
сущности, но с разной структурой на основе JSON)``
- Склады и автомобильные дороги для логистической компании``: графовые БД, например СУБД Neo4j (позволяют производить поиск 
наикратчайшего/оптимального пути/дороги между узлами/складами)``
- Генеалогические деревья``: древовидная (иерархическая) структура данных в релядионной БД``
- Кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации``: БД вида "ключ-значение", например 
СУБД Memcashed (данные хранятся в оперативной памяти и есть возможность настройки "времени жизни")``
- Отношения клиент-покупка для интернет-магазина``: лучшим выбором, на мой взгляд, будет реляционная БД, например СУБД MySQL 
(позволит в полной мере реализовать систему сбора информации, анализа и прогнозирования на её основе путем 
построения связей и отношений)``

Выберите подходящие типы СУБД для каждой сущности и объясните свой выбор.

## Задача 2

Вы создали распределенное высоконагруженное приложение и хотите классифицировать его согласно 
CAP-теореме. Какой классификации по CAP-теореме соответствует ваша система, если 
(каждый пункт - это отдельная реализация вашей системы и для каждого пункта надо привести классификацию):

- Данные записываются на все узлы с задержкой до часа (асинхронная запись)``: AP (отсутствует согласованность данных)|
PA/EL - высокая доступность (A) при разделении (P) системы иначе (E) высокая скорость ответа (L).``
- При сетевых сбоях, система может разделиться на 2 раздельных кластера``: AC (отсутствует устойчивость к разделению)|
PA/EL - высокая доступность (A) при разделении (P) системы иначе (E) высокая скорость ответа (L).``
- Система может не прислать корректный ответ или сбросить соединение``: CP (отсутствует доступность)|
PC/EC - такая система будет жертвовать доступностью (A) в угоду консистентности (С) при разделении (P) в распределённых 
системах.``

А согласно PACELC-теореме, как бы вы классифицировали данные реализации?

## Задача 3

Могут ли в одной системе сочетаться принципы BASE и ACID? Почему?``: `Нет, так как эти принципы противоречат друг другу.
ACID предназначен для построения высоконадежных систем (все транзакции в них атомарны, согласованны, изолированны друг 
от друга и стойки к низкоуровневым проблемам). BASE наоборот предназначен для построения высокопроизводительных систем 
(гарантируется базовая доступность и только в конечном итоге достигается согласованность данных)`

## Задача 4

Вам дали задачу написать системное решение, основой которого бы послужили:

- фиксация некоторых значений с временем жизни
- реакция на истечение таймаута

Вы слышали о key-value хранилище, которое имеет механизм Pub/Sub. 
Что это за система? Какие минусы выбора данной системы?``: Redis - это key-value хранилище, имеет механизм Pub/Sub и 
TTL с возможностью реакции на его истечение. REDIS - это достаточно надежное решение. Однако существует ряд минусов: 
в случае большого объема ОЗУ он может долго не вытеснять устаревшие ключи до момента, пока не начнет заканчиваться 
память. При удалении устаревших ключей может наблюдаться подвисание работы. Чтобы это предотвратить, необходимо 
контролировать некоторые параметры Redis с помощью утилит мониторига, а также параметры виртуальной машины, в которой 
работает сам Redis (также могут быть задержки ввода-вывода, сетевые, и др.) С учетом того, что Redis - однопоточное 
InMemory-приложение, надо понимать, что на сервере с одним физическим ядром и малым объемом ОЗУ также могут возникать 
некоторые замедления в работе. Для оптимизации работы с памятью есть ряд рекомендаций по настройке от разработчиков. 
При работе с Redis в режиме кластера могут быть замедления при возобновлении работы вышедшей из строя ноды (особенно 
недоступной длительное время) из-за большой нагрузки на сеть``

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.