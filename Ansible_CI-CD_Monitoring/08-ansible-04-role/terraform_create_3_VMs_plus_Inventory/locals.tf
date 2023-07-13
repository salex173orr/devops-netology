locals {
  ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
}
