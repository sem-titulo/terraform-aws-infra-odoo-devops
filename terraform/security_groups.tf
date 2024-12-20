resource "aws_security_group" "ssh-public-traffic" {
  name        = "ssh-public-traffic-security-group"
  description = "Ssh public traffic"
  vpc_id      = aws_vpc.vpc_demo.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-public-traffic-security-group"
  }
}

resource "aws_security_group" "web-public-traffic" {
  name        = "web-public-traffic-security-group"
  description = "Web public traffic"
  vpc_id      = aws_vpc.vpc_demo.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-public-traffic-security-group"
  }
}