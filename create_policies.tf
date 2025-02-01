resource "aws_iam_policy" "my_policy" {
  
    name = "my_policy"
    description = "IAM policy that allows full access to S3"
    policy= jsonencode({
        Version= "2012-10-17"
        Statement= [
            {
                Action= "s3:*"
                Effect= "Allow"
                Resource="*"
            }
        ]
    })


}