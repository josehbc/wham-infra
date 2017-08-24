variable "region"              { default = "us-east-1" }

module "bastion" {
  source                       = "github.com/saksdirect/aws-ref-arch/terraform/bastion"

  availability_zones = [
    "${data.aws_availability_zones.available.names[0]}",
    "${data.aws_availability_zones.available.names[1]}"
  ]
  bastion_ami = "ami-a4c7edb2"
  bastion_subnet_ids           = ["subnet-7beca033", "subnet-809e0aac"]
  bastion_security_groups      = ["sg-df68f9af"]
  team_name = "wham"
  keys_file = "${data.template_file.authorized_keys.rendered}"

}

data "aws_availability_zones" "available" {}

data "template_file" "authorized_keys" {
  template = "${file("${path.root}/authorized_keys")}"
}

terraform {
  backend "s3" {
    bucket = "terraform.wham"
    key    = "state/bastion/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "${var.region}"
}
