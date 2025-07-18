# ECS Cluster
resource "aws_ecs_cluster" "akash_cluster" {
  name = "akash-cluster"
}

# Task Execution Role

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

# Security Group for ECS
resource "aws_security_group" "ecs_sg" {
  name        = "akash-ecs-sg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "akash-ecs-sg"
  }
}

# ECS Task Definition
resource "aws_ecs_task_definition" "akash_task" {
  family                   = "akash-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn

container_definitions = jsonencode([
  {
    name      = "akash-container",
    image     = "${aws_ecr_repository.akash_app_repo.repository_url}@sha256:0fa0cc99e8b723dd0b006a7031082adc6e7b054ca1a38b12830472dbd4e7d9d5",
    essential = true,
    portMappings = [
      {
        containerPort = 5000,
        protocol      = "tcp"
      }
    ],
    environment = [
      {
        name  = "REDEPLOY_TAG",
        value = "v5"
      }
    ],
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group         = "/ecs/akash-container",
        awslogs-region        = "ap-south-1",
        awslogs-stream-prefix = "ecs"
      }
    }
  }
])
}

# ECS Service
resource "aws_ecs_service" "akash_service" {
  name            = "akash-service"
  cluster         = aws_ecs_cluster.akash_cluster.id
  task_definition = aws_ecs_task_definition.akash_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public_subnet.id]
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

#   depends_on = [
#     aws_iam_role_policy_attachment.ecs_task_exec_policy
#   ]
}



resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/akash-container"
  retention_in_days = 7
}
