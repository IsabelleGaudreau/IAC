# Because we don't want to scroll to find it!
output "address" {
  value = "${aws_elb.smp-iac-elb.dns_name}"
}