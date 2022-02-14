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
root@vagrant:~# sudo ufw allow 22
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
MIIDNTCCAh2gAwIBAgIUWpCoyq7Zr95UvmVmpoQ9HfmOGHEwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMjE0MDkzNDQ0WhcNMjIw
MzE2MDkzNTEzWjAWMRQwEgYDVQQDEwtleGFtcGxlLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMDHSssESL18LXibSFbB4MlUt3RNFYeEjC3nBCKE
iVWoQJ0JTD+/SeiZTR7z/MqvP1vgVBI7EZDpMu4zpXdjnv+gg0SRx062OcKdNdYf
kDEyGFIiXDArF7DEZuL10gfu1lhGWXIb1zMcUEAHSWfoOn46TWIhAYn504svk0mY
IWSGfj7pd2Fukq62wzXw+7nfVSgbu5hsw5iEYj4uXCwXLk5i8oS5IKpiCUDeCehL
mVzWHy9R8ciLW8VRE0e8qYjdMDe8xI4/VKqKGe7f2q9vMavEhf6P8v2lddGYtR0r
7sR6Xdv6yK22fsE7VhORmoDyqwC37797uy6rxKq0X/JBNv0CAwEAAaN7MHkwDgYD
VR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFDPraYI5BylY
fymrhF3cPUvOUXmlMB8GA1UdIwQYMBaAFDPraYI5BylYfymrhF3cPUvOUXmlMBYG
A1UdEQQPMA2CC2V4YW1wbGUuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQBFqbAAx4OF
YhcYNyrujsScStRiKEG0Wl5C0uvn2vsQGXbgUjCiooqZBznsqNDf9kgpHs+rRCDh
HV12oeAKanisrkLyCHpB5bFO1TNXILCSY+8nwotyQ8Wz9JmMfnt0HVfMXv63zrLr
HbzjxtoVwlAxvU2L7pOUx+pa4UQCS4P2FBK9p5TDtWPc46Vwb1o/Wv/CTc+Y0p1K
8xAq2eEvNp1uH3ndwLH2JupWtCx5p8OBhEoJrhdkG0RtBN1YMy8/7Pt9F43MLsPz
awUoDKprqXMy/0ycWUp3Q/0k7FU+xIco5PmqnjEx15bq0GEpqRsKLShwDggTGN/F
LYfjQ/qtjC3D
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
MIIDvzCCAqegAwIBAgIUPqE+7hsQjQbN6Pwn7tIzgasWNpEwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMjE0MDk0MDE1WhcNMjIw
MjE1MDk0MDQ0WjAbMRkwFwYDVQQDExB0ZXN0LmV4YW1wbGUuY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmrTQoLtaQU07QcCYZME3hIWxS2eQmfUq
twkHLt2CNyV7NI5S34R7BmZnCKNe5aCpYVmckb0Ji7f9+5ixMlkINOG6lBDd67x9
/MOozYiIIBAiX59YBkzzbycRZ+DU1MdsN0JKpf37MQJUvzsc7h0/SxEaolWiUuWE
LaUjP2i8x4vwK7S3bqGsHNQSAOihQTKGAx9H5y0uJIbHRbd3uiIePGdxY78xLVYB
/kPEqfQqoLCWA9ZRvoHOeRRNrvk6n4li6nZIP+8L91sByiFxJ19URkG3EeIjCFZq
YU5hzYrv+NH/Kp3s1MoySut4HY7TEVe2AHyixORMyQLkRlAPEXLFLwIDAQABo4H/
MIH8MA4GA1UdDwEB/wQEAwIDqDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUH
AwIwHQYDVR0OBBYEFJ1AUCb/j9favirgScgZkEFy8rcqMB8GA1UdIwQYMBaAFDPr
aYI5BylYfymrhF3cPUvOUXmlMDsGCCsGAQUFBwEBBC8wLTArBggrBgEFBQcwAoYf
aHR0cDovLzEyNy4wLjAuMTo4MjAwL3YxL3BraS9jYTAbBgNVHREEFDASghB0ZXN0
LmV4YW1wbGUuY29tMDEGA1UdHwQqMCgwJqAkoCKGIGh0dHA6Ly8xMjcuMC4wLjE6
ODIwMC92MS9wa2kvY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQB3YaMfisPUWgWK7uQ0
T3AG7TCTT3LQbMe6J7Na/ITWa/sHgeZnNTQlvFYysaz6BUcCR0tWjNPLxBkavAyB
d9fS+N1DPaLwxDYCMe6C8staenx0vOiEn6rh/lkAMvnuNAketejUQGrHI55nzpOT
euRqMhHb9y5SfX4Ir7kJRO7OGrNZW+ED4vdzJYmp29BiE9HOL2p9hS4aIYyn+8UD
ZFInv8Y4mDaHV5CHGjz2+y/K9AmTTwotc5+E3AeHJSLqTNia12VZg0p2df/kWAhw
baprE8Kgb26XxqaJyIsd+k4BMitU2GjKW1QnFMyGBWwoVjFnKC/Kw5hhqZnzB/JW
rKRy
-----END CERTIFICATE-----
expiration          1644918044
issuing_ca          -----BEGIN CERTIFICATE-----
MIIDNTCCAh2gAwIBAgIUWpCoyq7Zr95UvmVmpoQ9HfmOGHEwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAxMLZXhhbXBsZS5jb20wHhcNMjIwMjE0MDkzNDQ0WhcNMjIw
MzE2MDkzNTEzWjAWMRQwEgYDVQQDEwtleGFtcGxlLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMDHSssESL18LXibSFbB4MlUt3RNFYeEjC3nBCKE
iVWoQJ0JTD+/SeiZTR7z/MqvP1vgVBI7EZDpMu4zpXdjnv+gg0SRx062OcKdNdYf
kDEyGFIiXDArF7DEZuL10gfu1lhGWXIb1zMcUEAHSWfoOn46TWIhAYn504svk0mY
IWSGfj7pd2Fukq62wzXw+7nfVSgbu5hsw5iEYj4uXCwXLk5i8oS5IKpiCUDeCehL
mVzWHy9R8ciLW8VRE0e8qYjdMDe8xI4/VKqKGe7f2q9vMavEhf6P8v2lddGYtR0r
7sR6Xdv6yK22fsE7VhORmoDyqwC37797uy6rxKq0X/JBNv0CAwEAAaN7MHkwDgYD
VR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFDPraYI5BylY
fymrhF3cPUvOUXmlMB8GA1UdIwQYMBaAFDPraYI5BylYfymrhF3cPUvOUXmlMBYG
A1UdEQQPMA2CC2V4YW1wbGUuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQBFqbAAx4OF
YhcYNyrujsScStRiKEG0Wl5C0uvn2vsQGXbgUjCiooqZBznsqNDf9kgpHs+rRCDh
HV12oeAKanisrkLyCHpB5bFO1TNXILCSY+8nwotyQ8Wz9JmMfnt0HVfMXv63zrLr
HbzjxtoVwlAxvU2L7pOUx+pa4UQCS4P2FBK9p5TDtWPc46Vwb1o/Wv/CTc+Y0p1K
8xAq2eEvNp1uH3ndwLH2JupWtCx5p8OBhEoJrhdkG0RtBN1YMy8/7Pt9F43MLsPz
awUoDKprqXMy/0ycWUp3Q/0k7FU+xIco5PmqnjEx15bq0GEpqRsKLShwDggTGN/F
LYfjQ/qtjC3D
-----END CERTIFICATE-----
private_key         -----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAmrTQoLtaQU07QcCYZME3hIWxS2eQmfUqtwkHLt2CNyV7NI5S
34R7BmZnCKNe5aCpYVmckb0Ji7f9+5ixMlkINOG6lBDd67x9/MOozYiIIBAiX59Y
BkzzbycRZ+DU1MdsN0JKpf37MQJUvzsc7h0/SxEaolWiUuWELaUjP2i8x4vwK7S3
bqGsHNQSAOihQTKGAx9H5y0uJIbHRbd3uiIePGdxY78xLVYB/kPEqfQqoLCWA9ZR
voHOeRRNrvk6n4li6nZIP+8L91sByiFxJ19URkG3EeIjCFZqYU5hzYrv+NH/Kp3s
1MoySut4HY7TEVe2AHyixORMyQLkRlAPEXLFLwIDAQABAoIBAEfSzlDw6jQLAQnD
unx8X6P81ZTmXfG8KrqTTGxrljq4Af0iXkM7JEqSXB9ciYAeGMUDb3cRxk7Bev7F
ou52+yJh8dcwBXeeKPeidsoFKv2HwA2Y0qsKKrJd9uy9KtImS41UD4gE5Auaw3GM
ph++IFZfeHgJPbUyrSzrz/NuUsZo7qFATB8j+fKKKUCq2zjUsOWf4fdMkNMh+oul
5F+U77tPpIqkAvjBU+KojRM4J1dg6WklKIU2GVhWRnNczbKA803gSwQRMk3Sj+bT
RUgXST8J2LZGSdKAK/UTa08gX4/dfxu0yyuPyuJ64oSpD6E21SbphFliuV5vg1is
tS4vVlECgYEAwrXXRKQMBX6znmb2XWrMLxtH215DYdmShk8ApLHIfhdfGLI36oTs
JLe1XQhDYGn5OLKp7VlsHDOe8YJwjBQN5J3S50F9V1FppYGKo0bonrIGCKpln3i6
irrRbnxOOZH49IWqaeMZrBll12TaTg0cVcBMS8vF4oIhlVJSzoNFkWUCgYEAy2de
Wp1Z0bWIf8LE+4gM+EOQE/GcX2c3yTzZL7UPCLoQaH4H7VjD9F0EgQJ9de163Lxt
r78KXdwewg1O1gdLliMk+nn5gI7QcqLK5uNewJCW0n+ozbsby0c/nDZmTgjFoYuP
HChN4FqiT4gX6x/xe384RZUemAna+6eBwTq5PQMCgYEAseBrc5KmRNLWBsyrHvZ0
6Ef04kwAJMEeIcLEpLChp8d0IdyWRpH+JSEK952X59mISyq1IFcD89OYzatLZDzh
4EvqI0fp2L5QVFm+rKEX2/polrwMMJ6bVCeNMnEvCVr4Y3JFF4zXpChjqF3DLXC+
xPvy93+GHQKi6YYWjgDQqh0CgYB8qHROKqNSf+QREOgyk7YHLTkO0AObAKJS5cTh
lSCKo6XMtHjdQIqPp7ZL7p+/d3TV9XFvxTBwR6heG1PWng/4Cr/t9nUwEda0ewrJ
KE34zGRyy6RDucmV8quMbFaUupGMqQBjLFxWBJX3Ehw+kIwpuNVe574hReD8XDOM
nhXKywKBgQCFHKzM3U4lY3+kceBNqFzxKf/PxGEn/IJJLWd+L9q7M/wY5cfnbMmW
vOHw7rMPyy6r27uFTiILyW9QLqs+rnEM4XA4ChEE1dhDv9uY0vwss1AwKXOjuEAO
G4sCkZ9OD6dwDV2glQwskp3FMnU9PtaDcKrubZSox7BwQi/Z5QuPQQ==
-----END RSA PRIVATE KEY-----
private_key_type    rsa
serial_number       3e:a1:3e:ee:1b:10:8d:06:cd:e8:fc:27:ee:d2:33:81:ab:16:36:91
```

5. Установите корневой сертификат созданного центра сертификации в доверенные в хостовой системе.
> Ответ:
```bash
alex@debian:~/vagrant$ gcr-viewer CA_cert.crt
![image](https://github.com/Tcibizov/devops-netology/blob/53cfb1d564f7d32143121bc892924938b41cf689/pcs-devsys/CA_cert.png)
root@debian:/home/alex/vagrant# sudo cp ./CA_cert.crt /usr/local/share/ca-certificates/
root@debian:/home/alex/vagrant# sudo update-ca-certificates
Updating certificates in /etc/ssl/certs...
1 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
done.
root@debian:/home/alex/vagrant# awk -v cmd='openssl x509 -noout -subject' ' /BEGIN/{close(cmd)};{print | cmd}' < /etc/ssl/certs/ca-certificates.crt | grep -i example.com
subject=CN = example.com

```
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
