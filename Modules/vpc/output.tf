output "region" {
  value = var.region
}
output "name" {
  value = var.name
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public_subnet_1a_id" {
    value = aws_subnet.public_subnet_1a.id
}
output "public_subnet_2b_id" {
    value = aws_subnet.public_subnet_2b.id
}
output "private_subnet_3a_id" {
    value = aws_subnet.private_subnet_3a.id
}
output "private_subnet_4b_id" {
    value = aws_subnet.private_subnet_4b.id
}
output "private_subnet_5a_id" {
    value = aws_subnet.private_subnet_5a.id  
}
output "private_subnet_6b_id" {
    value = aws_subnet.private_subnet_6b.id
}
output "igw_id" {
  value = aws_internet_gateway.internet_gateway.id
}
