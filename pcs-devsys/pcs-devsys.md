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

2022-02-21T17:07:17.440Z [INFO]  proxy environment: http_proxy="\"\"" https_proxy="\"\"" no_proxy="\"\""
2022-02-21T17:07:17.444Z [WARN]  no `api_addr` value specified in config or in VAULT_API_ADDR; falling back to detection if possible, but this value should be manually set
2022-02-21T17:07:17.452Z [INFO]  core: Initializing VersionTimestamps for core
2022-02-21T17:07:17.457Z [INFO]  core: security barrier not initialized
2022-02-21T17:07:17.458Z [INFO]  core: security barrier initialized: stored=1 shares=1 threshold=1
2022-02-21T17:07:17.461Z [INFO]  core: post-unseal setup starting
2022-02-21T17:07:17.465Z [INFO]  core: loaded wrapping token key
2022-02-21T17:07:17.466Z [INFO]  core: Recorded vault version: vault version=1.9.3 upgrade time="2022-02-21 17:07:17.465688752 +0000 UTC m=+1.014392230"
2022-02-21T17:07:17.467Z [INFO]  core: successfully setup plugin catalog: plugin-directory="\"\""
2022-02-21T17:07:17.467Z [INFO]  core: no mounts; adding default mount table
2022-02-21T17:07:17.554Z [INFO]  core: successfully mounted backend: type=cubbyhole path=cubbyhole/
2022-02-21T17:07:17.556Z [INFO]  core: successfully mounted backend: type=system path=sys/
2022-02-21T17:07:17.559Z [INFO]  core: successfully mounted backend: type=identity path=identity/
2022-02-21T17:07:17.600Z [INFO]  core: successfully enabled credential backend: type=token path=token/
2022-02-21T17:07:17.601Z [INFO]  core: restoring leases
2022-02-21T17:07:17.619Z [INFO]  rollback: starting rollback manager
2022-02-21T17:07:17.627Z [INFO]  expiration: lease restore complete
2022-02-21T17:07:17.633Z [INFO]  identity: entities restored
2022-02-21T17:07:17.633Z [INFO]  identity: groups restored
2022-02-21T17:07:17.634Z [INFO]  core: post-unseal setup complete
2022-02-21T17:07:17.635Z [INFO]  core: root token generated
2022-02-21T17:07:17.635Z [INFO]  core: pre-seal teardown starting
2022-02-21T17:07:17.635Z [INFO]  rollback: stopping rollback manager
2022-02-21T17:07:17.636Z [INFO]  core: pre-seal teardown complete
2022-02-21T17:07:17.638Z [INFO]  core.cluster-listener.tcp: starting listener: listener_address=127.0.0.1:8201
2022-02-21T17:07:17.639Z [INFO]  core.cluster-listener: serving cluster requests: cluster_listen_address=127.0.0.1:8201
2022-02-21T17:07:17.641Z [INFO]  core: post-unseal setup starting
2022-02-21T17:07:17.641Z [INFO]  core: loaded wrapping token key
2022-02-21T17:07:17.642Z [INFO]  core: successfully setup plugin catalog: plugin-directory="\"\""
2022-02-21T17:07:17.662Z [INFO]  core: successfully mounted backend: type=system path=sys/
2022-02-21T17:07:17.670Z [INFO]  core: successfully mounted backend: type=identity path=identity/
2022-02-21T17:07:17.670Z [INFO]  core: successfully mounted backend: type=cubbyhole path=cubbyhole/
2022-02-21T17:07:17.691Z [INFO]  core: successfully enabled credential backend: type=token path=token/
2022-02-21T17:07:17.692Z [INFO]  rollback: starting rollback manager
2022-02-21T17:07:17.695Z [INFO]  core: restoring leases
2022-02-21T17:07:17.695Z [INFO]  expiration: lease restore complete
2022-02-21T17:07:17.699Z [INFO]  identity: entities restored
2022-02-21T17:07:17.699Z [INFO]  identity: groups restored
2022-02-21T17:07:17.700Z [INFO]  core: post-unseal setup complete
2022-02-21T17:07:17.700Z [INFO]  core: vault is unsealed
2022-02-21T17:07:17.713Z [INFO]  expiration: revoked lease: lease_id=auth/token/root/hb4197ba5f52fb7ba8c32778f7206c6b862e7697695dbc5fe90ec102d8292ab7c
2022-02-21T17:07:17.764Z [INFO]  core: successful mount: namespace="\"\"" path=secret/ type=kv
2022-02-21T17:07:17.771Z [INFO]  secrets.kv.kv_e8eeac22: collecting keys to upgrade
2022-02-21T17:07:17.771Z [INFO]  secrets.kv.kv_e8eeac22: done collecting keys: num_keys=1
2022-02-21T17:07:17.771Z [INFO]  secrets.kv.kv_e8eeac22: upgrading keys finished
WARNING! dev mode is enabled! In this mode, Vault runs entirely in-memory
and starts unsealed with a single unseal key. The root token is already
authenticated to the CLI, so you can immediately begin using Vault.

