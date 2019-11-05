resource "aws_security_group" "http" {
  vpc_id = "${aws_vpc.terra_vpc.id}"
  name   = "HTTP/s"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]

    from_port = 80
    protocol  = "tcp"
    to_port   = 80
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }
  tags = {
    Name = "HTTP/s"
  }
}

//Warning: it is best practice to limit ssh access to specific IPs
resource "aws_security_group" "ssh" {
  vpc_id = aws_vpc.terra_vpc.id
  name   = "SSH"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]

    from_port = 22
    protocol  = "tcp"
    to_port   = 22
  }
  tags = {
    Name = "SSH"
  }
}