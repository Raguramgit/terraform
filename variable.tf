variable "ags-security" {
  description = "ALB security group"
  type = list(string)
}

variable "ags-subnet-A" {
    description = "AGS subnet-A"
    type = string
  
}
variable "ags-subnet-B" {
    description = "AGS subnet-A"
    type = string
  
}

variable "ALB-target" {
  description = "value of alb_target_group_arn "
  type = string
}
variable "loadbalancer" {
  description = "value of alb_target_group_id "
  type = string
}