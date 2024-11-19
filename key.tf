


// los key pair de la instancia los subimos aca con la clave ssh creada
resource "aws_key_pair" "nginx-server-ssh" {

    key_name = "${var.server_name}-ssh"
    public_key = file("${var.server_name}.key.pub")

}