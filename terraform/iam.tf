resource "aws_iam_role_policy" "ecs_logging_inline" {
  name = "ecs-cloudwatch-logging"
  role = "ecsTaskExecutionRole"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}
