resource "aws_elb" "smp-iac-elb" {
  name = "smp-iac-elb"

  security_groups = ["${aws_security_group.smp_iac_sg_elb.id}"]

  subnets = ["${aws_subnet.pub_sub.*.id}"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    target = "HTTP:80/index.html"
    interval = 10
    timeout = 2
  }

  instances = ["${aws_instance.smp-iac-webserver.*.id}"]
}