# Ubuntu AMI data source

data "aws_ami" "latest_ubuntu_image" {
  most_recent = true
  owners      = ["099720109477"]  # Canonical's AWS account ID for Ubuntu AMIs
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-*-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# New Ubuntu instance

resource "aws_instance" "my-server" {
  ami                         = data.aws_ami.latest_ubuntu_image.id
  instance_type               = var.instance_type
  key_name                    = "jenkins-server-demo"
  subnet_id                   = aws_subnet.jenkins-subnet-1.id
  vpc_security_group_ids      = [aws_default_security_group.default-sg.id]
  availability_zone           = var.availability_zone
  associate_public_ip_address = true
  user_data                   = file("jenkins-script.sh")
  tags = {
    Name = "${var.env_prefix}-server"
  }
}