resource "aws_instance" "smp-iac-webserver" {
  ami = "${var.aws_ec2_ami}"
  count = "${var.aws_ec2_instance_count}"
  instance_type = "${var.aws_ec2_instance_type}"
  key_name = "${var.aws_ec2_key_name}"
  iam_instance_profile = "${aws_iam_role.smp_iac_ec2_instance.name}"
  vpc_security_group_ids = ["${aws_security_group.smp_iac_sg_ssh.id}","${aws_security_group.smp_iac_sg_http.id}"]
  availability_zone = "${lookup(var.aws_ec2_zones, count.index)}"
  subnet_id = "${element(aws_subnet.pub_sub.*.id, count.index)}"

  // this is the file created when you run the launch script (launch.sh)
  connection {
    user = "ec2-user"
    private_key = "${file(var.aws_ec2_key_path)}"
  }

  // provision each instance with nginx and a custom index page
  provisioner "remote-exec" {
    inline = [
      "sudo yum -y update",
      "sudo yum -y install nginx",
      "sudo service nginx start",
      "sudo mkdir /var/www",
      "sudo mkdir /var/www/smp-iac-terraform",
      "echo 'Automation for the People!' | sudo tee -a /var/www/smp-iac-terraform/index.html",
      "sudo cp /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html.bak",
      "sudo rm -f /usr/share/nginx/html/index.html",
      "sudo ln -s /var/www/smp-iac-terraform/index.html /usr/share/nginx/html/index.html",
      "sudo service nginx restart"
    ]
  }

  tags {
    Name = "${var.aws_ec2_instance_name}${count.index + 1}"
    Client = "Stelligent"
    Project = "SMP"
  }
}