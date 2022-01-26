terraform {
	backend "s3" {
		bucket = "apps-terraform-config"
		key    = "portfolio/terraform.tfstate"
		region = "eu-central-1"
	}
}
