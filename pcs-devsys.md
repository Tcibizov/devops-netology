# Курсовая работа по итогам модуля "DevOps и системное администрирование"

Курсовая работа необходима для проверки практических навыков, полученных в ходе прохождения курса "DevOps и системное администрирование".

Мы создадим и настроим виртуальное рабочее место. Позже вы сможете использовать эту систему для выполнения домашних заданий по курсу

## Задание

1. Создайте виртуальную машину Linux.
> Создаём новую виртуальную машину. Содержимое Vagrantfile:
```bash
Vagrant.configure("2") do |config|
    config.vm.hostname = "vagrant"
 	config.vm.box = "bento/ubuntu-20.04"
	config.vm.network "forwarded_port", guest: 80, host: 80
    config.vm.network "forwarded_port", guest: 443, host: 443
	config.vm.provider "virtualbox" do |v|
	  v.memory = 4096
	  v.cpus = 2
	end
 end
```

2. Установите ufw и разрешите к этой машине сессии на порты 22 и 443, при этом трафик на интерфейсе localhost (lo) должен ходить свободно на все порты.
> Ответ:
```bash
root@vagrant:~# sudo apt install ufw
Reading package lists... Done
Building dependency tree       
Reading state information... Done
ufw is already the newest version (0.36-6).
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
root@vagrant:~# sudo ufw allow 22
Rules updated
Rules updated (v6)
root@vagrant:~# sudo ufw allow 443
Rules updated
Rules updated (v6)
root@vagrant:~# sudo ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
Firewall is active and enabled on system startup
root@vagrant:~# sudo ufw status verbose
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22                         ALLOW IN    Anywhere                  
443                        ALLOW IN    Anywhere                  
22 (v6)                    ALLOW IN    Anywhere (v6)             
443 (v6)                   ALLOW IN    Anywhere (v6)             

root@vagrant:~# 
```

