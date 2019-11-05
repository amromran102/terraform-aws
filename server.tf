data "aws_ami" "amazon_linux_2" {

  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "linux_server" {
  ami           = "${data.aws_ami.amazon_linux_2.id}"
  instance_type = "t3a.nano"
  ebs_optimized = true
  key_name      = "${var.key_name}"
  subnet_id     = "${aws_subnet.subnet1.id}"

  vpc_security_group_ids = [
    "${aws_vpc.terra_vpc.default_security_group_id}",
    "${aws_security_group.http.id}",
    "${aws_security_group.ssh.id}"
  ]

  root_block_device {
    volume_size           = 20
    delete_on_termination = true
  }
  ebs_block_device {
    device_name           = "/dev/sde"
    volume_size           = 50
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = "terraform-amazon-linux"
  }
  volume_tags = {
    Name = "terraform-amazon-linux"
  }
}

resource "aws_eip" "eip_linux" {
  instance         = "${aws_instance.linux_server.id}"
  vpc              = true
  public_ipv4_pool = "amazon"
}