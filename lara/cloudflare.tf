# Temporarily disabled Cloudflare configuration
/*
provider "cloudflare" {
  api_token = local.tfvars.cloudflare_api_token
}

resource "cloudflare_zone" "this" {
  account_id = local.tfvars.cloudflare_account_id
  zone       = local.tfvars.domain_name
}

resource "cloudflare_record" "app" {
  zone_id = cloudflare_zone.this.id
  name    = local.tfvars.app_subdomain
  value   = module.alb.alb_dns_name
  type    = "CNAME"
  proxied = true
}
 
resource "cloudflare_page_rule" "https" {
  zone_id = cloudflare_zone.this.id
  target  = "${local.tfvars.app_subdomain}.${local.tfvars.domain_name}/*"
  priority = 1

  actions {
    always_use_https = true
  }
}

resource "cloudflare_page_rule" "cache" {
  zone_id = cloudflare_zone.this.id
  target  = "${local.tfvars.app_subdomain}.${local.tfvars.domain_name}/static/*"
  priority = 2

  actions {
    cache_level = "cache_everything"
    edge_cache_ttl = 86400
  }
}
*/ 