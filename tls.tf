resource "tls_private_key" "this" {
  algorithm   = var.algorithm
  ecdsa_curve = var.ecdsa_curve
}

resource "null_resource" "save_keys" {
  triggers = {
    tls_private_key_algorithm = tls_private_key.this.algorithm
    tls_private_key_curve     = tls_private_key.this.ecdsa_curve
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo "${tls_private_key.this.private_key_pem}" > "${path.module}/key"
      echo "${tls_private_key.this.public_key_openssh}" > "${path.module}/key.pub"
    EOT
  }
  provisioner "local-exec" {
    when    = destroy
    command = "rm -f ${path.module}/key*"
  }
}
