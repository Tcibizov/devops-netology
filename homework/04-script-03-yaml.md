### Как сдавать задания

Вы уже изучили блок «Системы управления версиями», и начиная с этого занятия все ваши работы будут приниматься ссылками на .md-файлы, размещённые в вашем публичном репозитории.

Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-03-yaml/README.md). Заполните недостающие части документа решением задач (заменяйте `???`, ОСТАЛЬНОЕ В ШАБЛОНЕ НЕ ТРОГАЙТЕ чтобы не сломать форматирование текста, подсветку синтаксиса и прочее, иначе можно отправиться на доработку) и отправляйте на проверку. Вместо логов можно вставить скриншоты по желани.

# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import json
import socket
import time
import yaml

dns_names = {'drive.google.com': '', 'mail.google.com': '', 'google.com': ''}

while True:

    print('---------------')

    services = {'services': []}

    for dns_name, old_ip in dns_names.items():
        time.sleep(1)
        new_ip = socket.gethostbyname(dns_name)
        print('http://' + dns_name + ' - ' + new_ip)
        dns_names[dns_name] = new_ip

        if len(old_ip) == 0:
            continue
        elif old_ip != new_ip:
            print('[ERROR] http://' + dns_name + ' IP mismatch: ' + old_ip + ' ' + new_ip)

        services['services'].append({dns_name: new_ip})

    with open('dns_names.json', 'w') as jsfile:
        json.dump(services, jsfile)

    with open('dns_names.yml', 'w') as ymlfile:
        yaml.dump(services, ymlfile)
```

### Вывод скрипта при запуске при тестировании:
```
alex@debian:~/python$ ./script
---------------
http://drive.google.com - 209.85.233.194
http://mail.google.com - 142.250.150.19
http://google.com - 64.233.162.138
---------------
http://drive.google.com - 209.85.233.194
http://mail.google.com - 142.250.150.18
[ERROR] http://mail.google.com IP mismatch: 142.250.150.19 142.250.150.18
http://google.com - 64.233.162.101
[ERROR] http://google.com IP mismatch: 64.233.162.138 64.233.162.101
---------------
http://drive.google.com - 209.85.233.194
http://mail.google.com - 142.250.150.83
[ERROR] http://mail.google.com IP mismatch: 142.250.150.18 142.250.150.83
http://google.com - 64.233.162.102
[ERROR] http://google.com IP mismatch: 64.233.162.101 64.233.162.102
---------------
http://drive.google.com - 209.85.233.194
http://mail.google.com - 142.250.150.17
[ERROR] http://mail.google.com IP mismatch: 142.250.150.83 142.250.150.17
http://google.com - 64.233.162.139
[ERROR] http://google.com IP mismatch: 64.233.162.102 64.233.162.139
---------------
http://drive.google.com - 209.85.233.194
http://mail.google.com - 142.250.150.19
[ERROR] http://mail.google.com IP mismatch: 142.250.150.17 142.250.150.19
http://google.com - 64.233.162.100
[ERROR] http://google.com IP mismatch: 64.233.162.139 64.233.162.100
---------------
http://drive.google.com - 209.85.233.194
http://mail.google.com - 142.250.150.18
[ERROR] http://mail.google.com IP mismatch: 142.250.150.19 142.250.150.18
http://google.com - 173.194.222.139
[ERROR] http://google.com IP mismatch: 64.233.162.100 173.194.222.139
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
{"services": [{"drive.google.com": "209.85.233.194"}, {"mail.google.com": "142.250.150.19"}, {"google.com": "173.194.222.102"}]}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
services:
- drive.google.com: 209.85.233.194
- mail.google.com: 142.250.150.19
- google.com: 173.194.222.102
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

### Ваш скрипт:
```python
???
```

### Пример работы скрипта:
???
