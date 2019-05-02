resource "aws_network_acl" "data" {
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

# allow Ephemeral return traffic from private tier ( needed for forward proxy )
resource "aws_network_acl_rule" "ingress-data-100" {
  count = "${length(var.private_cidrs)}"
  network_acl_id = "${aws_network_acl.data.id}"
  egress = false
  rule_number = "${100 + count.index}"
  rule_action = "allow"
  protocol = "tcp"
  from_port = 1024
  to_port = 65535
  cidr_block = "${var.private_cidrs[count.index]}"
}

# allow inbound SSH traffic from private tier
resource "aws_network_acl_rule" "ingress-data-110" {
  count = "${length(var.private_cidrs)}"
  network_acl_id = "${aws_network_acl.data.id}"
  egress = false
  rule_number = "${110 + count.index}"
  rule_action = "allow"
  protocol = "tcp"
  from_port = 22
  to_port = 22
  cidr_block = "${var.private_cidrs[count.index]}"
}

#
# EGRESS
#

## 100 - allow outbound forwardproxy traffic to private tier
resource "aws_network_acl_rule" "egress-data-100" {
  count = "${length(var.private_cidrs)}"
  network_acl_id = "${aws_network_acl.data.id}"
  egress = true
  rule_number = "${100 + count.index}"
  rule_action = "allow"
  protocol = "tcp"
  from_port = 3128
  to_port = 3128
  cidr_block = "${var.private_cidrs[count.index]}"
}
