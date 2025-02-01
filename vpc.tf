
resource "aws_vpc" "new_vpc" {

    
    cidr_block="192.10.0.0/16"

    tags = {
      Name = "new_vpc"
    }
  
}


resource "aws_internet_gateway" "my-internet-gateway" {
    vpc_id= aws_vpc.new_vpc.id
    tags ={
        Name= "my-internet-gateway"
    }
}





















# resource "aws_instance" "my_instance"{

#     ami = "ami-0c614dee691cbbf37"
#     instance_type= "t2.small"
#     key_name = "keypair"
#     subnet_id = aws_subnet.public_subnet.id
#     security_groups = [aws_security_group.public_sg.name]
#     tags = {
        
#             Name = "MyFirstInstance"
#         }




# }
