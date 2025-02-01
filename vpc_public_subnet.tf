resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.new_vpc.id
    assign_ipv6_address_on_creation = false
    map_public_ip_on_launch = true
    cidr_block= "192.10.1.0/24"
    availability_zone = "us-east-1a"

}



resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.new_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-internet-gateway.id
    }
}

resource "aws_route_table_association" "public_routetable_subnet_attach" {
    
  subnet_id=aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_eip" "nat_eip" {
}

resource "aws_nat_gateway" "my-nategateway" {
  
  subnet_id = aws_subnet.public_subnet.id
  allocation_id = aws_eip.nat_eip.id

}



# instance inside the public subnet
resource "aws_instance" "public_ec2" {
    instance_type= "t2.micro"
    ami = "ami-0c614dee691cbbf37"
    key_name= "keypair"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids= [aws_security_group.public_sg.id]

    tags = {
      Name = "public-web-app" 
    }


    root_block_device {
      volume_size = 10
      volume_type = "gp3"
    }

}


# as a web application you don't need for an external EBS volume 


# resource "aws_ebs_volume" "web_ebs" {
#     size= 20
#     type = "gp3"
#     availability_zone = aws_instance.public_ec2.availability_zone

#     tags = {
#         Name="web_ebs"
#     } 
# }

# resource "aws_volume_attachment" "ec2_ebs_attach" {

#     instance_id= aws_instance.public_ec2.id
#     volume_id = aws_ebs_volume.web_ebs.id
#     device_name = "/dev/xvdf"
# }



