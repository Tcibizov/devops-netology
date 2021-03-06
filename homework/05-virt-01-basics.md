
# Домашнее задание к занятию "5.1. Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения."


## Как сдавать задания

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.

Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Любые вопросы по решению задач задавайте в чате учебной группы.

---

## Задача 1

Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.
> Полная виртуализация: на сервер устанавливается только гипервизор, гостевые ОС полностью изолированы и не подвергаются модификации со стороны гипервизора.
> Паравиртуализация: гипервизор устанавливается поверх ОС и в своей работе использует ее для доступа к аппаратным ресурсам, при этом гипервизор модифицирует ядро гостевой ОС.
> Виртуализация на основе ОС: виртуализация обеспечивается за счет ядра ОС.

## Задача 2
Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования.

Организация серверов:
- физические сервера,
- паравиртуализация,
- виртуализация уровня ОС.

Условия использования:
- Высоконагруженная база данных, чувствительная к отказу.
> Выделенный физический сервер, так как дополнительный уровень абстракции может вносить лишнюю задержку или риск сбоя. В данном случае лучше отдать все ресурсы для БД.
- Различные web-приложения.
> Виртуализация уровня ОС из-за оптимального распределения ресурсов.
- Windows системы для использования бухгалтерским отделом.
> Физические сервера либо паравиртуализация. Виртуализация уровня ОС работать не будет, так как нет поддержки со стороны ядра Windows
- Системы, выполняющие высокопроизводительные расчеты на GPU.
> Паравиртуализация, например, для проброса GPU вычислений из Windows в Linux или наоборот.
Опишите, почему вы выбрали к каждому целевому использованию такую организацию.

## Задача 3

Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

Сценарии:

1. 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
> Наиболее подходящая система в данном случае - это коммерческая система виртуализации HyperV, так как используется преимущественно Windows based инфраструктура. Может ещё  VMWare, но в HyperV порог входа ниже.
2. Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
> KVM или Xen. Если инфраструктура небольшая и требуется максимальная производительность, то выбор ложится в сторону KVM, так оно наиболее производительное решение.
3. Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.
> KVM либо Xen. Если планируется, что инфраструктура будет сильно расширяться, то лучше выбрать Xen как более надежное решение.
4. Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.
> Вариант установить бесплатный KVM, который будет работать в режиме паравиртуализации.

## Задача 4

Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.
> При виртуализации или паравиртуализации, то использование нескольких систем управления виртуализацией приведет к тому, что не получится настроить между ними полноценную миграцию виртуальных машин в случае сбоя одной из систем. Однако виртуализация уровня ОС может без всяких проблем сосуществовать с полной виртуализацией/паравиртуализацией, например, можно установить Docker на виртуальную машину VmWare/HyperV.
