module "mock-acp" {
  source = "github.com/ukhomeoffice/dq-tf-mock-acp"

  providers = {
    aws = "aws.MOCK"
  }

  acpvpn_cidr_block             = "10.4.0.0/16"
  acpvpn_vpc_subnet_cidr_block  = "10.4.1.0/24"
  acpprod_cidr_block            = "10.5.0.0/16"
  acpprod_vpc_subnet_cidr_block = "10.5.1.0/24"
  acpops_cidr_block             = "10.6.0.0/16"
  acpops_vpc_subnet_cidr_block  = "10.6.1.0/24"
  acpcicd_cidr_block            = "10.7.0.0/16"
  acpcicd_vpc_subnet_cidr_block = "10.7.1.0/24"
  az                            = "eu-west-2a"
  name_prefix                   = "dq-"

  acp_private_ips = {
    vpn_tester_ip  = "10.4.1.10"
    prod_tester_ip = "10.5.1.10"
    ops_tester_ip  = "10.6.1.10"
    cicd_tester_ip = "10.7.1.10"
  }

  route_table_cidr_blocks = {
    peering_cidr = "${module.peering.peeringvpc_cidr_block}"
    apps_cidr    = "${module.apps.appsvpc_cidr_block}"
    ops_cidr     = "${module.ops.opsvpc_cidr_block}"
  }

  vpc_peering_connection_ids = {
    peering_and_acpprod = "${module.peering_to_acpprod.peering_id}"
    peering_and_acpops  = "${module.peering_to_acpops.peering_id}"
    peering_and_acpcicd = "${module.peering_to_acpcicd.peering_id}"
    ops_and_acpvpn      = "${module.ops_to_acpvpn.peering_id}"
  }
}

output "acpopsvpc_id" {
  value = "${module.mock-acp.acpopsvpc_id}"
}

output "acpops_cidr_block" {
  value = "${module.mock-acp.acpops_cidr_block}"
}

output "acpcicdvpc_id" {
  value = "${module.mock-acp.acpcicdvpc_id}"
}

output "acpcicd_cidr_block" {
  value = "${module.mock-acp.acpcicd_cidr_block}"
}

output "acpprodvpc_id" {
  value = "${module.mock-acp.acpprodvpc_id}"
}

output "acpprod_cidr_block" {
  value = "${module.mock-acp.acpprod_cidr_block}"
}

output "acpvpnvpc_id" {
  value = "${module.mock-acp.acpvpnvpc_id}"
}

output "acpvpn_cidr_block" {
  value = "${module.mock-acp.acpvpn_cidr_block}"
}
