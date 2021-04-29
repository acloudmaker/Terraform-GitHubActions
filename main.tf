terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.26.0"
    }
  }
  required_version = "~> 0.14"

  backend "remote" {
    organization = "JDL-training"

    workspaces {
      name = "terraform-automation-with-github-actions"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "random" {}

resource "random_pet" "name" {}

resource "aws_instance" "web" {
  ami           = "ami-0742b4e673072066f"
  instance_type = "t2.micro"
  user_data     = file("init-script.sh")

  tags = {
    Name = random_pet.name.id
  }
}
