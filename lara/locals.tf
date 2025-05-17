locals {
  name_prefix = "${var.project}-${var.env}"
  redis_name  = "${local.name_prefix}-redis"
  alb_name    = "${local.name_prefix}-alb"
}