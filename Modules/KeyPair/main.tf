resource "azurerm_ssh_public_key" "example" {
  name                = var.key_pair_name
  resource_group_name = var.resource_group_name
  location            = var.location
  public_key          = tls_private_key.rsa.public_key_openssh
  depends_on          = [ local_file.tf-key ]
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "${var.key_pair_name}.pem"
}