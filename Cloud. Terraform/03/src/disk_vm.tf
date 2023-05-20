#Создаем 3 идентичных виртуальных диска
resource "yandex_compute_disk" "virtual_disk" {
  
  count = 3
  
  name       = "virtual-disk-${count.index}"
  type       = "network-hdd"
  size       = 1 
}


#Создаем ВМ
resource "yandex_compute_instance" "test" {
  depends_on = [ yandex_compute_disk.virtual_disk ]
  name        = "netology-develop-platform-test"
  platform_id = "standard-v1"

  resources {
    cores  = 2
    memory = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type = "network-hdd"
      size = 5
    }   
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.virtual_disk
    content {
      disk_id = secondary_disk.value.id
      auto_delete = true
    }
  }

  metadata = {
    ssh-keys = local.ssh-keys
  }

  scheduling_policy { preemptible = true }

  network_interface { 
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat       = true
  }
  allow_stopping_for_update = true
}
