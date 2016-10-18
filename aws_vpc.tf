# VPC to launch instances into
resource "aws_vpc" "smp" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags {
    Name = "smp-iac-vpc"
    Client = "Stelligent"
    Project = "SMP"
  }
}

#IGW to grant the subnet access to the outside world
resource "aws_internet_gateway" "smp" {
  vpc_id = "${aws_vpc.smp.id}"

  tags {
    Name = "smp-iac-igw"
    Client = "Stelligent"
    Project = "SMP"
  }
}

# Route traffic from the VPC's private instances to the IGW
resource "aws_route" "internet_access" {
  route_table_id = "${aws_vpc.smp.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.smp.id}"
}


# Create subnets spread across AZs to launch instances into
resource "aws_subnet" "pub_sub" {
  count = "${var.aws_ec2_instance_count}"
  cidr_block = "10.0.${count.index}.0/24"
  availability_zone = "${lookup(var.aws_ec2_zones, count.index)}"
  map_public_ip_on_launch = true
  vpc_id = "${aws_vpc.smp.id}"

  tags {
    Name = "smp-iac-subnet-${count.index + 1}"
    Client = "Stelligent"
    Project = "SMP"
  }
}
