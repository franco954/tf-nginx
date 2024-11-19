

resource "aws_instance" "nginx-server" {

    ami = var.ami_id
    instance_type = var.instance_type
    // agregamos user data - script de aws que ejecuta al inicializar la maquina
  
    user_data = <<-EOF
                #!/bin/bash
                sudo yum install -y nginx
                sudo systemctl enable nginx
                sudo systemctl start nginx
                EOF

    key_name = aws_key_pair.nginx-server-ssh.key_name
    vpc_security_group_ids = [ aws_security_group.nginx-server-sg.id ]

    tags = {
      Name = var.server_name
      Enviroment = var.enviroment
    }
}