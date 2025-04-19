variable "name" {
}
variable "ami" {
  default = "ami-01938df366ac2d954"
}
variable "cpu" {
  default = "t2.micro"
}
variable "client_sg_id" {}
variable "max_size" {
  default = 2
}
variable "min_size" {
  default = 1
}
variable "desired_capacity" {
  default = 1
}
variable "asg_health_check_type" {
  default = "ELB"
}
variable "private_subnet_3a_id" {}
variable "private_subnet_4b_id" {}
variable "tg_arn" {}
