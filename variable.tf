variable "ami_id" {
  type = string
  default = "ami-02b8269d5e85954ef" #ubuntu server 20.04 LTS in ap-south-1
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "ec2_root_volume_size" {
  type = number
  default = 8
}