
variable "client_id" {
  default = ""
}

variable "client_secret" {
  default = ""
}

variable "tenant_id" {
  default = ""
}

variable "subscription_id" {
  default = ""
}

variable "web_server_location" {
  default = "West US"
}

variable "web_server_rg" {
  default = "a-task-called-quest"
}

#Labels resources we're creating in terraform
variable "resource_prefix" {
  default = "web-server"
}

#IP address range
variable "web_server_address_space" {
  default = "1.0.0.0/22"
}

variable "web_server_address_prefix" {
  default = "1.0.2.0/24" #What's this syntax here mean?
}

variable "web_server_name" {
  default = "web-01"
}




# You can also do this if you store it in a tfvars file SEE LINE 4 of main.tf
# variable_name = "some text"