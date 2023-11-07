variable "public_cidr" {
  type = list(string)
}

variable "availability_zone" {
  type = list(string)
}

variable "public_subnet_name" {
  type = string
}

variable "private_cidr" {
  type = list(string)
}

variable "private_subnet_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "route_table_id" {
  type = string
}


