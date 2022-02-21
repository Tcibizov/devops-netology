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
vagrant@vagrant:~# sudo apt install ufw
Reading package lists... Done
Building dependency tree       
Reading state information... Done
ufw is already the newest version (0.36-6).
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
vagrant@vagrant:~# sudo ufw allow 22
Rules updated
Rules updated (v6)
vagrant@vagrant:~# sudo ufw allow 443
Rules updated
Rules updated (v6)
vagrant@vagrant:~# sudo ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
Firewall is active and enabled on system startup
vagrant@vagrant:~# sudo ufw status verbose
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
```

3. Установите hashicorp vault ([инструкция по ссылке](https://learn.hashicorp.com/tutorials/vault/getting-started-install?in=vault/getting-started#install-vault)).
> Ответ:
```bash
vagrant@vagrant:~# curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add
OK
vagrant@vagrant:~# sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
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
vagrant@vagrant:~# sudo apt-get update && sudo apt-get install vault
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
```
4. Cоздайте центр сертификации по инструкции ([ссылка](https://learn.hashicorp.com/tutorials/vault/pki-engine?in=vault/secrets-management)) и выпустите сертификат для использования его в настройке веб-сервера nginx (срок жизни сертификата - месяц).
> Ответ: Запускаем в новом терминале.
```bash
vagrant@vagrant:~$ vault server -dev -dev-root-token-id root
==> Vault server configuration:

             Api Address: http://127.0.0.1:8200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8201
              Go Version: go1.17.5
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
           Recovery Mode: false
                 Storage: inmem
                 Version: Vault v1.9.3
             Version Sha: 7dbdd57243a0d8d9d9e07cd01eb657369f8e1b8a

==> Vault server started! Log data will stream in below:

2022-02-14T09:26:22.418Z [INFO]  proxy environment: http_proxy="\"\"" https_proxy="\"\"" no_proxy="\"\""
2022-02-14T09:26:22.424Z [WARN]  no `api_addr` value specified in config or in VAULT_API_ADDR; falling back to detection if possible, but this value should be manually set
2022-02-14T09:26:22.433Z [INFO]  core: Initializing VersionTimestamps for core
2022-02-14T09:26:22.439Z [INFO]  core: security barrier not initialized
2022-02-14T09:26:22.440Z [INFO]  core: security barrier initialized: stored=1 shares=1 threshold=1
2022-02-14T09:26:22.454Z [INFO]  core: post-unseal setup starting
2022-02-14T09:26:22.459Z [INFO]  core: loaded wrapping token key
2022-02-14T09:26:22.460Z [INFO]  core: Recorded vault version: vault version=1.9.3 upgrade time="2022-02-14 09:26:22.459730278 +0000 UTC m=+1.135778697"
2022-02-14T09:26:22.462Z [INFO]  core: successfully setup plugin catalog: plugin-directory="\"\""
2022-02-14T09:26:22.463Z [INFO]  core: no mounts; adding default mount table
2022-02-14T09:26:22.572Z [INFO]  core: successfully mounted backend: type=cubbyhole path=cubbyhole/
2022-02-14T09:26:22.574Z [INFO]  core: successfully mounted backend: type=system path=sys/
2022-02-14T09:26:22.578Z [INFO]  core: successfully mounted backend: type=identity path=identity/
2022-02-14T09:26:22.638Z [INFO]  core: successfully enabled credential backend: type=token path=token/
2022-02-14T09:26:22.639Z [INFO]  rollback: starting rollback manager
2022-02-14T09:26:22.640Z [INFO]  core: restoring leases
2022-02-14T09:26:22.645Z [INFO]  expiration: lease restore complete
2022-02-14T09:26:22.671Z [INFO]  identity: entities restored
2022-02-14T09:26:22.671Z [INFO]  identity: groups restored
2022-02-14T09:26:22.671Z [INFO]  core: post-unseal setup complete
2022-02-14T09:26:22.675Z [INFO]  core: root token generated
2022-02-14T09:26:22.675Z [INFO]  core: pre-seal teardown starting
2022-02-14T09:26:22.676Z [INFO]  rollback: stopping rollback manager
2022-02-14T09:26:22.676Z [INFO]  core: pre-seal teardown complete
2022-02-14T09:26:22.678Z [INFO]  core.cluster-listener.tcp: starting listener: listener_address=127.0.0.1:8201
2022-02-14T09:26:22.678Z [INFO]  core.cluster-listener: serving cluster requests: cluster_listen_address=127.0.0.1:8201
2022-02-14T09:26:22.679Z [INFO]  core: post-unseal setup starting
2022-02-14T09:26:22.679Z [INFO]  core: loaded wrapping token key
2022-02-14T09:26:22.679Z [INFO]  core: successfully setup plugin catalog: plugin-directory="\"\""
2022-02-14T09:26:22.687Z [INFO]  core: successfully mounted backend: type=system path=sys/
2022-02-14T09:26:22.691Z [INFO]  core: successfully mounted backend: type=identity path=identity/
2022-02-14T09:26:22.691Z [INFO]  core: successfully mounted backend: type=cubbyhole path=cubbyhole/
2022-02-14T09:26:22.706Z [INFO]  core: successfully enabled credential backend: type=token path=token/
2022-02-14T09:26:22.708Z [INFO]  rollback: starting rollback manager
2022-02-14T09:26:22.710Z [INFO]  core: restoring leases
2022-02-14T09:26:22.712Z [INFO]  expiration: lease restore complete
2022-02-14T09:26:22.716Z [INFO]  identity: entities restored
2022-02-14T09:26:22.716Z [INFO]  identity: groups restored
2022-02-14T09:26:22.716Z [INFO]  core: post-unseal setup complete
2022-02-14T09:26:22.716Z [INFO]  core: vault is unsealed
2022-02-14T09:26:22.728Z [INFO]  expiration: revoked lease: lease_id=auth/token/root/h79f798c2a532a590d7c82b4b8acc223c14d2f68a0886e85cbdfedd11c8f30655
2022-02-14T09:26:22.769Z [INFO]  core: successful mount: namespace="\"\"" path=secret/ type=kv
2022-02-14T09:26:22.772Z [INFO]  secrets.kv.kv_3de9e3fe: collecting keys to upgrade
2022-02-14T09:26:22.772Z [INFO]  secrets.kv.kv_3de9e3fe: done collecting keys: num_keys=1
2022-02-14T09:26:22.772Z [INFO]  secrets.kv.kv_3de9e3fe: upgrading keys finished
WARNING! dev mode is enabled! In this mode, Vault runs entirely in-memory
and starts unsealed with a single unseal key. The root token is already
authenticated to the CLI, so you can immediately begin using Vault.

