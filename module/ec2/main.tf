resource "aws_instance" "two-tier-web-server" {
  count           = 2
  ami             = "ami-01bc990364452ab3e"
  instance_type   = "t2.micro"
  security_groups = [var.sg_id]
  subnet_id       =  var.public_subnet_id[count.index]
  key_name        = "two-tier-key"

  tags = {
    Name = "two-tier-web-server-${count.index + 1}"
  }

  user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y 
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
}
