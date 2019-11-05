resource "aws_vpc" "terra_vpc" {
  cidr_block           = "${var.aws_ip_cidr_range}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Terraform-VPC"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = "${aws_vpc.terra_vpc.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.terra_vpc.cidr_block, 3, 1)}"
  availability_zone       = "${var.availability_zones["zone1"]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.subnet1}"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = "${aws_vpc.terra_vpc.id}"
  cidr_block              = "${cidrsubnet(aws_vpc.terra_vpc.cidr_block, 2, 2)}"
  availability_zone       = "${var.availability_zones["zone2"]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.subnet2}"
  }
}

//attach igw to terra-vpc
resource "aws_internet_gateway" "terra-gw" {
  vpc_id = "${aws_vpc.terra_vpc.id}"

  tags = {
    Name = "Terra-Internet-Gateway"
  }
}

//add route with target as igw to the main route table
resource "aws_default_route_table" "default-rt" {
  default_route_table_id = "${aws_vpc.terra_vpc.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.terra-gw.id}"
  }

  tags = {
    Name = "Terraform:Default-Route"
  }
}
