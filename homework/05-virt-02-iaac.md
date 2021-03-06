
# Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"

## Как сдавать задания

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.

Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Любые вопросы по решению задач задавайте в чате учебной группы.

---

## Задача 1

- Опишите своими словами основные преимущества применения на практике IaaC паттернов.
> Ускорение производства и вывода продукта на рынок. Стабильность среды, устранение дрейфа конфигураций. Более быстрая и эффективная разработка. Упрощает предоставление инфраструктуры и повышая её консистентность, IaaC ускоряет каждый этап жизненного цикла доставки ПО.
- Какой из принципов IaaC является основополагающим?
> Основополагающий принцип IaaC - идемпотентность. Это означает, что при развертывании инфраструктуры мы получим всегда один и тот же результат.

## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?
> У Ansible простая установка, простой синтаксис. Не требует установка агентов на удаленные сервера. Так-же это ПО с открытым исходным кодом.
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?
> В Ansible применяется метод push, который более надежный, чем pull. При использовании pull на удалённые сервера необходимо устанавливать агент, который должен будет делать запросы. При push мы можем отправить настройки на удалённые сервера в любой момент.
## Задача 3

Установить на личный компьютер:

- VirtualBox
```bash
root@debian:/home/alex# VBoxManage --version
6.1.28r147628
```
- Vagrant
```bash
root@debian:/home/alex# vagrant --version
Vagrant 2.2.19
```
- Ansible
```bash
root@debian:/home/alex# ansible --version
ansible 2.10.8
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.9.2 (default, Feb 28 2021, 17:03:44) [GCC 10.2.1 20210110]
```

*Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.*

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

- Создать виртуальную машину.
- Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
```
docker ps
```
