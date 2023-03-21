# Network
resource "yandex_vpc_network" "default" {
  name = "my-yc-network"
}

resource "yandex_vpc_subnet" "default" {
  name = "my-yc-subnet-a"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.101.0/24"]
}