You may need to set the following environment variable:

    $ export VAULT_ADDR='http://127.0.0.1:8200'

The unseal key and root token are displayed below in case you want to
seal/unseal the Vault or re-authenticate.

Unseal Key: akPkx+yTEAxIWjjCqARPtpZgPrc1TfDr2uIDHNB9vgs=
Root Token: root

Development mode should NOT be used in production installations!

2022-02-21T17:10:26.697Z [INFO]  core: successful mount: namespace="\"\"" path=pki/ type=pki
2022-02-21T17:10:38.271Z [INFO]  core: mount tuning of leases successful: path=pki/
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
MIIDNTCCAh2gAwIBAgIUAVQEQeXCrFmaWpRrv/NwjDhIMOEwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMjIxMTcxMDQ3WhcNMjIw
MzIzMTcxMTE3WjAWMRQwEgYDVQQDEwtleGFtcGxlLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAM1KUXMbkiqq59VickfQBK3ICNCDnPdwjTlxCRj8
8EL4vobFZ5hwGXPoufzQL9VABwROxhT5DtCjZY/NNerbr+FxY6kAgZ95o6Eq9qnX
sDUpPZt4xYUgDq8eL+jGuWEmGknBPJkXrRRX34W0Qtx4KvpfSdth1y4IpGGl/9Rd
CaljmxFHKiUiQkbvVSVcEUrkqM8EDSMKt/ovmQwyFBT8x6mrM/f04a6s5I/A0sCN
7Yr3KlPiHKA7PkVhzoyeq3O9I9om6vl8yHgER0PseKwHbZ/OeSXtqAtskm09lhyC
7DqGExT4hY2ASBMV00ocVne03XDkoiCeP9mQdNukYD7R6/sCAwEAAaN7MHkwDgYD
VR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFD1a93dyM4bo
8Te5x6WdpyBVFrJfMB8GA1UdIwQYMBaAFD1a93dyM4bo8Te5x6WdpyBVFrJfMBYG
A1UdEQQPMA2CC2V4YW1wbGUuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQC3ietgQj/L
N1kWppYFrxetrbrug2JtQ/1THxHfcjS72ABr1tbiqZQQxLwRCtxTWQo18YxqTOsI
Eeu2uR4/xb6q0yLiT45LhrnQ2LJCnssgfU4KAYzZGVh0fbyd00WmWgxSMp7AIWpZ
zrv2K42AWsdQ4bBKx4qO0JNXXzujXJjbq76ZX203tGLdfK+CMoyQWXcPHODfAG7h
57EmV1QN8q01fiJ7xjqGi1tvSo+xeGmbcpJZveLtuuBn2ER0L5yjbqHITBnuQYvK
C8iExBRmykuXTlkKgChOvYqByreHiVkmmrEcq8TihO7paFcpxIBTpblPFkCdNzlF
UmsaIcMpycYh
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
vagrant@vagrant:~$ vault write pki/issue/example-dot-com common_name="test.example.com" ttl="24h"
Key                 Value
---                 -----
certificate         -----BEGIN CERTIFICATE-----
MIIDvzCCAqegAwIBAgIUebvNmrEcQMPqpgZhiidN6ezuV0UwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMjIxMTcxODM0WhcNMjIw
MjIyMTcxOTAzWjAbMRkwFwYDVQQDExB0ZXN0LmV4YW1wbGUuY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq00L07udOIo1QUMZE+HHqQ7HG6nbU0b2
57TCJ6sCxhMrm2vRbgISiXuCHLh+OBS4FWLADdQcehNGE1WUrS9eZG/etRTa9Fkp
bKD2luhtMy1hMiU42DndP5Rq5zAYPxyIvc/eRIElt2wUXixbaTGSWaR9TfiEvX36
zHE2RdrbqWEvO+wfgDAfXEhp8iA+KtsNRvZnAWmBGKF/O7zAtTrg5NyWLk5MmLnO
YVQq3XTEYVrswwZVugqMxi4rwvut/EIHh62Lh9zL8jnzm70nBqsd/Vy1EouieIoq
MHesI8XcOQ6ZRX3shr3ZLXkwFEmwsHPsHwCvLK82yPacxKZwEmEozwIDAQABo4H/
MIH8MA4GA1UdDwEB/wQEAwIDqDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUH
AwIwHQYDVR0OBBYEFH0c5pR2X1CXjhZn7XqEmGLSyDPNMB8GA1UdIwQYMBaAFD1a
93dyM4bo8Te5x6WdpyBVFrJfMDsGCCsGAQUFBwEBBC8wLTArBggrBgEFBQcwAoYf
aHR0cDovLzEyNy4wLjAuMTo4MjAwL3YxL3BraS9jYTAbBgNVHREEFDASghB0ZXN0
LmV4YW1wbGUuY29tMDEGA1UdHwQqMCgwJqAkoCKGIGh0dHA6Ly8xMjcuMC4wLjE6
ODIwMC92MS9wa2kvY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBXVfBKYbEMstr/VUsC
QC2EEeuXUZ+IL+TTksbO2uvE3t/C65POT3Juo7DL2z9oWe5FDpBdX+BHCc3Mfaas
Cb434/Cwv3YdHkgKZI1mO3CqJruFwKeNU0XlJ39cnoAebHshgbTuciXtitIBCkMI
VYWcXtS9gmGYT6qr5i6bw8c6UYM5gCvM79Qwhi91CiyLJ5hyRGCn/pNrBTpSKbeq
XWFkYhqM9VtXUe1yKWxIrFMdGPdRLwDc3wzfywrfPjqqnlWdSkTUnVMnHPbJIJqN
GBFO2N/67vFU5x1D1cr+tvoI0ndqiJJcXpoRYN725ubUeOjzirgyZLWGkLqROppJ
ijUt
-----END CERTIFICATE-----
expiration          1645550343
issuing_ca          -----BEGIN CERTIFICATE-----
MIIDNTCCAh2gAwIBAgIUAVQEQeXCrFmaWpRrv/NwjDhIMOEwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMjIxMTcxMDQ3WhcNMjIw
MzIzMTcxMTE3WjAWMRQwEgYDVQQDEwtleGFtcGxlLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAM1KUXMbkiqq59VickfQBK3ICNCDnPdwjTlxCRj8
8EL4vobFZ5hwGXPoufzQL9VABwROxhT5DtCjZY/NNerbr+FxY6kAgZ95o6Eq9qnX
sDUpPZt4xYUgDq8eL+jGuWEmGknBPJkXrRRX34W0Qtx4KvpfSdth1y4IpGGl/9Rd
CaljmxFHKiUiQkbvVSVcEUrkqM8EDSMKt/ovmQwyFBT8x6mrM/f04a6s5I/A0sCN
7Yr3KlPiHKA7PkVhzoyeq3O9I9om6vl8yHgER0PseKwHbZ/OeSXtqAtskm09lhyC
7DqGExT4hY2ASBMV00ocVne03XDkoiCeP9mQdNukYD7R6/sCAwEAAaN7MHkwDgYD
VR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFD1a93dyM4bo
8Te5x6WdpyBVFrJfMB8GA1UdIwQYMBaAFD1a93dyM4bo8Te5x6WdpyBVFrJfMBYG
A1UdEQQPMA2CC2V4YW1wbGUuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQC3ietgQj/L
N1kWppYFrxetrbrug2JtQ/1THxHfcjS72ABr1tbiqZQQxLwRCtxTWQo18YxqTOsI
Eeu2uR4/xb6q0yLiT45LhrnQ2LJCnssgfU4KAYzZGVh0fbyd00WmWgxSMp7AIWpZ
zrv2K42AWsdQ4bBKx4qO0JNXXzujXJjbq76ZX203tGLdfK+CMoyQWXcPHODfAG7h
57EmV1QN8q01fiJ7xjqGi1tvSo+xeGmbcpJZveLtuuBn2ER0L5yjbqHITBnuQYvK
C8iExBRmykuXTlkKgChOvYqByreHiVkmmrEcq8TihO7paFcpxIBTpblPFkCdNzlF
UmsaIcMpycYh
-----END CERTIFICATE-----
private_key         -----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAq00L07udOIo1QUMZE+HHqQ7HG6nbU0b257TCJ6sCxhMrm2vR
bgISiXuCHLh+OBS4FWLADdQcehNGE1WUrS9eZG/etRTa9FkpbKD2luhtMy1hMiU4
2DndP5Rq5zAYPxyIvc/eRIElt2wUXixbaTGSWaR9TfiEvX36zHE2RdrbqWEvO+wf
gDAfXEhp8iA+KtsNRvZnAWmBGKF/O7zAtTrg5NyWLk5MmLnOYVQq3XTEYVrswwZV
ugqMxi4rwvut/EIHh62Lh9zL8jnzm70nBqsd/Vy1EouieIoqMHesI8XcOQ6ZRX3s
hr3ZLXkwFEmwsHPsHwCvLK82yPacxKZwEmEozwIDAQABAoIBAQCOJtymsy1QCxkQ
dE7uOdHHUBUYtsbj/6LLOyxXYMlnd+cbDcj4wk2Bu3WIwe00OrVcQdtgXmHXSAFB
8CX15bYuIMuud4UPeqIunBClwHFGI+VhiJP4k2Qv68ke2sF0Ngifg01OieGzqcPp
NmQREmsBasf1GUOGQHIMj/Ja27ingDvz4YghYpdL4wHrRoP38rwoN1UUCcwo4ldn
H0Va8Xngk2sLR9jxRi/i6jq9OMeItSxXwSApu3RvVYZBl4uQalUB1q5STOVcSabH
o9aZqVyl0r8NrSnnnSAiuX19Dlu88MX7FBPp3oKGvTLuFoIxTyMWHT3/Uy/QB04g
IrZVh2/JAoGBANEJctfNLaN6+vXi8VImpg2ksAjv179J1m7387MLpiU+Ad5DZKWa
LYUSaTDAxldCceOgtjNpAEuNx093RVHVdY8Dlt1Z0x+fY+0i4w0YJVMjfyFE85sQ
2rGTG25l8e6rdaJxi71zXzjidhyFJaE96vAld+KN73NzGDWIcAuzNK7lAoGBANHJ
QHp9eLc1BxnLB9scWzOYv/xI3X1tlmv6MKzMDDnC+A4sZRGe7Pw2rhiQvARcMvw4
+wiIAyadx9D11xaX/1p4H9lmuHsHdIej8+QL2TnHklMBu/mUwazMmAt+l6FDLxrR
2KqS0IYf56sFTs9EDz7NKII5pIbRo4jXp1uENMmjAoGAF4hqx2Sv6KGlsxzTch4r
v4l0z+zAayaS33dGljePgs3SRAVuRT5wNXT3JqftLFGspKWpHWyKvfa+I3IX+biA
PZN33n+IRx0YkM/Go+i9+vgaDdLHYgOpuygGhI0xiV8AJUOHKdLdO3gzN869h8OC
uXpeXsD/3g1tAknT411PZwkCgYEArgVfszw50t/uD/tXfO68yMRBHanj8ZPiX5ee
oPhye8e7tSYmgMNwmpdRO5d0H7nLoWYy9xS8aGAhzLjhvyA+9nEHGnQXPBcnFw1t
1xHtE/z06F5b6+D1972PsplEdsUgYgMI1BYNW/VDW55/jXdLnjDZFY1zaVKlcXJS
pZu5njkCgYA2Y+CNqPgQtfpG5KzHRkz2TFsvIn9pNEUjd0GF7vLSIulUcVgqTWUs
lzzvF5N3DNo+cOoWvl09Kj6e7vppO5y2Y663xp50/GTh8cKujLwdqjU60IZe5+Rt
FYq18vJz7hLJy2N0rVJb0mki/sj32WgJlbswNuTxo+M7nt0apAOunQ==
-----END RSA PRIVATE KEY-----
private_key_type    rsa
serial_number       79:bb:cd:9a:b1:1c:40:c3:ea:a6:06:61:8a:27:4d:e9:ec:ee:57:45
```

5. Установите корневой сертификат созданного центра сертификации в доверенные в хостовой системе.
> Ответ:
> ![gcr-viewer](CA_crt.png)
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
MIIDvzCCAqegAwIBAgIUebvNmrEcQMPqpgZhiidN6ezuV0UwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMjIxMTcxODM0WhcNMjIw
MjIyMTcxOTAzWjAbMRkwFwYDVQQDExB0ZXN0LmV4YW1wbGUuY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq00L07udOIo1QUMZE+HHqQ7HG6nbU0b2
57TCJ6sCxhMrm2vRbgISiXuCHLh+OBS4FWLADdQcehNGE1WUrS9eZG/etRTa9Fkp
bKD2luhtMy1hMiU42DndP5Rq5zAYPxyIvc/eRIElt2wUXixbaTGSWaR9TfiEvX36
zHE2RdrbqWEvO+wfgDAfXEhp8iA+KtsNRvZnAWmBGKF/O7zAtTrg5NyWLk5MmLnO
YVQq3XTEYVrswwZVugqMxi4rwvut/EIHh62Lh9zL8jnzm70nBqsd/Vy1EouieIoq
MHesI8XcOQ6ZRX3shr3ZLXkwFEmwsHPsHwCvLK82yPacxKZwEmEozwIDAQABo4H/
MIH8MA4GA1UdDwEB/wQEAwIDqDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUH
AwIwHQYDVR0OBBYEFH0c5pR2X1CXjhZn7XqEmGLSyDPNMB8GA1UdIwQYMBaAFD1a
93dyM4bo8Te5x6WdpyBVFrJfMDsGCCsGAQUFBwEBBC8wLTArBggrBgEFBQcwAoYf
aHR0cDovLzEyNy4wLjAuMTo4MjAwL3YxL3BraS9jYTAbBgNVHREEFDASghB0ZXN0
LmV4YW1wbGUuY29tMDEGA1UdHwQqMCgwJqAkoCKGIGh0dHA6Ly8xMjcuMC4wLjE6
ODIwMC92MS9wa2kvY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBXVfBKYbEMstr/VUsC
QC2EEeuXUZ+IL+TTksbO2uvE3t/C65POT3Juo7DL2z9oWe5FDpBdX+BHCc3Mfaas
Cb434/Cwv3YdHkgKZI1mO3CqJruFwKeNU0XlJ39cnoAebHshgbTuciXtitIBCkMI
VYWcXtS9gmGYT6qr5i6bw8c6UYM5gCvM79Qwhi91CiyLJ5hyRGCn/pNrBTpSKbeq
XWFkYhqM9VtXUe1yKWxIrFMdGPdRLwDc3wzfywrfPjqqnlWdSkTUnVMnHPbJIJqN
GBFO2N/67vFU5x1D1cr+tvoI0ndqiJJcXpoRYN725ubUeOjzirgyZLWGkLqROppJ
ijUt
-----END CERTIFICATE-----
expiration          1645550343
issuing_ca          -----BEGIN CERTIFICATE-----
MIIDNTCCAh2gAwIBAgIUAVQEQeXCrFmaWpRrv/NwjDhIMOEwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMjIxMTcxMDQ3WhcNMjIw
MzIzMTcxMTE3WjAWMRQwEgYDVQQDEwtleGFtcGxlLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAM1KUXMbkiqq59VickfQBK3ICNCDnPdwjTlxCRj8
8EL4vobFZ5hwGXPoufzQL9VABwROxhT5DtCjZY/NNerbr+FxY6kAgZ95o6Eq9qnX
sDUpPZt4xYUgDq8eL+jGuWEmGknBPJkXrRRX34W0Qtx4KvpfSdth1y4IpGGl/9Rd
CaljmxFHKiUiQkbvVSVcEUrkqM8EDSMKt/ovmQwyFBT8x6mrM/f04a6s5I/A0sCN
7Yr3KlPiHKA7PkVhzoyeq3O9I9om6vl8yHgER0PseKwHbZ/OeSXtqAtskm09lhyC
7DqGExT4hY2ASBMV00ocVne03XDkoiCeP9mQdNukYD7R6/sCAwEAAaN7MHkwDgYD
VR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFD1a93dyM4bo
8Te5x6WdpyBVFrJfMB8GA1UdIwQYMBaAFD1a93dyM4bo8Te5x6WdpyBVFrJfMBYG
A1UdEQQPMA2CC2V4YW1wbGUuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQC3ietgQj/L
N1kWppYFrxetrbrug2JtQ/1THxHfcjS72ABr1tbiqZQQxLwRCtxTWQo18YxqTOsI
Eeu2uR4/xb6q0yLiT45LhrnQ2LJCnssgfU4KAYzZGVh0fbyd00WmWgxSMp7AIWpZ
zrv2K42AWsdQ4bBKx4qO0JNXXzujXJjbq76ZX203tGLdfK+CMoyQWXcPHODfAG7h
57EmV1QN8q01fiJ7xjqGi1tvSo+xeGmbcpJZveLtuuBn2ER0L5yjbqHITBnuQYvK
C8iExBRmykuXTlkKgChOvYqByreHiVkmmrEcq8TihO7paFcpxIBTpblPFkCdNzlF
UmsaIcMpycYh
-----END CERTIFICATE-----

root@vagrant:/etc/ssl# cat test.example.com.key
  -----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAq00L07udOIo1QUMZE+HHqQ7HG6nbU0b257TCJ6sCxhMrm2vR
bgISiXuCHLh+OBS4FWLADdQcehNGE1WUrS9eZG/etRTa9FkpbKD2luhtMy1hMiU4
2DndP5Rq5zAYPxyIvc/eRIElt2wUXixbaTGSWaR9TfiEvX36zHE2RdrbqWEvO+wf
gDAfXEhp8iA+KtsNRvZnAWmBGKF/O7zAtTrg5NyWLk5MmLnOYVQq3XTEYVrswwZV
ugqMxi4rwvut/EIHh62Lh9zL8jnzm70nBqsd/Vy1EouieIoqMHesI8XcOQ6ZRX3s
hr3ZLXkwFEmwsHPsHwCvLK82yPacxKZwEmEozwIDAQABAoIBAQCOJtymsy1QCxkQ
dE7uOdHHUBUYtsbj/6LLOyxXYMlnd+cbDcj4wk2Bu3WIwe00OrVcQdtgXmHXSAFB
8CX15bYuIMuud4UPeqIunBClwHFGI+VhiJP4k2Qv68ke2sF0Ngifg01OieGzqcPp
NmQREmsBasf1GUOGQHIMj/Ja27ingDvz4YghYpdL4wHrRoP38rwoN1UUCcwo4ldn
H0Va8Xngk2sLR9jxRi/i6jq9OMeItSxXwSApu3RvVYZBl4uQalUB1q5STOVcSabH
o9aZqVyl0r8NrSnnnSAiuX19Dlu88MX7FBPp3oKGvTLuFoIxTyMWHT3/Uy/QB04g
IrZVh2/JAoGBANEJctfNLaN6+vXi8VImpg2ksAjv179J1m7387MLpiU+Ad5DZKWa
LYUSaTDAxldCceOgtjNpAEuNx093RVHVdY8Dlt1Z0x+fY+0i4w0YJVMjfyFE85sQ
2rGTG25l8e6rdaJxi71zXzjidhyFJaE96vAld+KN73NzGDWIcAuzNK7lAoGBANHJ
QHp9eLc1BxnLB9scWzOYv/xI3X1tlmv6MKzMDDnC+A4sZRGe7Pw2rhiQvARcMvw4
+wiIAyadx9D11xaX/1p4H9lmuHsHdIej8+QL2TnHklMBu/mUwazMmAt+l6FDLxrR
2KqS0IYf56sFTs9EDz7NKII5pIbRo4jXp1uENMmjAoGAF4hqx2Sv6KGlsxzTch4r
v4l0z+zAayaS33dGljePgs3SRAVuRT5wNXT3JqftLFGspKWpHWyKvfa+I3IX+biA
PZN33n+IRx0YkM/Go+i9+vgaDdLHYgOpuygGhI0xiV8AJUOHKdLdO3gzN869h8OC
uXpeXsD/3g1tAknT411PZwkCgYEArgVfszw50t/uD/tXfO68yMRBHanj8ZPiX5ee
oPhye8e7tSYmgMNwmpdRO5d0H7nLoWYy9xS8aGAhzLjhvyA+9nEHGnQXPBcnFw1t
1xHtE/z06F5b6+D1972PsplEdsUgYgMI1BYNW/VDW55/jXdLnjDZFY1zaVKlcXJS
pZu5njkCgYA2Y+CNqPgQtfpG5KzHRkz2TFsvIn9pNEUjd0GF7vLSIulUcVgqTWUs
lzzvF5N3DNo+cOoWvl09Kj6e7vppO5y2Y663xp50/GTh8cKujLwdqjU60IZe5+Rt
FYq18vJz7hLJy2N0rVJb0mki/sj32WgJlbswNuTxo+M7nt0apAOunQ==
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
echo -e $CERT_FILE > /etc/ssl/test.example.com.crt
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
