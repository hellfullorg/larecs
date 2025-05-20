# CloudWatch Log Group for ECS
resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${local.tfvars.name_prefix}"
  retention_in_days = 30

  tags = local.tfvars.tags
}

# CloudWatch Log Group for ALB
resource "aws_cloudwatch_log_group" "alb" {
  name              = "/aws/alb/${local.tfvars.name_prefix}"
  retention_in_days = 30

  tags = local.tfvars.tags
}

# CloudWatch Log Group for Redis
resource "aws_cloudwatch_log_group" "redis" {
  name              = "/aws/elasticache/${local.tfvars.name_prefix}"
  retention_in_days = 30

  tags = local.tfvars.tags
}

# CloudWatch Dashboard
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${local.tfvars.name_prefix}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ECS", "CPUUtilization", "ServiceName", "${local.tfvars.app_name}", "ClusterName", "${local.tfvars.cluster_name}"],
            ["AWS/ECS", "MemoryUtilization", "ServiceName", "${local.tfvars.app_name}", "ClusterName", "${local.tfvars.cluster_name}"]
          ]
          period = 300
          stat   = "Average"
          region = local.tfvars.aws_region
          title  = "ECS Service Metrics"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", module.alb.alb_arn_suffix],
            ["AWS/ApplicationELB", "TargetResponseTime", "LoadBalancer", module.alb.alb_arn_suffix]
          ]
          period = 300
          stat   = "Sum"
          region = local.tfvars.aws_region
          title  = "ALB Metrics"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ElastiCache", "CPUUtilization", "CacheClusterId", local.tfvars.redis_name],
            ["AWS/ElastiCache", "DatabaseMemoryUsagePercentage", "CacheClusterId", local.tfvars.redis_name]
          ]
          period = 300
          stat   = "Average"
          region = local.tfvars.aws_region
          title  = "Redis Metrics"
        }
      }
    ]
  })
}

# SNS Topic for Alerts
resource "aws_sns_topic" "alerts" {
  name = "${local.tfvars.name_prefix}-alerts"
  tags = local.tfvars.tags
}

# CloudWatch Alarms
resource "aws_cloudwatch_metric_alarm" "ecs_cpu" {
  alarm_name          = "${local.tfvars.name_prefix}-ecs-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period             = "300"
  statistic          = "Average"
  threshold          = "80"
  alarm_description  = "This metric monitors ECS CPU utilization"
  alarm_actions      = [aws_sns_topic.alerts.arn]

  dimensions = {
    ClusterName = local.tfvars.cluster_name
    ServiceName = local.tfvars.app_name
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_memory" {
  alarm_name          = "${local.tfvars.name_prefix}-ecs-memory"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period             = "300"
  statistic          = "Average"
  threshold          = "80"
  alarm_description  = "This metric monitors ECS memory utilization"
  alarm_actions      = [aws_sns_topic.alerts.arn]

  dimensions = {
    ClusterName = local.tfvars.cluster_name
    ServiceName = local.tfvars.app_name
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  alarm_name          = "${local.tfvars.name_prefix}-alb-5xx"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period             = "300"
  statistic          = "Sum"
  threshold          = "10"
  alarm_description  = "This metric monitors ALB 5XX errors"
  alarm_actions      = [aws_sns_topic.alerts.arn]

  dimensions = {
    LoadBalancer = module.alb.alb_arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "redis_cpu" {
  alarm_name          = "${local.tfvars.name_prefix}-redis-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ElastiCache"
  period             = "300"
  statistic          = "Average"
  threshold          = "80"
  alarm_description  = "This metric monitors Redis CPU utilization"
  alarm_actions      = [aws_sns_topic.alerts.arn]

  dimensions = {
    CacheClusterId = local.tfvars.redis_name
  }
}

resource "aws_sns_topic_policy" "alerts" {
  arn = aws_sns_topic.alerts.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudwatch.amazonaws.com"
        }
        Action   = "SNS:Publish"
        Resource = aws_sns_topic.alerts.arn
      }
    ]
  })
} 