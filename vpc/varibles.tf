variable "v_main_vpc" {
  description = "CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "v_private_subnet" {
  description = "CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "v_availability_zone" {
  description = "CIDR block"
  type        = string
  default     = "eu-west-2a"
}
