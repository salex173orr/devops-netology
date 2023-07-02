resource "local_file" "prod" {
  content = <<-DOC
    ---
    clickhouse:
      hosts:
        ansible-clickhouse-01:
          ansible_host: ${yandex_compute_instance.ansible["ansible-clickhouse-01"].network_interface.0.nat_ip_address}
          ansible_user: centos

    vector:
      hosts:
        ansible-vector-01:
          ansible_host: ${yandex_compute_instance.ansible["ansible-vector-01"].network_interface.0.nat_ip_address}
          ansible_user: centos

    lighthouse:
      hosts:
        ansible-lighthouse-01:
          ansible_host: ${yandex_compute_instance.ansible["ansible-lighthouse-01"].network_interface.0.nat_ip_address}
          ansible_user: centos
    DOC
  filename = "../playbook/inventory/prod.yml"

  depends_on = [
    yandex_compute_instance.ansible
  ]
}
