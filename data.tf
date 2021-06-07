data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "template_file" "script" {
  template = file("${path.module}/userdata.sh")
}


data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = true
  # Main cloud-config configuration file.
  part {
    content = data.template_file.script.rendered
  }
}