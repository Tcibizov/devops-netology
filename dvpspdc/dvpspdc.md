# Дипломный практикум в YandexCloud

## Подготовка к работе

1. Создаём домен `tcibizov.ru` на (https://www.reg.ru/). Прописываем DNS-серверы: (`ns1.yandexcloud.net`, `ns2.yandexcloud.net`).

2. Создадим новый workspace `devops-diplom-yandexcloud` в Terraform Cloud.

![Terraform workspace](img/terraform-workspace.png)

## Terraform
Подготовим инфраструктуру в Yandex Cloud при помощи Terraform.

1. В `provider.tf` добавим конфигурацию провайдера `yandex`:

```terraform
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.75.0"
    }
  }
}
provider "yandex" {
  token     = var.YANDEX_TOKEN
  cloud_id  = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
  zone      = "ru-central1-a"
}
```
