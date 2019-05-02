resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.account-name} Internet Gateway"
  }
}

resource "aws_eip" "nat-gateway-eip" {
  count = "${var.nat_gateway}"
  vpc = true
  depends_on = ["aws_internet_gateway.internet-gateway"]
}

resource "aws_nat_gateway" "nat-gateway" {
  count = "${var.nat_gateway}"
  allocation_id = "${aws_eip.nat-gateway-eip-a.id}"
  subnet_id = "${aws_subnet.publicdmz-a-subnet.id}"
  tags {
    Name = "${var.account-name} NAT Gateway"
  }
  depends_on = ["aws_internet_gateway.internet-gateway"]
}
