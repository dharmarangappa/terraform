# Get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Create EC2 Instance
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name

  # Bootstrap script to install and start web server
  user_data = <<-EOF
    #!/bin/bash
    # Update system
    yum update -y

    # Install Apache web server
    yum install -y httpd

    # Start and enable Apache
    systemctl start httpd
    systemctl enable httpd

    # Create a simple web page
    echo "<h1>Welcome to ${var.environment} environment!</h1>" > /var/www/html/index.html
    echo "<p>Server hosted on: $(hostname)</p>" >> /var/www/html/index.html
    echo "<p>Private IP: $(hostname -I)</p>" >> /var/www/html/index.html
    echo "<p>Deployed by Terraform</p>" >> /var/www/html/index.html
  EOF

  # Root volume configuration
  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name        = "web-server-${var.environment}"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
