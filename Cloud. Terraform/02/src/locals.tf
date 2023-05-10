locals {
 env = "develop"
 project = "platform"
 role1 = "web"
 role2 = "db"
 platform_name = "netology-${ local.env }-${ local.project }-${ local.role1 }"
 platform-db_name = "netology-${ local.env }-${ local.project }-${ local.role2 }"
 }
