resource "aws_vpc" "main" {
   cidr_block       = "${var.vpc_cidr}"
   instance_tenancy = "${var.tenancy}"

   tags = {
     Name = "main"
   }
}

resource "aws_subnet" "main" {
   vpc_id     = "${var.vpc_id}"
   cidr_block = "${var.subnet_cidr}"

   tags = {
     Name = "Main"
  }
}

# code - creating IG and attaching it to VPC

resource "aws_internet_gateway" "vpcone-ig" {
	vpc_id = "${aws_vpc.main.id}"
	tags = {
		Name = "${var.env}"
	}
}


# code - modifying route

resource "aws_route_table" "rtb_public" {
	vpc_id = "${aws_vpc.main.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.vpcone-ig.id}"
	}
	tags = {
		Name = "${var.env}"
	}
}


# code - attaching subnets to route table

resource "aws_route_table_association" "rta_subnet_public" {
	subnet_id = "${aws_subnet.main.id}"
	route_table_id = "${aws_route_table.rtb_public.id}"
}


# code - create security group

resource "aws_security_group" "sg_newvpc" {
	name = "newvpc"
	vpc_id = "${aws_vpc.main.id}"

	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name = "${var.env}"
	}

}
