resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
       Name  = "${var.name}-vpc"
    }
}
resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name  = "${var.name}-igw"
    }
}
data "aws_availability_zones" "availability_zones" {
}

resource "aws_subnet" "public_subnet_1a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_1a_cidr
    availability_zone = data.aws_availability_zones.availability_zones.names[0]
    map_public_ip_on_launch = true
    tags = {
        Name  = "pub_sub_1a"
    }
}
resource "aws_subnet" "public_subnet_2b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_2b_cidr
    availability_zone = data.aws_availability_zones.availability_zones.names[1]
    map_public_ip_on_launch = true
    tags = {
        Name  = "pub_sub_2b"
    }
}
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
    tags = {
        Name  = "public-rt"
    }
}
resource "aws_route_table_association" "napub-sub-1a_route_table_association" {
    subnet_id = aws_subnet.public_subnet_1a.id
    route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "napub-sub-2b_route_table_association" {
    subnet_id = aws_subnet.public_subnet_2b.id
    route_table_id = aws_route_table.public_route_table.id  
}
# app private subnets
resource "aws_subnet" "private_subnet_3a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_3a_cidr
    availability_zone = data.aws_availability_zones.availability_zones.names[0]
    map_public_ip_on_launch = false
    tags = {
        Name  = "pri_sub_3a"
    }  
}
resource "aws_subnet" "private_subnet_4b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_4b_cidr
    availability_zone = data.aws_availability_zones.availability_zones.names[1]
    map_public_ip_on_launch = false
    tags = {
        Name  = "pri_sub_4b"
    }  
}
#data private subnets
resource "aws_subnet" "private_subnet_5a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_5a_cidr
    availability_zone = data.aws_availability_zones.availability_zones.names[0]
    map_public_ip_on_launch = false
    tags = {
        Name  = "pri_sub_5a"
    }
}
resource "aws_subnet" "private_subnet_6b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_6b_cidr
    availability_zone = data.aws_availability_zones.availability_zones.names[1]
    map_public_ip_on_launch = false
    tags = {
        Name  = "pri_sub_6b"
    }
}
