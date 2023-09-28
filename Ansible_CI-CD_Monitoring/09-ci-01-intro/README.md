# Домашнее задание к занятию 7 «Жизненный цикл ПО»

## Подготовка к выполнению

1. Получить бесплатную версию [Jira](https://www.atlassian.com/ru/software/jira/free).
2. Настроить её для своей команды разработки.
3. Создать доски Kanban и Scrum.
4. [Дополнительные инструкции от разработчика Jira](https://support.atlassian.com/jira-cloud-administration/docs/import-and-export-issue-workflows/).

## Основная часть

Необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить жизненный цикл:

1. Open -> On reproduce.
2. On reproduce -> Open, Done reproduce.
3. Done reproduce -> On fix.
4. On fix -> On reproduce, Done fix.
5. Done fix -> On test.
6. On test -> On fix, Done.
7. Done -> Closed, Open.
<p align="center">
  <img src="./Assets/1.JPG">
</p>
<p align="center">
  <img src="./Assets/2.JPG">
</p>
Остальные задачи должны проходить по упрощённому workflow:

1. Open -> On develop.
2. On develop -> Open, Done develop.
3. Done develop -> On test.
4. On test -> On develop, Done.
5. Done -> Closed, Open.
<p align="center">
  <img src="./Assets/3.JPG">
</p>
**Что нужно сделать**

1. Создайте задачу с типом bug, попытайтесь провести его по всему workflow до Done.

<p align="center">
  <img src="./Assets/4.JPG">
</p>

2. Создайте задачу с типом epic, к ней привяжите несколько задач с типом task, проведите их по всему workflow до Done. 

<p align="center">
  <img src="./Assets/4.JPG">
</p>

3. При проведении обеих задач по статусам используйте kanban.

<p align="center">
  <img src="./Assets/5.JPG">
</p>

4. Верните задачи в статус Open.
5. Перейдите в Scrum, запланируйте новый спринт, состоящий из задач эпика и одного бага, стартуйте спринт, проведите задачи до состояния Closed. Закройте спринт.

<p align="center">
  <img src="./Assets/6.JPG">
</p>
<p align="center">
  <img src="./Assets/7.JPG">
</p>
<p align="center">
  <img src="./Assets/8.JPG">
</p>

6. Если всё отработалось в рамках ожидания — выгрузите схемы workflow для импорта в XML. Файлы с workflow и скриншоты workflow приложите к решению задания.  
[Workflow for bug.xml](file:/Assets/Workflow for bug.xml)  
[Workflow for other tasks.xml](file:/Assets/Workflow for other tasks.xml)
---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
