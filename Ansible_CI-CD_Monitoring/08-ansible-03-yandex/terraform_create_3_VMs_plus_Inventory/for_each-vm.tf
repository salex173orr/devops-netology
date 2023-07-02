#Создаем 3 ВМ
resource "yandex_compute_instance" "ansible" {
  
  for_each = { for vm in var.vms_ansible: vm.vm_name => vm }
  platform_id = "standard-v1"
  name = each.value.vm_name
  
  resources {
    cores  = each.value.cpu
    memory = each.value.ram
    core_fraction = each.value.core_frac
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos.image_id
      type = "network-hdd"
      size = each.value.disk
    }   
  }

  metadata = {
    ssh-keys = local.ssh-keys
  }

  scheduling_policy { preemptible = true }

  network_interface { 
    subnet_id = yandex_vpc_subnet.ansible.id
    nat       = true
  }
  allow_stopping_for_update = true
}


