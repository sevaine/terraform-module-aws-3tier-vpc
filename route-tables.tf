#
# public subnets route table
#
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.account-shortname} public route table"
  }
}
#
# data subnets route table
#
resource "aws_route_table" "data" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.account-shortname} data route table"
  }
}
#
# data subnets route table
#
resource "aws_route_table" "data" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.account-shortname} data route table"
  }
}
