resource "aws_network_acl" "private" {
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

# allow Ephemeral return traffic from VPC
resource "aws_network_acl_rule" "ingress-private-100" {
  network_acl_id = "${aws_network_acl.private.id}"
  egress = false
  rule_number = 100
  rule_action = "allow"
  protocol = "tcp"
  from_port = 1024
  to_port = 65535
  cidr_block = "${var.vpc_cidr}"
}

#
# EGRESS
#

## 100 - allow tcp ephemeral traffic within VPC
resource "aws_network_acl_rule" "egress-private-100" {
  network_acl_id = "${aws_network_acl.private.id}"
  egress = true
  rule_number = 100
  rule_action = "allow"
  protocol = "tcp"
  from_port = 1024
  to_port = 65535
  cidr_block = "${var.vpc_cidr}"
}

## 110 - allow outbound SSH to VPC
resource "aws_network_acl_rule" "egress-private-110" {
  network_acl_id = "${aws_network_acl.private.id}"
  egress = true
  rule_number = 110
  rule_action = "allow"
  protocol = "tcp"
  from_port = 22
  to_port = 22
  cidr_block = "${var.vpc_cidr}"
}
