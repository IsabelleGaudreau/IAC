# Create a security group for the ELB so its accessible via the internet
resource "aws_security_group" "smp_iac_sg_elb" {
  name = "smp_iac_sg_elb"
  description = "ELB accessibility"
  vpc_id = "${aws_vpc.smp.id}"

  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "smp_iac_sg_elb"
    Client = "Stelligent"
    Project = "SMP"
  }
}

# Create a security group to limit/restrict SSH access
resource "aws_security_group" "smp_iac_sg_ssh" {
  name = "smp_iac_sg_ssh"
  description = "SSH whitelist"
  vpc_id = "${aws_vpc.smp.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${split(",", var.restricted_access_cidr_blocks)}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "smp_iac_sg_ssh"
    Client = "Stelligent"
    Project = "SMP"
  }
}

# Create a security group to grant access to the instances over HTTP
resource "aws_security_group" "smp_iac_sg_http" {
  name = "smp_iac_sg_http"
  description = "HTTP from the VPC"
  vpc_id = "${aws_vpc.smp.id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "smp_iac_sg_http"
    Client = "Stelligent"
    Project = "SMP"
  }
}