3. Установите hashicorp vault ([инструкция по ссылке](https://learn.hashicorp.com/tutorials/vault/getting-started-install?in=vault/getting-started#install-vault)).
> Ответ:
```bash
root@vagrant:~# curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add
OK
root@vagrant:~# sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
Hit:1 http://archive.ubuntu.com/ubuntu focal InRelease
Get:2 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]                                  
Get:3 http://archive.ubuntu.com/ubuntu focal-backports InRelease [108 kB]                                
Get:4 http://security.ubuntu.com/ubuntu focal-security InRelease [114 kB]                                
Get:5 https://apt.releases.hashicorp.com focal InRelease [9,495 B]                                       
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main i386 Packages [602 kB]
Get:7 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 Packages [1,572 kB]                                      
Get:8 http://archive.ubuntu.com/ubuntu focal-updates/main Translation-en [302 kB]                                        
Get:9 http://archive.ubuntu.com/ubuntu focal-updates/restricted i386 Packages [23.1 kB]                                  
Get:10 http://archive.ubuntu.com/ubuntu focal-updates/restricted amd64 Packages [801 kB]                                 
Get:11 http://archive.ubuntu.com/ubuntu focal-updates/restricted Translation-en [114 kB]                                 
Get:12 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 Packages [902 kB]                                   
Get:13 http://archive.ubuntu.com/ubuntu focal-updates/universe i386 Packages [666 kB]                                    
Get:14 http://archive.ubuntu.com/ubuntu focal-updates/universe Translation-en [200 kB]                                   
Get:15 http://archive.ubuntu.com/ubuntu focal-updates/multiverse amd64 Packages [23.7 kB]                                
Get:16 http://archive.ubuntu.com/ubuntu focal-updates/multiverse i386 Packages [8,432 B]                                 
Get:17 http://archive.ubuntu.com/ubuntu focal-updates/multiverse Translation-en [7,312 B]                                
Get:18 http://archive.ubuntu.com/ubuntu focal-backports/main amd64 Packages [42.0 kB]                                    
Get:19 http://archive.ubuntu.com/ubuntu focal-backports/main i386 Packages [34.5 kB]                                     
Get:20 http://archive.ubuntu.com/ubuntu focal-backports/main Translation-en [10.0 kB]                                    
Get:21 http://archive.ubuntu.com/ubuntu focal-backports/universe amd64 Packages [21.6 kB]                                
Get:22 http://archive.ubuntu.com/ubuntu focal-backports/universe i386 Packages [11.7 kB]                                 
Get:23 http://archive.ubuntu.com/ubuntu focal-backports/universe Translation-en [15.0 kB]                                
Get:24 https://apt.releases.hashicorp.com focal/main amd64 Packages [48.0 kB]                                            
Get:25 http://security.ubuntu.com/ubuntu focal-security/main i386 Packages [376 kB]                                      
Get:26 http://security.ubuntu.com/ubuntu focal-security/main amd64 Packages [1,238 kB]                                   
Get:27 http://security.ubuntu.com/ubuntu focal-security/main Translation-en [217 kB]                                     
Get:28 http://security.ubuntu.com/ubuntu focal-security/restricted i386 Packages [21.7 kB]                               
Get:29 http://security.ubuntu.com/ubuntu focal-security/restricted amd64 Packages [748 kB]                               
Get:30 http://security.ubuntu.com/ubuntu focal-security/restricted Translation-en [107 kB]                               
Get:31 http://security.ubuntu.com/ubuntu focal-security/universe i386 Packages [532 kB]                                  
Get:32 http://security.ubuntu.com/ubuntu focal-security/universe amd64 Packages [676 kB]                                 
Get:33 http://security.ubuntu.com/ubuntu focal-security/universe Translation-en [115 kB]                                 
Get:34 http://security.ubuntu.com/ubuntu focal-security/multiverse i386 Packages [7,180 B]                               
Get:35 http://security.ubuntu.com/ubuntu focal-security/multiverse amd64 Packages [20.7 kB]                              
Get:36 http://security.ubuntu.com/ubuntu focal-security/multiverse Translation-en [5,196 B]                              
Fetched 9,816 kB in 17s (587 kB/s)                                                                                       
Reading package lists... Done
root@vagrant:~# sudo apt-get update && sudo apt-get install vault
Hit:1 http://archive.ubuntu.com/ubuntu focal InRelease
Hit:2 http://archive.ubuntu.com/ubuntu focal-updates InRelease                      
Hit:3 http://archive.ubuntu.com/ubuntu focal-backports InRelease                    
Hit:4 http://security.ubuntu.com/ubuntu focal-security InRelease                    
Hit:5 https://apt.releases.hashicorp.com focal InRelease                            
Reading package lists... Done                                
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  vault
0 upgraded, 1 newly installed, 0 to remove and 125 not upgraded.
Need to get 69.4 MB of archives.
After this operation, 188 MB of additional disk space will be used.
Get:1 https://apt.releases.hashicorp.com focal/main amd64 vault amd64 1.9.3 [69.4 MB]
Fetched 69.4 MB in 9s (7,749 kB/s)                                                                                       
Selecting previously unselected package vault.
(Reading database ... 41552 files and directories currently installed.)
Preparing to unpack .../archives/vault_1.9.3_amd64.deb ...
Unpacking vault (1.9.3) ...
Setting up vault (1.9.3) ...
Generating Vault TLS key and self-signed certificate...
Generating a RSA private key
...............................++++
..............++++
writing new private key to 'tls.key'
-----
Vault TLS key and self-signed certificate have been generated in '/opt/vault/tls'.
root@vagrant:~#
```

4. Cоздайте центр сертификации по инструкции ([ссылка](https://learn.hashicorp.com/tutorials/vault/pki-engine?in=vault/secrets-management)) и выпустите сертификат для использования его в настройке веб-сервера nginx (срок жизни сертификата - месяц).
6. Установите корневой сертификат созданного центра сертификации в доверенные в хостовой системе.
7. Установите nginx.
8. По инструкции ([ссылка](https://nginx.org/en/docs/http/configuring_https_servers.html)) настройте nginx на https, используя ранее подготовленный сертификат:
  - можно использовать стандартную стартовую страницу nginx для демонстрации работы сервера;
  - можно использовать и другой html файл, сделанный вами;
9. Откройте в браузере на хосте https адрес страницы, которую обслуживает сервер nginx.
10. Создайте скрипт, который будет генерировать новый сертификат в vault:
  - генерируем новый сертификат так, чтобы не переписывать конфиг nginx;
  - перезапускаем nginx для применения нового сертификата.
11. Поместите скрипт в crontab, чтобы сертификат обновлялся какого-то числа каждого месяца в удобное для вас время.

## Результат

Результатом курсовой работы должны быть снимки экрана или текст:

- Процесс установки и настройки ufw
- Процесс установки и выпуска сертификата с помощью hashicorp vault
- Процесс установки и настройки сервера nginx
- Страница сервера nginx в браузере хоста не содержит предупреждений 
- Скрипт генерации нового сертификата работает (сертификат сервера ngnix должен быть "зеленым")
- Crontab работает (выберите число и время так, чтобы показать что crontab запускается и делает что надо)

## Как сдавать курсовую работу

Курсовую работу выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Также вы можете выполнить задание в [Google Docs](https://docs.google.com/document/u/0/?tgif=d) и отправить в личном кабинете на проверку ссылку на ваш документ.
Если необходимо прикрепить дополнительные ссылки, просто добавьте их в свой Google Docs.

Перед тем как выслать ссылку, убедитесь, что ее содержимое не является приватным (открыто на комментирование всем, у кого есть ссылка), иначе преподаватель не сможет проверить работу. 
Ссылка на инструкцию [Как предоставить доступ к файлам и папкам на Google Диске](https://support.google.com/docs/answer/2494822?hl=ru&co=GENIE.Platform%3DDesktop).
