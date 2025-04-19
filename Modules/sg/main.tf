resource "aws_security_group" "alb_sg" {
    name = "alb_sg"
    vpc_id = var.vpc_id
    
    ingress {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "HTTPS"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks =  ["0.0.0.0/0"]
    }
    egress {
        description = "All outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    tags = {
        Name = "alb_sg"
    }
}
resource "aws_security_group" "client_sg"{
    name = "client_sg"
    description = "allow ALB sg to access at port 80 http/https"
    vpc_id = var.vpc_id
    ingress {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        security_groups = [aws_security_group.alb_sg.id]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "client_sg"
    }
}
resource "aws_security_group" "db_sg"{
    name = "db_sg"
    description = "allow client sg to access at port 3306 mysql"
    vpc_id = var.vpc_id
    ingress {
        description = "MySQL"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        security_groups = [aws_security_group.client_sg.id]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "db_sg"
    }
}
