output "vm_web_external_ip" {
  value = yandex_compute_instance.platform.network_interface.0.nat_ip_address
}

output "vm_db_external_ip" {
  value = yandex_compute_instance.platform-db.network_interface.0.nat_ip_address
}
