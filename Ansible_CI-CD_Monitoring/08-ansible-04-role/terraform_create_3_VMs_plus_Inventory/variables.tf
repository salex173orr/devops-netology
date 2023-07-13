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
  default     = "ansible"
  description = "VPC network&subnet name"
}

variable "public_key" {
  type        = string
  default     = "ssh-keygen -t ed25519"
  description = "ssh-keygen -t ed25519"
}

variable "vms_ansible" {
    type = list(object({
        vm_name         = string
        cpu             = number
        ram             = number
        disk            = number
        core_frac       = number
    }))
    default = [
        {
            vm_name         = "ansible-clickhouse-01"
            cpu             = 2
            ram             = 1
            disk            = 10
            core_frac       = 5
        },
        {
            vm_name         = "ansible-vector-01"
            cpu             = 2
            ram             = 1
            disk            = 10
            core_frac       = 20
        },
        {
            vm_name         = "ansible-lighthouse-01"
            cpu             = 2
            ram             = 2
            disk            = 10
            core_frac       = 20
        }
    ]
}

