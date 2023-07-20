# Project Name

A module to create 3 standard DNS records in EdgeDNS

## Description

Just fill in your fqdn and the module will add 3 records to EdgeDNS. 

```
_dmarc.<subdomain>.<domain>.<tld> CNAME parkeddomain.dmarc.<domain>.<tld>
_smtp._tls.<subdomain>.<domain>.<tld> CNAME tlsrpt.<domain>.<tld>
<subdomain>.<domain>.<tld> TXT "v=spf1 -all"
```

Make sure zone are available in EdgeDNS as module won't create them for you!

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Installation

Nothing to install, this is a module for Terraform Cloud.

## Usage

Just use this module and feed a set() of fqdn's to create these records for.

```
module "standard-records" {
  source  = "app.terraform.io/grinwis-com/standard-records/edgedns"
  version = "0.0.1"

  # just loop through our list of entries we would like to add.
  for_each = var.fqdn_set
  fqdn = each.value
}
```

## License

This project is licensed under the [MIT License](LICENSE).
