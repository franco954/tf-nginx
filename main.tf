


terraform {
  backend "s3" {
    bucket = "curso-terraform-franale"
    key = "curso-tf/terraform.tfstate"
    region = "us-east-1"
  }
}



provider "aws" {
  region = "us-east-1"
}

module "nginx_server_dev" {
  source      = "./nginx_server_module"  
  ami_id      = var.ami_id               
  access_key  = var.access_key          
  secret_key  = var.secret_key           
  instance_type = var.instance_type      
  server_name = var.server_name         
  enviroment = var.enviroment        
}

module "nginx_server_qa" {
  source      = "./nginx_server_module"  
  ami_id      = var.ami_id               
  access_key  = var.access_key          
  secret_key  = var.secret_key           
  instance_type = var.instance_type      
  server_name = "nginx-server-qa"    
  enviroment = "qa"     
}


output "nginx_dev_ip" {
  
    description = "Direccion Ip Publica de la instancia EC2"
    value = module.nginx_server_dev.server_public_ip

}

output "nginx_dev_dns" {
  
    description = "Direccion Ip Publica de la instancia EC2"
    value = module.nginx_server_dev.server_public_dns

}


output "nginx_qa_ip" {
  
    description = "Direccion Ip Publica de la instancia EC2"
    value = module.nginx_server_qa.server_public_ip

}

output "nginx_qa_dns" {
  
    description = "Direccion Ip Publica de la instancia EC2"
    value = module.nginx_server_qa.server_public_dns

}

// declaracion en blanco para instancia ya existente a importar
resource "aws_instance" "web-server" {
    ami                                  = "ami-012967cc5a8c9f891"
    instance_type                        = "t2.micro"
    tags                                 = {
        "Name" = "miwebserver"
    }
    vpc_security_group_ids               = [
        "sg-02e32d92bc4db45d9",
    ]
}