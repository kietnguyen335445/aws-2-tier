resource "aws_eip" "eip-nat-a" {
    tags = {
      Name = "eip-nat-a"
    }
}
resource "aws_eip" "eip-nat-b" {
    tags = {
      Name = "eip-nat-b"
    }
}
resource "aws_nat_gateway" "natgw-a" {
    allocation_id = aws_eip.eip-nat-a.id
    subnet_id     = var.public_subnet_1a_id
    tags = {
      Name = "natgw-a"
    }
    depends_on = [var.igw_id]
}
resource "aws_nat_gateway" "natgw-b" {
    allocation_id = aws_eip.eip-nat-b.id
    subnet_id     = var.public_subnet_2b_id
    tags = {
      Name = "natgw-b"
    }
    depends_on = [var.igw_id] 
}
resource "aws_route_table" "pri-rt-a" {
    vpc_id = var.vpc_id
    route{
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.natgw-a.id
    }
    tags = {
        Name = "pri-rt-a"
    }
}
resource "aws_route_table_association" "pri-sub-3a-with-Pri-rt-a" {
    subnet_id = var.private_subnet_3a_id
    route_table_id = aws_route_table.pri-rt-a.id
}
resource "aws_route_table_association" "pri-sub-4b-with-Pri-rt-a"{
    subnet_id = var.private_subnet_4b_id
    route_table_id = aws_route_table.pri-rt-a.id
}
resource "aws_route_table" "pri-rt-b" {
    vpc_id = var.vpc_id
    route{
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.natgw-b.id
    }
    tags = {
        Name = "pri-rt-b"
    }
}
resource "aws_route_table_association" "pri-sub-5a-with-Pri-rt-b" {
    subnet_id = var.private_subnet_5a_id
    route_table_id = aws_route_table.pri-rt-b.id
}
resource "aws_route_table_association" "pri-sub-6b-with-Pri-rt-b" {
    subnet_id = var.private_subnet_6b_id
    route_table_id = aws_route_table.pri-rt-b.id
}
