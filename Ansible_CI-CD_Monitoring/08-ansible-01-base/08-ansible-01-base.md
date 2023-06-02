# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.
<p align="center">
  <img src="./Assets/ansible_1_0.png">
</p>

2. Создайте свой публичный репозиторий на GitHub с произвольным именем.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
<p align="center">
  <img src="./Assets/ansible_1_1.png">
</p>

2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.
<p align="center">
  <img src="./Assets/ansible_1_2_0.png">
  <img src="./Assets/ansible_1_2_1.png">
</p>

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
<p align="center">
  <img src="./Assets/ansible_1_3.png">
</p>

4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
<p align="center">
  <img src="./Assets/ansible_1_4.png">
</p>

5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
<p align="center">
  <img src="./Assets/ansible_1_5.png">
</p>

6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
<p align="center">
  <img src="./Assets/ansible_1_6.png">
</p>

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
<p align="center">
  <img src="./Assets/ansible_1_7.png">
</p>

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
<p align="center">
  <img src="./Assets/ansible_1_8.png">
</p>

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
<p align="center">
  <img src="./Assets/ansible_1_9.png">
</p>

10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
<p align="center">
  <img src="./Assets/ansible_1_10.png">
</p>

11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
<p align="center">
  <img src="./Assets/ansible_1_11.png">
</p>

12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
<p align="center">
  <img src="./Assets/ansible_1_add_1.png">
</p>

2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
<p align="center">
  <img src="./Assets/ansible_1_add_2_0.png">
  <img src="./Assets/ansible_1_add_2_1.png">
</p>

3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
<p align="center">
  <img src="./Assets/ansible_1_add_3.png">
</p>

4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
<p align="center">
  <img src="./Assets/ansible_1_add_4_0.png">
  <img src="./Assets/ansible_1_add_4_1.png">
  <img src="./Assets/ansible_1_add_4_2.png">
  <img src="./Assets/ansible_1_add_4_3.png">
</p>

5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
<p align="center">
  <img src="./Assets/ansible_1_add_5_0.png">
  <img src="./Assets/ansible_1_add_5_1.png">
  <img src="./Assets/ansible_1_add_5_2.png">
  <img src="./Assets/ansible_1_add_5_3.png">
</p>

6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
