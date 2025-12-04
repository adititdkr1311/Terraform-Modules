data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"] # Official Amazon AMI owner ID

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "web" {
   count         = "${var.ec2_count}"
   ami           = data.aws_ami.amazon_linux_2.id
   instance_type = "${var.instance_type}"
   subnet_id     = "${var.subnet_id}"

   tags = {
     Name = "networknuts"
   }
}
