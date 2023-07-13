resource "yandex_vpc_network" "ansible" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "ansible" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.ansible.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "centos" {
  family = "centos-7"
}
