# Дипломный практикум в YandexCloud

## Подготовка к работе

1. Создаём домен `tcibizov.ru` на (https://www.reg.ru/). Прописываем DNS-серверы: (`ns1.yandexcloud.net`, `ns2.yandexcloud.net`).

![reg.ru domain](img/reg-ru.png)

2. Создадим новый workspace `devops-diplom-yandexcloud` в Terraform Cloud.

![Terraform workspace](img/terraform-workspace.png)

## Terraform
Подготовим инфраструктуру в Yandex Cloud при помощи Terraform.

1. В `provider.tf` добавим конфигурацию провайдера `yandex`:

```terraform
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "AQAAAAA-eODYAATuwQfQsl6BcUb1rMFT7Bqmw0Y"
  cloud_id  = "b1gsin4cial4tfskfcu9"
  folder_id = "b1gbmv9vnj1ko7uqevp7"
  zone      = "ru-central1-b"
}
```
