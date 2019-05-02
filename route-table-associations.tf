#
# public tier rt association
#
resource "aws_route_table_association" "public-rtassoc" {
  count = "${length(aws_subnet.public.*.id)}"
  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}

#
# private tier rt association
#
resource "aws_route_table_association" "private-rtassoc" {
  count = "${length(aws_subnet.private.*.id)}"
  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.id}"
}

#
# data tier rt association
#
resource "aws_route_table_association" "data-rtassoc" {
  count = "${length(aws_subnet.data.*.id)}"
  subnet_id      = "${aws_subnet.data.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}
