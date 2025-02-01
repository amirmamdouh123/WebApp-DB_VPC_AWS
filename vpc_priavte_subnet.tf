resource "aws_subnet" "private_subnet" {
  
  vpc_id = aws_vpc.new_vpc.id
  cidr_block = "192.10.2.0/24"
  map_public_ip_on_launch=false
  assign_ipv6_address_on_creation = false
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-subnet"
  }


}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.new_vpc.id
  route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.my-nategateway.id
  }

}

resource "aws_route_table_association" "private_routetable_subnet_association" {
  
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}




resource "aws_instance" "db_instance" {
  
    instance_type="t2.small"
    ami = "ami-0c614dee691cbbf37"
    subnet_id = aws_subnet.private_subnet.id
    vpc_security_group_ids= [aws_security_group.private_db_sg.id]

    root_block_device {
      volume_size = 8
      volume_type = "gp3"
    }

    tags = {
        Name = "db_instance"
    } 

}


resource "aws_ebs_volume" "db_ebs_volume" {
  size = 10
  type = "gp3"
  availability_zone = aws_instance.db_instance.availability_zone

    tags ={
        Name= "db_ebs_volume"
     }
}

resource "aws_volume_attachment" "db_ebs_attach" {
  instance_id = aws_instance.db_instance.id
  volume_id = aws_ebs_volume.db_ebs_volume.id
  device_name = "/dev/sdf"
}



