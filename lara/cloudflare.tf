provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_zone" "this" {
  account_id = var.cloudflare_account_id
  zone       = var.domain_name
}

resource "cloudflare_record" "app" {
  zone_id = cloudflare_zone.this.id
  name    = var.app_subdomain
  value   = module.alb.alb_dns_name
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_page_rule" "https" {
  zone_id = cloudflare_zone.this.id
  target  = "${var.app_subdomain}.${var.domain_name}/*"
  priority = 1

  actions {
    always_use_https = true
  }
}

resource "cloudflare_page_rule" "cache" {
  zone_id = cloudflare_zone.this.id
  target  = "${var.app_subdomain}.${var.domain_name}/static/*"
  priority = 2

  actions {
    cache_level = "cache_everything"
    edge_cache_ttl = 86400
  }
} 