## General

1. Create the Terraform infrastructure.
1. Check for the outputs: the connection string to the database and the load balancer IP address.
1. Set in your Okta account, in the right application settingsh the new LB IP
1. Using Bastion you need to configure for each VM (in the .env file):
    - The LB IP and the DB url
    - Init the db (connec to to one of the VMs and run npm run initdb)
    - Restart the machines
1. You can change the default variables values in the .tfvars file



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.65 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.99.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vms"></a> [vms](#module\_vms) | ./modules/vms | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_bastion_host.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | resource |
| [azurerm_network_security_group.DataTierNSG](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.WebTierNSG](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_postgresql_flexible_server.postgresqlserver](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_configuration.db-config-no-ssl](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_private_dns_zone.dns-zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.virtual-network-link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.bastion-ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.state-week5-secure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.bastion-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of virtuall machines in the HA zone | `number` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Default location for all resources | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix name for all resources in resource group | `string` | n/a | yes |
| <a name="input_psotgres-administrator-login"></a> [psotgres-administrator-login](#input\_psotgres-administrator-login) | n/a | `string` | `"postgres"` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Default VM size | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_connection_string"></a> [db\_connection\_string](#output\_db\_connection\_string) | Connection string to the database |
| <a name="output_postgres-password"></a> [postgres-password](#output\_postgres-password) | Postgres password |
| <a name="output_psotgres-administrator-login"></a> [psotgres-administrator-login](#output\_psotgres-administrator-login) | Postgres username |
<!-- END_TF_DOCS -->