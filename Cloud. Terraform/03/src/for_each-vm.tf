#Создаем "неидентичные" ВМ
resource "yandex_compute_instance" "db" {
  
  depends_on = [ yandex_compute_instance.web ] 
  
  for_each = { for vm in var.vms_db: vm.vm_name => vm }
  platform_id = "standard-v1"
  name = each.value.vm_name
  
  resources {
    cores  = each.value.cpu
    memory = each.value.ram
    core_fraction = each.value.core_frac
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type = "network-hdd"
      size = each.value.disk
    }   
  }

  metadata = {
    ssh-keys = local.ssh-keys
  }

  scheduling_policy { preemptible = true }

  network_interface { 
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true
}


