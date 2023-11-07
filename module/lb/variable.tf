variable "lb_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "lb_sg_id" {
  type = string
}

variable "public_subnet_id" {
  type = list(string)
}

variable "ec2_instance_id" {
  type = list(string)
}