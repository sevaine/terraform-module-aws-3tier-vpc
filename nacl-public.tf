resource "aws_network_acl" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
}
#
# NACL - rule ordering
#
# 100-499   - internal vpc traffic
# 500-999   - cross account vpc traffic
# 1000-1500 - external traffic
#

#
# INGRESS
#

## TCP return ( ephemeral ) traffic from VPC
resource "aws_network_acl_rule" "public-ingress-100" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number = 100
  egress = false
  protocol = "tcp"
  rule_action = "allow"
  cidr_block = "${var.vpc_cidr}"
  from_port = 1024
  to_port = 65535
}

## Allow SSH from data cidrs
resource "aws_network_acl_rule" "public-ingress-110" {
  count = "${length(var.private_cidrs)}"
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number = "${110 + count.index}"
  egress = false
  rule_action = "allow"
  protocol = "tcp"
  cidr_block = "${var.private_cidrs[count.index]}"
  from_port = 22
  to_port = 22
}

#
# EGRESS
#

## deny TCP all traffic to data tier
resource "aws_network_acl_rule" "public-egress-101" {
  count = "${length(var.data_cidrs)}"
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number = "${101 + count.index}"
  egress = true
  rule_action = "deny"
  protocol = "-1"
  cidr_block = "${var.data_cidrs[count.index]}"
  from_port = "-1"
  to_port = "-1"
}

## allow TCP return ( ephemeral ) outbound
resource "aws_network_acl_rule" "public-egress-1001" {
  network_acl_id = "${aws_network_acl.public.id}"
  rule_number = 1001
  egress = true
  rule_action = "allow"
  protocol = "tcp"
  cidr_block = "0.0.0.0/0"
  from_port = 1024
  to_port = 65535
}
