output "key_pair_name" {
  description = "The name of the generated key pair"
  value       = azurerm_ssh_public_key.example.name
}

output "private_key_path" {
  description = "The path to the private key file"
  value       = local_file.tf-key.filename
}

output "ssh_public_key" {
  value = azurerm_ssh_public_key.example.public_key
}