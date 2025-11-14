resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_2_id

  tags = {
    Name = "WebServer"
  }
}