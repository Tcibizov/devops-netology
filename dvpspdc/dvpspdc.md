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
2. В `main.tf`пропишем конфигурацию:
```
resource "yandex_compute_instance" "nat_instance" {
  name     = "nat"
  hostname = "nat.tcibizov.ru"
  zone     = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd85e63v406oaqdjnc4b"
    }
  }

  network_interface {
    subnet_id = "e9b7ltjppp3nrkuemo66"
    nat       = true
  }

  metadata = {
    test     = "test_str"
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "entrance_instance" {
  name = "main"
  zone = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd85e63v406oaqdjnc4b"
      size     = 10
    }
  }

  network_interface {
    subnet_id = "e9b7ltjppp3nrkuemo66"
    nat       = true
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "db01_instance" {
  name = "mysql-master"
  zone = "ru-central1-a"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd85e63v406oaqdjnc4b"
      size     = 10
    }
  }

  network_interface {
    subnet_id = "e9b7ltjppp3nrkuemo66"
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "db02_instance" {
  name = "mysql-slave"
  zone = "ru-central1-a"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd85e63v406oaqdjnc4b"
      size     = 10
    }
  }

  network_interface {
    subnet_id = "e9b7ltjppp3nrkuemo66"
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "app_instance" {
  name = "wordpress"
  zone = "ru-central1-a"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd85e63v406oaqdjnc4b"
      size     = 10
    }
  }

  network_interface {
    subnet_id = "e9b7ltjppp3nrkuemo66"
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "monitoring_instance" {
  name = "monitoring"
  zone = "ru-central1-a"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd85e63v406oaqdjnc4b"
      size     = 10
    }
  }

  network_interface {
    subnet_id = "e9b7ltjppp3nrkuemo66"
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "gitlab_instance" {
  name = "gitlab"
  zone = "ru-central1-a"

  resources {
    cores  = 8
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = "fd85e63v406oaqdjnc4b"
      size     = 30
    }
  }

  network_interface {
    subnet_id = "e9b7ltjppp3nrkuemo66"
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "runner_instance" {
  name = "runner"
  zone = "ru-central1-a"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd85e63v406oaqdjnc4b"
      size     = 30
    }
  }

  network_interface {
    subnet_id = "e9b7ltjppp3nrkuemo66"
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}
```

### Запуск Terraform

1. Выполним `terraform login`:
```
Retrieved token for user tcibizov


---------------------------------------------------------------------------------

                                          -                                
                                          -----                           -
                                          ---------                      --
                                          ---------  -                -----
                                           ---------  ------        -------
                                             -------  ---------  ----------
                                                ----  ---------- ----------
                                                  --  ---------- ----------
   Welcome to Terraform Cloud!                     -  ---------- -------
                                                      ---  ----- ---
   Documentation: terraform.io/docs/cloud             --------   -
                                                      ----------
                                                      ----------
                                                       ---------
                                                           -----
                                                               -


   New to TFC? Follow these steps to instantly apply an example configuration:

   $ git clone https://github.com/hashicorp/tfc-getting-started.git
   $ cd tfc-getting-started
   $ scripts/setup.sh

```

2. Выполним `terraform init`:
```
Initializing Terraform Cloud...

Initializing provider plugins...
- Reusing previous version of yandex-cloud/yandex from the dependency lock file
- Using previously-installed yandex-cloud/yandex v0.80.0

Terraform Cloud has been successfully initialized!

You may now begin working with Terraform Cloud. Try running "terraform plan" to
see any changes that are required for your infrastructure.

If you ever set or change modules or Terraform Settings, run "terraform init"
again to reinitialize your working directory.
```
3. Выполним `terraform validate`:
```
Initializing Terraform Cloud...

Initializing provider plugins...
- Reusing previous version of yandex-cloud/yandex from the dependency lock file
- Using previously-installed yandex-cloud/yandex v0.80.0

Terraform Cloud has been successfully initialized!

You may now begin working with Terraform Cloud. Try running "terraform plan" to
see any changes that are required for your infrastructure.

If you ever set or change modules or Terraform Settings, run "terraform init"
again to reinitialize your working directory.
root@alex:/home/alex/dvpspdc# terraform validate
Success! The configuration is valid.
```
4. Выполним `terraform plan`:


