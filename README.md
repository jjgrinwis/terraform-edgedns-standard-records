# Project Name

A module to create 3 standard DNS records in EdgeDNS

## Description

Just fill in your fqdn and the module will add 3 records to EdgeDNS. 

```
_dmarc.<subdomain>.<domain>.<tld> CNAME parkeddomain.dmarc.<domain>.<tld>
_smtp._tls.<subdomain>.<domain>.<tld> CNAME tlsrpt.<domain>.<tld>
<subdomain>.<domain>.<tld> TXT "v=spf1 -all"
```

Make sure the zone is available in EdgeDNS as module won't create them for you!

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Installation

Nothing to install. Just use ```terraform login``` to create/use your token to be able to download this private module and set your EdgeDNS .edgerc credentials:

```
# $ export AKAMAI_CLIENT_SECRET="your_secret"
# $ export AKAMAI_HOST="your_host"
# $ export AKAMAI_ACCESS_TOKEN="your_access_token"
# $ export AKAMAI_CLIENT_TOKEN="your_client_token"
```

## Usage

Just use this module and feed a set() of fqdn's to create these records like in the example below.

```
module "standard-records" {
  source  = "app.terraform.io/grinwis-com/standard-records/edgedns"
  version = "0.0.4"

  # just loop through our list of entries we would like to add.
  for_each = var.fqdn_set
  fqdn = each.value
}
```

## License

This project is licensed under the [MIT License](LICENSE).
