resource "aws_iam_role" "app" {
  name = "Ankush_app_ec2_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AllowEC2AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]

  })
  tags = {
    Name = "Ankush_app_ec2_role"
  }


}

resource "aws_iam_role_policy_attachment" "app_ssm" {
  role       = aws_iam_role.app.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "app" {
  name = "Ankush_app_instance_profile"
  role = aws_iam_role.app.name

  tags = {
    Name = "Ankush_app_instance_profile"
  }
}
