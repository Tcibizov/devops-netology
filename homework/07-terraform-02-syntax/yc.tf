terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "...........FT7Bqmw0Y"
  cloud_id  = "b1gsin4cial4tfskfcu9"
  folder_id = "b1gbmv9vnj1ko7uqevp7"
  zone      = "ru-central1-b"
}
