output "redis_endpoint" {
  description = "Redis primary endpoint"
  value       = aws_elasticache_cluster.this.cache_nodes[0].address
}

output "redis_port" {
  description = "Redis port"
  value       = aws_elasticache_cluster.this.cache_nodes[0].port
}