You may need to set the following environment variable:

    $ export VAULT_ADDR='http://127.0.0.1:8200'

The unseal key and root token are displayed below in case you want to
seal/unseal the Vault or re-authenticate.

Unseal Key: Wbp6oA4hrDgxT3dPDkdvusd3BrD6LQqTkz9kTl/Mmg4=
Root Token: root

Development mode should NOT be used in production installations!
```
> Устанавливаем JSON:
```bash
vagrant@vagrant:~$ sudo apt-get install jq
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  libjq1 libonig5
The following NEW packages will be installed:
  jq libjq1 libonig5
0 upgraded, 3 newly installed, 0 to remove and 125 not upgraded.
Need to get 313 kB of archives.
After this operation, 1,062 kB of additional disk space will be used.
Do you want to continue? [Y/n] Y
Get:1 http://archive.ubuntu.com/ubuntu focal/universe amd64 libonig5 amd64 6.9.4-1 [142 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 libjq1 amd64 1.6-1ubuntu0.20.04.1 [121 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 jq amd64 1.6-1ubuntu0.20.04.1 [50.2 kB]
Fetched 313 kB in 0s (694 kB/s)  
Selecting previously unselected package libonig5:amd64.
(Reading database ... 41558 files and directories currently installed.)
Preparing to unpack .../libonig5_6.9.4-1_amd64.deb ...
Unpacking libonig5:amd64 (6.9.4-1) ...
Selecting previously unselected package libjq1:amd64.
Preparing to unpack .../libjq1_1.6-1ubuntu0.20.04.1_amd64.deb ...
Unpacking libjq1:amd64 (1.6-1ubuntu0.20.04.1) ...
Selecting previously unselected package jq.
Preparing to unpack .../jq_1.6-1ubuntu0.20.04.1_amd64.deb ...
Unpacking jq (1.6-1ubuntu0.20.04.1) ...
Setting up libonig5:amd64 (6.9.4-1) ...
Setting up libjq1:amd64 (1.6-1ubuntu0.20.04.1) ...
Setting up jq (1.6-1ubuntu0.20.04.1) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
```
> Делаем экспорт переменной среды для vault CLI для адресации к серверу Vault и переменной среды для CLI хранилища для аутентификации на сервере Vault.
```bash
vagrant@vagrant:~# export VAULT_ADDR=http://127.0.0.1:8200
vagrant@vagrant:~# export VAULT_TOKEN=root
```
> Настроим механизм секретов pki с временем жизни раз в месяц (720 часов)
```bash
vagrant@vagrant:~# vault secrets enable pki
Success! Enabled the pki secrets engine at: pki/
vagrant@vagrant:~# vault secrets tune -max-lease-ttl=720h pki
Success! Tuned the secrets engine at: pki/
```
> Генерируем корневой сертификат:
```bash
vagrant@vagrant:~$ vault write -field=certificate pki/root/generate/internal \
> common_name="example.com" \
> ttl=720h > CA_cert.crt
vagrant@vagrant:~$ cat CA_cert.crt
-----BEGIN CERTIFICATE-----
MIIDNTCCAh2gAwIBAgIUWeQyiB/Wo0EnT8S+7hBnP/G26HowDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMjIxMDkxNjE0WhcNMjIw
MzIzMDkxNjQzWjAWMRQwEgYDVQQDEwtleGFtcGxlLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBANscV5p5eWIEn7MQgjnpx57JzAw7sxR0mpKUpvO2
yXr8cc73+M6rfBdb5HhSYsKO4L+gdSyrd5i82KPP7om/NVc1k1RecY82Gaxnr/jq
QZOC/xccV4itvCxMQt23vdiw9U5ej1R2X6ZrMU285utcEQV3/XoE3a05MhgJl1PT
gyPQ56lWnko+TEQo/79gXXiYbnqp0XXW0Ika4UAEi1g+vI9N7/HcU6B9BcN3LIuf
gLHym6g8lH8WZeCG9tTekNmyjmJpzAgzPAl+k4tQITtlJrF7IQAy77s0572W7hfB
mZv1PCmalwT4a3voJBbG1I7YrIAx07h0YCiPoQWzxasLhx0CAwEAAaN7MHkwDgYD
VR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFI5y/aWRWmQz
GcUa+LdC48CFRq47MB8GA1UdIwQYMBaAFI5y/aWRWmQzGcUa+LdC48CFRq47MBYG
A1UdEQQPMA2CC2V4YW1wbGUuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQB/UcGEe3JX
7Zcidn445UUV+isbS+YjHucQR76p/rD8VvW73faNKDL5YPS9l7Yty+zeMsgSrCoj
yXWPGVNIxWPJZo8UrfaOVT2x7DsgbREHHVvIGE/UTtaUW95OaE/Y3AcyE4S9fnpj
FyQTW5YS7QfwTpBfdUj1MZWeOnrt26zMQ4SQJpncph0QkHtQCTxLEk9lFjYjmjvC
IZ2D6mMfY5TIlWdwlM7OtLkDDaI5DcVbZfKBX9609KJUrtyhoc1W8dHaziBokZE7
0ORg4f0qs5gQ+TnhNzH0+HMzG9Mv+xZ83HIi0V/QQmdUThnzVUI/3Uza7dDvtTBM
bUbYO/x74wLK
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIDNTCCAh2gAwIBAgIUWeQyiB/Wo0EnT8S+7hBnP/G26HowDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMjIxMDkxNjE0WhcNMjIw
MzIzMDkxNjQzWjAWMRQwEgYDVQQDEwtleGFtcGxlLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBANscV5p5eWIEn7MQgjnpx57JzAw7sxR0mpKUpvO2
yXr8cc73+M6rfBdb5HhSYsKO4L+gdSyrd5i82KPP7om/NVc1k1RecY82Gaxnr/jq
QZOC/xccV4itvCxMQt23vdiw9U5ej1R2X6ZrMU285utcEQV3/XoE3a05MhgJl1PT
gyPQ56lWnko+TEQo/79gXXiYbnqp0XXW0Ika4UAEi1g+vI9N7/HcU6B9BcN3LIuf
gLHym6g8lH8WZeCG9tTekNmyjmJpzAgzPAl+k4tQITtlJrF7IQAy77s0572W7hfB
mZv1PCmalwT4a3voJBbG1I7YrIAx07h0YCiPoQWzxasLhx0CAwEAAaN7MHkwDgYD
VR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFI5y/aWRWmQz
GcUa+LdC48CFRq47MB8GA1UdIwQYMBaAFI5y/aWRWmQzGcUa+LdC48CFRq47MBYG
A1UdEQQPMA2CC2V4YW1wbGUuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQB/UcGEe3JX
7Zcidn445UUV+isbS+YjHucQR76p/rD8VvW73faNKDL5YPS9l7Yty+zeMsgSrCoj
yXWPGVNIxWPJZo8UrfaOVT2x7DsgbREHHVvIGE/UTtaUW95OaE/Y3AcyE4S9fnpj
FyQTW5YS7QfwTpBfdUj1MZWeOnrt26zMQ4SQJpncph0QkHtQCTxLEk9lFjYjmjvC
IZ2D6mMfY5TIlWdwlM7OtLkDDaI5DcVbZfKBX9609KJUrtyhoc1W8dHaziBokZE7
0ORg4f0qs5gQ+TnhNzH0+HMzG9Mv+xZ83HIi0V/QQmdUThnzVUI/3Uza7dDvtTBM
bUbYO/x74wLK
-----END CERTIFICATE-----
```
> Конфигурируем CA и CRL ссылки(URLs):
```bash
vagrant@vagrant:~$ vault write pki/config/urls \
> issuing_certificates="$VAULT_ADDR/v1/pki/ca" \
> crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
Success! Data written to: pki/config/urls
```
> Создадим роль:
```bash
vagrant@vagrant:~$ vault write pki/roles/example-dot-com \
> allowed_domains="example.com" \
> allow_subdomains=true \
> allow_bare_domains=true \
> max_ttl="720h"
Success! Data written to: pki/roles/example-dot-com
```
> Выпускаем сертификаты для сервера:
```bash
vagrant@vagrant:~$ vault write pki/root/generate/internal \
> common_name=example.com \
>  ttl=720h
Key              Value
---              -----
certificate      -----BEGIN CERTIFICATE-----
MIIDNTCCAh2gAwIBAgIUWeQyiB/Wo0EnT8S+7hBnP/G26HowDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMjIxMDkxNjE0WhcNMjIw
MzIzMDkxNjQzWjAWMRQwEgYDVQQDEwtleGFtcGxlLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBANscV5p5eWIEn7MQgjnpx57JzAw7sxR0mpKUpvO2
yXr8cc73+M6rfBdb5HhSYsKO4L+gdSyrd5i82KPP7om/NVc1k1RecY82Gaxnr/jq
QZOC/xccV4itvCxMQt23vdiw9U5ej1R2X6ZrMU285utcEQV3/XoE3a05MhgJl1PT
gyPQ56lWnko+TEQo/79gXXiYbnqp0XXW0Ika4UAEi1g+vI9N7/HcU6B9BcN3LIuf
gLHym6g8lH8WZeCG9tTekNmyjmJpzAgzPAl+k4tQITtlJrF7IQAy77s0572W7hfB
mZv1PCmalwT4a3voJBbG1I7YrIAx07h0YCiPoQWzxasLhx0CAwEAAaN7MHkwDgYD
VR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFI5y/aWRWmQz
GcUa+LdC48CFRq47MB8GA1UdIwQYMBaAFI5y/aWRWmQzGcUa+LdC48CFRq47MBYG
A1UdEQQPMA2CC2V4YW1wbGUuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQB/UcGEe3JX
7Zcidn445UUV+isbS+YjHucQR76p/rD8VvW73faNKDL5YPS9l7Yty+zeMsgSrCoj
yXWPGVNIxWPJZo8UrfaOVT2x7DsgbREHHVvIGE/UTtaUW95OaE/Y3AcyE4S9fnpj
FyQTW5YS7QfwTpBfdUj1MZWeOnrt26zMQ4SQJpncph0QkHtQCTxLEk9lFjYjmjvC
IZ2D6mMfY5TIlWdwlM7OtLkDDaI5DcVbZfKBX9609KJUrtyhoc1W8dHaziBokZE7
0ORg4f0qs5gQ+TnhNzH0+HMzG9Mv+xZ83HIi0V/QQmdUThnzVUI/3Uza7dDvtTBM
bUbYO/x74wLK
-----END CERTIFICATE-----
expiration       1648027003
issuing_ca       -----BEGIN CERTIFICATE-----
MIIDNTCCAh2gAwIBAgIUWeQyiB/Wo0EnT8S+7hBnP/G26HowDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMjIxMDkxNjE0WhcNMjIw
MzIzMDkxNjQzWjAWMRQwEgYDVQQDEwtleGFtcGxlLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBANscV5p5eWIEn7MQgjnpx57JzAw7sxR0mpKUpvO2
yXr8cc73+M6rfBdb5HhSYsKO4L+gdSyrd5i82KPP7om/NVc1k1RecY82Gaxnr/jq
QZOC/xccV4itvCxMQt23vdiw9U5ej1R2X6ZrMU285utcEQV3/XoE3a05MhgJl1PT
gyPQ56lWnko+TEQo/79gXXiYbnqp0XXW0Ika4UAEi1g+vI9N7/HcU6B9BcN3LIuf
gLHym6g8lH8WZeCG9tTekNmyjmJpzAgzPAl+k4tQITtlJrF7IQAy77s0572W7hfB
mZv1PCmalwT4a3voJBbG1I7YrIAx07h0YCiPoQWzxasLhx0CAwEAAaN7MHkwDgYD
VR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFI5y/aWRWmQz
GcUa+LdC48CFRq47MB8GA1UdIwQYMBaAFI5y/aWRWmQzGcUa+LdC48CFRq47MBYG
A1UdEQQPMA2CC2V4YW1wbGUuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQB/UcGEe3JX
7Zcidn445UUV+isbS+YjHucQR76p/rD8VvW73faNKDL5YPS9l7Yty+zeMsgSrCoj
yXWPGVNIxWPJZo8UrfaOVT2x7DsgbREHHVvIGE/UTtaUW95OaE/Y3AcyE4S9fnpj
FyQTW5YS7QfwTpBfdUj1MZWeOnrt26zMQ4SQJpncph0QkHtQCTxLEk9lFjYjmjvC
IZ2D6mMfY5TIlWdwlM7OtLkDDaI5DcVbZfKBX9609KJUrtyhoc1W8dHaziBokZE7
0ORg4f0qs5gQ+TnhNzH0+HMzG9Mv+xZ83HIi0V/QQmdUThnzVUI/3Uza7dDvtTBM
bUbYO/x74wLK
-----END CERTIFICATE-----
serial_number    59:e4:32:88:1f:d6:a3:41:27:4f:c4:be:ee:10:67:3f:f1:b6:e8:7a
```

5. Установите корневой сертификат созданного центра сертификации в доверенные в хостовой системе.
> Ответ:
> ![gcr-viewer](CA_cert.png)
```bash
root@debian:/home/alex# cp ./CA_cert.crt /usr/local/share/ca-certificates/
root@debian:/home/alex# sudo update-ca-certificates
Updating certificates in /etc/ssl/certs...
0 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
done.
root@debian:/home/alex# awk -v cmd='openssl x509 -noout -subject' ' /BEGIN/{close(cmd)};{print | cmd}' < /etc/ssl/certs/ca-certificates.crt | grep -i example.com
subject=CN = example.com
```
6. Установите nginx.
> Ответ:
```bash
vagrant@vagrant:~$ sudo apt install nginx
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  fontconfig-config fonts-dejavu-core libfontconfig1 libgd3 libjbig0 libjpeg-turbo8 libjpeg8
  libnginx-mod-http-image-filter libnginx-mod-http-xslt-filter libnginx-mod-mail libnginx-mod-stream libtiff5
  libwebp6 libx11-6 libx11-data libxcb1 libxpm4 nginx-common nginx-core
