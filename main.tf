provider "aws"{

region= "us-east-1"

}

# resource "aws_instance" "my_instance"{

# ami = "ami-0c614dee691cbbf37"
# instance_type= "t2.small"
# key_name = "keypair"

# tags = {
    
#         Name = "MyFirstInstance"
#     }
# }

resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  user= aws_iam_user.mamdouh.name
  policy_arn=aws_iam_policy.my_policy.arn
}












