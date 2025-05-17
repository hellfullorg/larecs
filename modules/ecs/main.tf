resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.app_name
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = "512"
  memory                  = "1024"
  execution_role_arn      = var.execution_role_arn
  task_role_arn           = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "laravel"
      image     = var.laravel_image
      essential = true
      portMappings = [{
        containerPort = 9000
      }]
      environment = var.environment
    },
    {
      name      = "nginx"
      image     = var.nginx_image
      essential = true
      portMappings = [{
        containerPort = 80
      }]
      dependsOn = [{
        containerName = "laravel"
        condition     = "START"
      }]
    }
  ])
}

resource "aws_ecs_service" "this" {
  name            = var.app_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnet_ids
    assign_public_ip = true
    security_groups = var.security_group_ids
  }
}
