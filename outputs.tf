data "local_file" "private_key_pem" {
  depends_on = [null_resource.save_keys]
  filename = "${path.module}/key"
}

output "private_key_pem" {
  depends_on = [null_resource.save_keys]
  description = "The private key ready."
  value       = data.local_file.private_key_pem.content
  sensitive = true
}

data "local_file" "public_key_openssh" {
  depends_on = [null_resource.save_keys]
  filename = "${path.module}/key.pub"
}

output "public_key_openssh" {
  depends_on = [null_resource.save_keys]
  description = "The public key ready."
  value       = data.local_file.public_key_openssh.content
  sensitive = true
}