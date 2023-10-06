resource "tls_private_key" "this" {
  algorithm   = var.algorithm
  ecdsa_curve = var.ecdsa_curve
}

data "local_file" "private_key" {
  depends_on = [tls_private_key.this]
  content    = tls_private_key.this.private_key_pem
  filename   = "${path.module}/key"
}

data "local_file" "public_key" {
  depends_on = [tls_private_key.this]
  content    = tls_private_key.this.public_key_openssh
  filename   = "${path.module}/key.pub"
}