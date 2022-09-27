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
