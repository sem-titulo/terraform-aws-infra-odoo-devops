data "template_file" "init_script" {
  template = file("${path.module}/init.sh.tpl")

  vars = {
    GIT_USER = var.git_user
    GIT_TOKEN = var.git_token
    GIT_REPOSITORY_URL = var.git_repository_url
    GIT_REPOSITORY_BRANCH = var.git_repository_branch
    PROJECT_NAME = var.project_name
  }
}


resource "aws_instance" "server" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = data.template_file.init_script.rendered

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = "30"
    volume_type = "gp2"
  }

  tags = {
    Name        = var.name
    Environment = var.env
    Provisioner = "Terraform"
  }

  vpc_security_group_ids = [aws_security_group.ssh-public-traffic.id, aws_security_group.web-public-traffic.id]
  private_ip             = "10.0.1.10"
  subnet_id              = aws_subnet.public_1.id
}

resource "aws_eip" "eip" {
  instance = aws_instance.server.id
  vpc      = true
}

output "public_ip" {
  value = aws_instance.server.public_ip
}