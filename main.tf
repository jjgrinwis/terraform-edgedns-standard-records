terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = ">= 5.0.1" 
    }
  }
}

locals {
  # regex to strip first part of a fqdn but it will return a list if using capture group ().
    # a.b.c => b.c; a.b.c.d => b.c.d
  domain_name = regex("^[^.]+\\.(.+\\.\\w+)$", var.fqdn)
}

# create our two required CNAME records
# _dmarc.<subdomain>.<domain>.<tld> CNAME parkeddomain.dmarc.customer.com
# _smtp._tls.<subdomain>.<domain>.<tld> CNAME tlsrpt.customer.com
resource "akamai_dns_record" "dmarc_record" {
    zone       = var.domain_name
    name       = "_dmarc.${var.fqdn}"
    recordtype = "CNAME"
    ttl        = 600
    target     = ["parkeddomain.dmarc.${local.domain_name}"]
}

resource "akamai_dns_record" "smtp_record" {
    zone       = var.domain_name
    name       = "_smtp._tls.${var.fqdn}"
    recordtype = "CNAME"
    ttl        = 1800
    target     = ["tlsrpt.${local.domain_name}"]
}

# and finally our TXT record
# <subdomain>.<domain>.<tld> TXT "v=spf1 -all"
resource "akamai_dns_record" "txt_record" {
    zone       = local.domain_name
    name       = var.fqdn
    recordtype = "TXT"
    ttl        = 300
    target     = ["v=spf1 -all"]
}