# Create outputs.tf for dev environment

output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = module.networking.public_subnet_id
}

output "security_group_id" {
  description = "Security group ID"
  value       = module.networking.security_group_id
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = module.compute.instance_id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.compute.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = module.compute.public_dns
}

output "web_server_url" {
  description = "URL to access the web server"
  value       = "http://${module.compute.public_ip}"
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i your-key.pem ec2-user@${module.compute.public_ip}"
}

