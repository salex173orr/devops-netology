###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOUl2fo8iT6TQRiZIF0EYgtd6uHu54HYCTLrhuACc3+hnyMfxzRQUFig5N2JOwp0AzYHnvaMtCZnFRkuyksAOyKCywMfu1XUciyuggL03mIXVJqj4cQ8Vo8taNMqU3RiHaI4hqkiIboj5f4dv627y74WpGfPkZksodSFQhvFxW9HER/+SKsMpKTnO8lssCqohYRi/+0qkxxXhjBPBg3ZUhitYBWs9SWofU55MxPqmFJ1mWB3vAxZ5KJRD5rTLGyj8aA9/qgLIzFFM+fi04jrpJ18FJD0yPvKBKI8eIiAS+LBRbXbA3KdumCUWGBDDdQsCO0VtpKjMmiDkyw7Td6zd81ChXIFTPtSBRY5dYUbK1skmZ6o7BDVuc8t64VpYDvCxgD5cNOvB974/Nl+oZY6itd8ZU/wEgl8BGxtqCHyhn14oc07rfzaPsY1L08AvUH2tIdBeoQm26Wm0I0zhR8G4GNFOazLViK2j0PR+Asp3q0CxfjqFVDdBhjE8lz4XsMn0= alexandr_shtykov@Ubuntu-Netology"
  description = "ssh-keygen -t ed25519"
}

###map vars
variable "vm_web_resources" {
   type    = map(string)
   default = { cores = "2", memory = "1", core_fraction = "5"}
}

variable "vm_db_resources" {
   type    = map(string)
   default = { cores = "2", memory = "2", core_fraction = "20"}
}

variable "metadata" {
   type    = map(string)
   default = { serial-port-enable = "1", ssh-keys = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOUl2fo8iT6TQRiZIF0EYgtd6uHu54HYCTLrhuACc3+hnyMfxzRQUFig5N2JOwp0AzYHnvaMtCZnFRkuyksAOyKCywMfu1XUciyuggL03mIXVJqj4cQ8Vo8taNMqU3RiHaI4hqkiIboj5f4dv627y74WpGfPkZksodSFQhvFxW9HER/+SKsMpKTnO8lssCqohYRi/+0qkxxXhjBPBg3ZUhitYBWs9SWofU55MxPqmFJ1mWB3vAxZ5KJRD5rTLGyj8aA9/qgLIzFFM+fi04jrpJ18FJD0yPvKBKI8eIiAS+LBRbXbA3KdumCUWGBDDdQsCO0VtpKjMmiDkyw7Td6zd81ChXIFTPtSBRY5dYUbK1skmZ6o7BDVuc8t64VpYDvCxgD5cNOvB974/Nl+oZY6itd8ZU/wEgl8BGxtqCHyhn14oc07rfzaPsY1L08AvUH2tIdBeoQm26Wm0I0zhR8G4GNFOazLViK2j0PR+Asp3q0CxfjqFVDdBhjE8lz4XsMn0= alexandr_shtykov@Ubuntu-Netology" }
}


