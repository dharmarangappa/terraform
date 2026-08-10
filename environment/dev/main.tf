
resource "random_id" "suffix" {
  byte_length = 4
}

# Call the networking module
module "networking" {
  source = "../../modules/networking"

  environment        = "dev"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  aws_region         = "ap-south-1"
}

# Call the compute module
module "compute" {
  source = "../../modules/compute"

  environment        = "dev"
  project            = "terraform-devops"
  instance_type      = "t3.micro"
  subnet_id          = module.networking.public_subnet_id
  security_group_ids = [module.networking.security_group_id]
  key_name           = "devops" # IMPORTANT: Change this to your actual key name
}
