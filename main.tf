



provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "nginx-server" {

    ami = "ami-o440d3b780d96b29d"
    instance_type = "t3.micro"
    // agregamos user data - script de aws que ejecuta al inicializar la maquina
  
    user_data = <<-EOF
                #!/bin/bash
                sudo yum install -y nginx
                sudo systemctl enable nginx
                sudo systemctl start nginx
                EOF

    key_name = aws_key_pair.nginx-server-ssh.key_name
    vpc_security_group_ids = [ aws_security_group.nginx-server-sg ]

    tags = {
      Name = "nginx-server"
      Enviroment = "test"
    }
}


// los key pair de la instancia los subimos aca con la clave ssh creada
resource "aws_key_pair" "nginx-server-ssh" {

    key_name = "nginx-server-ssh"
    public_key = file("nginx-server.key.pub")

}

// creamos sg para la instancia para poder activar el puerto 22 y 80

resource "aws_security_group" "nginx-server-sg" {

    name = "nginx-server-sg"
    description = "Sg group allowing SSH and HTTP access"

    ingress = [{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    },
    {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }]

    // indica que puede salir por todos los puertos
    egress = {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }


}








