
resource "aws_security_group" "public_sg" {
  
    name = "my-security-group"
    vpc_id    =aws_vpc.new_vpc.id

    ingress       {            
            from_port=22
            to_port  = 22
            protocol= "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
        
    ingress   {
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = [ "0.0.0.0/0" ]
        }
    

    egress {
            from_port = 0
            to_port = 0
            protocol = -1
            cidr_blocks = ["0.0.0.0/0"]
        }
}


resource "aws_security_group" "private_db_sg" {

    name = "db-secruity-group"
    vpc_id = aws_vpc.new_vpc.id

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["198.10.0.0/16"]         #  Replace with your app server subnet or security group
    }

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = -1
        security_groups= [aws_security_group.public_sg.id]  # ✅ السماح لأي Instance داخل نفس SG بالتواصل
    }

        egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}