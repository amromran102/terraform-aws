variable "aws_ip_cidr_range" {
  default     = "10.0.1.0/24"
  type        = "string"
  description = "IP CIDR Range for AWS VPC"
}

variable "subnet" {
  type    = "string"
  default = "terra-subnet"
}

variable "availability_zones" {
  type = "map"
  default = {
    zone1 = "us-east-1a"
    zone2 = "us-east-1b"
    zone3 = "us-east-1d"
  }
}

locals {
  subnet1 = "${var.subnet}-${var.availability_zones["zone1"]}"
  subnet2 = "${var.subnet}-${var.availability_zones["zone2"]}"
  subnet3 = "${var.subnet}-${var.availability_zones["zone3"]}"
}

//Define a key-pair that already exsists
variable "key_name" {
  default = "aws-key-pair"
}

// Output variables

//Export the public ip for the launched instance
output "ec2_aws_public_ip" {
  value = "${aws_eip.eip_linux.public_ip}"
}
