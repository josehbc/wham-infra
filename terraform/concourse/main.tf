variable "aws_region"              { default = "us-east-1" }
variable "password"            {}

provider "aws" {
  region = "${var.aws_region}"
}

module "concourse" {
  source = "github.com/saksdirect/aws-ref-arch/terraform/concourse"

  security_group_id = "sg-5cf20e2c"
  subnet_id = "subnet-7beca033"
  db_subnet_group = "concourse_postgres"
  iam_instance_profile = "Concourse_Role"
  hbc_banner = "multi"
  hbc_env = "multi"
  hbc_group = "wham"
  team_name = "wham"
  instance_type = "t2.large"
  concourse_username = "concourse"
  concourse_password = "${var.password}"
  key_name = "wham_key"
  worker_volume_size = "100" 
  web_volume_size = "50"
  db_username = "postgres"
  db_password = "${var.password}"
  db_storage_size = "100"
  db_instance_class = "db.t2.large"
  db_security_groups = "sg-5cf20e2c"
  db_security_group_id = "sg-5cf20e2c"
}

terraform {
  backend "s3" {
    bucket = "terraform.wham"
    key    = "state/concourse/terraform.tfstate"
    region = "us-east-1"
  }
}