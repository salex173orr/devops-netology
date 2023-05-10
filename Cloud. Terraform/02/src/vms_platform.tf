###vm_web vars

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu release name"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
  description = "platform_name"
}

### vm_db vars

variable "vm_db_platform" {
  type        = string
  default     = "standard-v1"
  description = "platform_name"
}