Suggested packages:
  libgd-tools fcgiwrap nginx-doc ssl-cert
The following NEW packages will be installed:
  fontconfig-config fonts-dejavu-core libfontconfig1 libgd3 libjbig0 libjpeg-turbo8 libjpeg8
  libnginx-mod-http-image-filter libnginx-mod-http-xslt-filter libnginx-mod-mail libnginx-mod-stream libtiff5
  libwebp6 libx11-6 libx11-data libxcb1 libxpm4 nginx nginx-common nginx-core
0 upgraded, 20 newly installed, 0 to remove and 125 not upgraded.
Need to get 3,165 kB of archives.
After this operation, 11.1 MB of additional disk space will be used.
Do you want to continue? [Y/n] Y
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libxcb1 amd64 1.14-2 [44.7 kB]
Get:2 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libx11-data all 2:1.6.9-2ubuntu1.2 [113 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libx11-6 amd64 2:1.6.9-2ubuntu1.2 [575 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal/main amd64 fonts-dejavu-core all 2.37-1 [1,041 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 fontconfig-config all 2.13.1-2ubuntu3 [28.8 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal/main amd64 libfontconfig1 amd64 2.13.1-2ubuntu3 [114 kB]
Get:7 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libjpeg-turbo8 amd64 2.0.3-0ubuntu1.20.04.1 [117 kB]
Get:8 http://archive.ubuntu.com/ubuntu focal/main amd64 libjpeg8 amd64 8c-2ubuntu8 [2,194 B]
Get:9 http://archive.ubuntu.com/ubuntu focal/main amd64 libjbig0 amd64 2.1-3.1build1 [26.7 kB]
Get:10 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libwebp6 amd64 0.6.1-2ubuntu0.20.04.1 [185 kB]
Get:11 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libtiff5 amd64 4.1.0+git191117-2ubuntu0.20.04.2 [162 kB]
Get:12 http://archive.ubuntu.com/ubuntu focal/main amd64 libxpm4 amd64 1:3.5.12-1 [34.0 kB]
Get:13 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libgd3 amd64 2.2.5-5.2ubuntu2.1 [118 kB]
Get:14 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nginx-common all 1.18.0-0ubuntu1.2 [37.5 kB]
Get:15 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libnginx-mod-http-image-filter amd64 1.18.0-0ubuntu1.2 [14.4 kB]
Get:16 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libnginx-mod-http-xslt-filter amd64 1.18.0-0ubuntu1.2 [12.7 kB]
Get:17 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libnginx-mod-mail amd64 1.18.0-0ubuntu1.2 [42.5 kB]
Get:18 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 libnginx-mod-stream amd64 1.18.0-0ubuntu1.2 [67.3 kB]
Get:19 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nginx-core amd64 1.18.0-0ubuntu1.2 [425 kB]
Get:20 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nginx all 1.18.0-0ubuntu1.2 [3,620 B]
Fetched 3,165 kB in 1s (2,215 kB/s)  
Preconfiguring packages ...
Selecting previously unselected package libxcb1:amd64.
(Reading database ... 41575 files and directories currently installed.)
Preparing to unpack .../00-libxcb1_1.14-2_amd64.deb ...
Unpacking libxcb1:amd64 (1.14-2) ...
Selecting previously unselected package libx11-data.
Preparing to unpack .../01-libx11-data_2%3a1.6.9-2ubuntu1.2_all.deb ...
Unpacking libx11-data (2:1.6.9-2ubuntu1.2) ...
Selecting previously unselected package libx11-6:amd64.
Preparing to unpack .../02-libx11-6_2%3a1.6.9-2ubuntu1.2_amd64.deb ...
Unpacking libx11-6:amd64 (2:1.6.9-2ubuntu1.2) ...
Selecting previously unselected package fonts-dejavu-core.
Preparing to unpack .../03-fonts-dejavu-core_2.37-1_all.deb ...
Unpacking fonts-dejavu-core (2.37-1) ...
Selecting previously unselected package fontconfig-config.
Preparing to unpack .../04-fontconfig-config_2.13.1-2ubuntu3_all.deb ...
Unpacking fontconfig-config (2.13.1-2ubuntu3) ...
Selecting previously unselected package libfontconfig1:amd64.
Preparing to unpack .../05-libfontconfig1_2.13.1-2ubuntu3_amd64.deb ...
Unpacking libfontconfig1:amd64 (2.13.1-2ubuntu3) ...
Selecting previously unselected package libjpeg-turbo8:amd64.
Preparing to unpack .../06-libjpeg-turbo8_2.0.3-0ubuntu1.20.04.1_amd64.deb ...
Unpacking libjpeg-turbo8:amd64 (2.0.3-0ubuntu1.20.04.1) ...
Selecting previously unselected package libjpeg8:amd64.
Preparing to unpack .../07-libjpeg8_8c-2ubuntu8_amd64.deb ...
Unpacking libjpeg8:amd64 (8c-2ubuntu8) ...
Selecting previously unselected package libjbig0:amd64.
Preparing to unpack .../08-libjbig0_2.1-3.1build1_amd64.deb ...
Unpacking libjbig0:amd64 (2.1-3.1build1) ...
Selecting previously unselected package libwebp6:amd64.
Preparing to unpack .../09-libwebp6_0.6.1-2ubuntu0.20.04.1_amd64.deb ...
Unpacking libwebp6:amd64 (0.6.1-2ubuntu0.20.04.1) ...
Selecting previously unselected package libtiff5:amd64.
Preparing to unpack .../10-libtiff5_4.1.0+git191117-2ubuntu0.20.04.2_amd64.deb ...
Unpacking libtiff5:amd64 (4.1.0+git191117-2ubuntu0.20.04.2) ...
Selecting previously unselected package libxpm4:amd64.
Preparing to unpack .../11-libxpm4_1%3a3.5.12-1_amd64.deb ...
Unpacking libxpm4:amd64 (1:3.5.12-1) ...
Selecting previously unselected package libgd3:amd64.
Preparing to unpack .../12-libgd3_2.2.5-5.2ubuntu2.1_amd64.deb ...
Unpacking libgd3:amd64 (2.2.5-5.2ubuntu2.1) ...
Selecting previously unselected package nginx-common.
Preparing to unpack .../13-nginx-common_1.18.0-0ubuntu1.2_all.deb ...
Unpacking nginx-common (1.18.0-0ubuntu1.2) ...
Selecting previously unselected package libnginx-mod-http-image-filter.
Preparing to unpack .../14-libnginx-mod-http-image-filter_1.18.0-0ubuntu1.2_amd64.deb ...
Unpacking libnginx-mod-http-image-filter (1.18.0-0ubuntu1.2) ...
Selecting previously unselected package libnginx-mod-http-xslt-filter.
Preparing to unpack .../15-libnginx-mod-http-xslt-filter_1.18.0-0ubuntu1.2_amd64.deb ...
Unpacking libnginx-mod-http-xslt-filter (1.18.0-0ubuntu1.2) ...
Selecting previously unselected package libnginx-mod-mail.
Preparing to unpack .../16-libnginx-mod-mail_1.18.0-0ubuntu1.2_amd64.deb ...
Unpacking libnginx-mod-mail (1.18.0-0ubuntu1.2) ...
Selecting previously unselected package libnginx-mod-stream.
Preparing to unpack .../17-libnginx-mod-stream_1.18.0-0ubuntu1.2_amd64.deb ...
Unpacking libnginx-mod-stream (1.18.0-0ubuntu1.2) ...
Selecting previously unselected package nginx-core.
Preparing to unpack .../18-nginx-core_1.18.0-0ubuntu1.2_amd64.deb ...
Unpacking nginx-core (1.18.0-0ubuntu1.2) ...
Selecting previously unselected package nginx.
Preparing to unpack .../19-nginx_1.18.0-0ubuntu1.2_all.deb ...
Unpacking nginx (1.18.0-0ubuntu1.2) ...
Setting up libxcb1:amd64 (1.14-2) ...
Setting up nginx-common (1.18.0-0ubuntu1.2) ...
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /lib/systemd/system/nginx.service.
Setting up libjbig0:amd64 (2.1-3.1build1) ...
Setting up libnginx-mod-http-xslt-filter (1.18.0-0ubuntu1.2) ...
Setting up libx11-data (2:1.6.9-2ubuntu1.2) ...
Setting up libwebp6:amd64 (0.6.1-2ubuntu0.20.04.1) ...
Setting up fonts-dejavu-core (2.37-1) ...
Setting up libjpeg-turbo8:amd64 (2.0.3-0ubuntu1.20.04.1) ...
Setting up libx11-6:amd64 (2:1.6.9-2ubuntu1.2) ...
Setting up libjpeg8:amd64 (8c-2ubuntu8) ...
Setting up libnginx-mod-mail (1.18.0-0ubuntu1.2) ...
Setting up libxpm4:amd64 (1:3.5.12-1) ...
Setting up fontconfig-config (2.13.1-2ubuntu3) ...
Setting up libnginx-mod-stream (1.18.0-0ubuntu1.2) ...
Setting up libtiff5:amd64 (4.1.0+git191117-2ubuntu0.20.04.2) ...
Setting up libfontconfig1:amd64 (2.13.1-2ubuntu3) ...
Setting up libgd3:amd64 (2.2.5-5.2ubuntu2.1) ...
Setting up libnginx-mod-http-image-filter (1.18.0-0ubuntu1.2) ...
Setting up nginx-core (1.18.0-0ubuntu1.2) ...
Setting up nginx (1.18.0-0ubuntu1.2) ...
Processing triggers for ufw (0.36-6) ...
Processing triggers for systemd (245.4-4ubuntu3.11) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
vagrant@vagrant:~$ sudo ufw allow 'Nginx HTTP'
Rule added
Rule added (v6)
vagrant@vagrant:~$ sudo ufw allow 'Nginx HTTPS'
Rule added
Rule added (v6)
vagrant@vagrant:~$ systemctl status nginx
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2022-02-14 10:39:40 UTC; 58s ago
       Docs: man:nginx(8)
   Main PID: 14802 (nginx)
      Tasks: 3 (limit: 4617)
     Memory: 4.2M
     CGroup: /system.slice/nginx.service
             ├─14802 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
             ├─14803 nginx: worker process
             └─14804 nginx: worker process

Feb 14 10:39:39 vagrant systemd[1]: Starting A high performance web server and a reverse proxy server...
Feb 14 10:39:40 vagrant systemd[1]: Started A high performance web server and a reverse proxy server.
```
7. По инструкции ([ссылка](https://nginx.org/en/docs/http/configuring_https_servers.html)) настройте nginx на https, используя ранее подготовленный сертификат:
  - можно использовать стандартную стартовую страницу nginx для демонстрации работы сервера;
  - можно использовать и другой html файл, сделанный вами;
> Ответ: Сохраняем полученный сертификат и закрытый ключ.
```bash
root@vagrant:/etc/ssl# cat test.example.com.crt
 -----BEGIN CERTIFICATE-----
MIIDvzCCAqegAwIBAgIUbpcOUBAbzNYd6iuQ14xAkEiIvwYwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMjE3MDY1NzMwWhcNMjIw
MjE3MDcwOTU5WjAbMRkwFwYDVQQDExB0ZXN0LmV4YW1wbGUuY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3MoNWyEttBznzUFjjbyVNUdBIxAGgNOK
cJY1xfGfv+rW5DJ8ieExXimofBAqA4HIlal9Zj6RRY5K3V0nGsKQ/LbyDFqCKaD0
LTpN7uJ76fTkHfkF4Q00ez7NQQk3vhqq/uMIyxD5MFKfSr9agdx2GuYtjeH7yUKY
p+vfGcf1/4z/pspGBTPmxwQWHllpfDYOXA5nT9p9Uq0dgNWtVixvqhT8vGB86kj9
MXXY9ztJrIQQHmVvjQd851jus3r52I2Ox/Vs+YLNI4uVlvExP9DVCndqW91p6ZF4
HrOFVGIVQubrj+VNmJu6aLojBj2InaNZdg0dDVd0B3UBhxHYUErMJwIDAQABo4H/
MIH8MA4GA1UdDwEB/wQEAwIDqDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUH
AwIwHQYDVR0OBBYEFB30wOaI+aMadCz1gNsxNwVUB/8UMB8GA1UdIwQYMBaAFG3q
qgJeCib01cFdagbFb44rwnCkMDsGCCsGAQUFBwEBBC8wLTArBggrBgEFBQcwAoYf
aHR0cDovLzEyNy4wLjAuMTo4MjAwL3YxL3BraS9jYTAbBgNVHREEFDASghB0ZXN0
LmV4YW1wbGUuY29tMDEGA1UdHwQqMCgwJqAkoCKGIGh0dHA6Ly8xMjcuMC4wLjE6
ODIwMC92MS9wa2kvY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCDgiiX8pMxCW2wXFSG
bOGzGRfkN7e6SITLb2AqmH5E4hC5PKtXPyYYp5/KkeQqJdyUy3Q2xY/yvSAXvBZw
c4dEE/+J1wBTsH9E9TNb4/xgOtWBkY6etwvxCRRpdO3QPvAtRlL1SI60tSVcmnoM
603+RIFFOaybCUoVMQBhp+N2QaPfgIkaFjAz28BlLcFRaDfy5IIH6IODYe/IRxnU
A+SyJOAJZU3rsHbh1oD5fbM6yRlEM21QprOYM2V9uU/KLKDSXk9lSrIkTmuRH/vq
3RFTp5sWqmGw/1MwABBE0Pjx3FmaDy8X8L6DrZMtGxV6+iwFJEkTQsaz445PVEGj
12X3
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIDNTCCAh2gAwIBAgIUR7DdWL9bh984/x2OuVfUgCbP7/EwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMjE3MDY1MzQxWhcNMjIw
MzE5MDY1NDExWjAWMRQwEgYDVQQDEwtleGFtcGxlLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAOWv20qoo1OxQvzpopopnknraeE966kW4acY8ezs
I0YljjDpyq1Co//c6NZR5jR5AkLdBQpMTdKz0M5dKr3AIEh3Ktvfril/rMLHxVLw
HHhUwz9ROOpmXtY1wtmK8T2/9Ag6vs4VKnw5sEpRscJYlBAjFuIElWcGQ7fY8sXk
dmX1IB0yQg28tzNUrjo0+afTB4DbCHeOYgINKQalAz9M12/6n94yqQcExiaiHsFV
Ibc5+ibXB6uXzY9Z7Bs9zTep+cbRtcaoK61qxVYSfTxB0DB5R9pLb4SZlEaCSDJs
r9avsMQKjX7T+lcnPOpPcdsJGFIHtlcDqE89NSeO6yRwv3UCAwEAAaN7MHkwDgYD
VR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFG3qqgJeCib0
1cFdagbFb44rwnCkMB8GA1UdIwQYMBaAFG3qqgJeCib01cFdagbFb44rwnCkMBYG
A1UdEQQPMA2CC2V4YW1wbGUuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQBEp6UwFfHO
7R7cXN8xqt2R4ZPtsg0jY/z8FSHGl079qcpwkK9sYBPloeazjLQQ7fKSylaZwic/
3AZhqGyGjGYt/oqImpxLjcH7YLmND+rFAPnBuUEVqIbJx6rOer6XY+sJhIdEPOXF
i8yipvZ3kG+T0yUhRUaQxwHO+rlnt/nYPMm6tvs/I54zDCsRl0IMwZS9swcw0MYg
I66rrcL4T0a8v2altWy5XsDRKTHGVqg085U8JFGxGMx8GI93+L7W8rR0BYc9ts33
KE+7Jsf+zujaBc6+T3hXHYdXHeBdydLfayFGHGu6iQryYzJ/HMHDJQJV+7g7/N9K
jGZ5m0acLngO
-----END CERTIFICATE-----

root@vagrant:/etc/ssl# cat test.example.com.key
 -----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEA3MoNWyEttBznzUFjjbyVNUdBIxAGgNOKcJY1xfGfv+rW5DJ8
ieExXimofBAqA4HIlal9Zj6RRY5K3V0nGsKQ/LbyDFqCKaD0LTpN7uJ76fTkHfkF
4Q00ez7NQQk3vhqq/uMIyxD5MFKfSr9agdx2GuYtjeH7yUKYp+vfGcf1/4z/pspG
BTPmxwQWHllpfDYOXA5nT9p9Uq0dgNWtVixvqhT8vGB86kj9MXXY9ztJrIQQHmVv
jQd851jus3r52I2Ox/Vs+YLNI4uVlvExP9DVCndqW91p6ZF4HrOFVGIVQubrj+VN
mJu6aLojBj2InaNZdg0dDVd0B3UBhxHYUErMJwIDAQABAoIBAQCwvnKIo/vBNm59
ij3WpcNP/jVvixGZqT4muKhdR/qZGLZjwOKfQY1SksiUYCAx5IAdBqwi4C1M4Aag
RETckCqekxkauI2AI5+0YPsoI1gMxoSiVcnWCcscaf7HdEiSPyjpl/dfD7xbaZio
rpwWXtSQ3fhTnzb/OveXXSOgsMkFg20yPAg1WL0ASb3L7EQa0+ycykeqkU52AhpM
/4MlZvN+fbletQ0VNomlx47cXAycuzSB0/MgaZ/mOxzoxym7YNQHyMYZQE9Ic+5h
aVwbKJVUbd+mx6nmuZyZG5Qf8jqUWwgRYHmMQls6NpKbpLCSCbjPxZFZxQk+De5H
MBUoQHSxAoGBAP+03UE4JUnRnxfNwNq/YFlcG6PqnR1qAhO+CdwRZ7X1ORfFugza
Z5hDObusqiWA51MNjgrxNOzM2XVot8EE5wJVdyXOZj61JFyt+zN2sQp/tKwSD4WX
djeIR9P+eqwUuNUG06vo/dqr+Kdcm2UZ0hP77G8W9WfMyP8ijdgAX0DZAoGBAN0K
7Y7oRWKgmjmR3tQ33WArOKvmmo5QBpLWx3bQuvs2nfP7Gmr05x+l6G928peumNfr
EOFQy2coxBNpKY4Zu+UfK2/mB1UOx+w4Vs94deZNW/4YlPe5oVLLexx4W3cknivK
AlvUnVC47R9ZR29k/I3v6QlZ8y/6FtPjohKb8lT/AoGAM4SpHz7EpH7LYuxdcrUk
IFziZMAcL5TwHjInomMPViW1/wgjV/uY66B/vUQoc63o7V7Jw4Kdeyg6l+ElRIpM
ULgPbVqMVw3/6XxUJCZBvS/FovVwkyXU95NJhXi8FneGVcUuWHB01N3ZFz8dP91X
6hbTp/4kK2mjBWRc16wbhOECgYBnbTqUuJfmuzEOqPNzpyQdYHvm60L8PfOld3vj
W21yKC8mPyMwUqFmjJHCvgxq7tYziZjfZJeYEFoWnwlDpUTmw3vmouJhaUYggIgW
Ec5Q0Xeu4D+r3h7fB7j2LFbX27lq0d3irAxj/fNtzK+BLuaBX3VR29XPaByQTp3C
SVfNbwKBgEXySZchh8+A6fhsdQATHSN5QQ0yuEXCafDo6gt31JLsL6bHDFyw7Tb1
iueHiFRGio/rISIoB54S+SuRHlxUor80UZRmwf2NGMN+M3GxOAvD7gO1FDzdsq/x
wOeIBMAU3AmnjVDZ5IhTkkXx+4n8tFN0hWEltxmXS+DJarCj45at
-----END RSA PRIVATE KEY-----
```
> В файл конфигурации дефолтного сайта сервера nginx добавляем строки:
```bash
root@vagrant:/# cat /etc/nginx/sites-available/default
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        listen 443 ssl default_server;
        ssl_certificate     /etc/ssl/test.example.com.crt;
        ssl_certificate_key /etc/ssl/test.example.com.key;
        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;
        server_name _;
        location / {
                try_files $uri $uri/ =404;
        }
}
```
> Проверяем:
```bash
root@vagrant:/etc/nginx/sites-available# nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

8. Откройте в браузере на хосте https адрес страницы, которую обслуживает сервер nginx.
> Ответ:
> 
9. Создайте скрипт, который будет генерировать новый сертификат в vault:
  - генерируем новый сертификат так, чтобы не переписывать конфиг nginx;
  - перезапускаем nginx для применения нового сертификата.
> Ответ: Создаем cert_refresh.sh
```bash
#!/bin/bash
#!/usr/bin/env bash

export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

REQUEST=$( vault write -format=json pki/issue/example-dot-com common_name="test.example.com" ttl="720h")
SITE_CRT=$(echo $REQUEST | jq .data.certificate | tr -d \")
ISS_CA=$(echo $REQUEST | jq .data.issuing_ca | tr -d \")
SITE_KEY=$(echo $REQUEST | jq .data.private_key | tr -d \")
CERT_FILE=${SITE_CRT}\\n${ISS_CA}\\n${SITE_KEY}
echo -e $CERT_FILE > /etc/ssl/test.example.com.cert
systemctl restart nginx
```
```bash
chmod +x /etc/ssl/cert_refresh.sh
root@vagrant:~# cd /etc/ssl
root@vagrant:/etc/ssl# ./cert_refresh.sh
```
10. Поместите скрипт в crontab, чтобы сертификат обновлялся какого-то числа каждого месяца в удобное для вас время.

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
