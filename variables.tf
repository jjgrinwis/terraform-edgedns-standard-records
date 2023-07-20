variable "fqdn" {
    description = "The Fully Qualified Domain Name. First entry of the FQDN will be stripped for domain part."
    type = string
    validation {
      condition = can(regex("^[[:alnum:]-]+(?:\\.[[:alnum:]-]+)+\\.[[:alpha:]]{2,}$", var.fqdn))
    }
    error_message = "Invalid entry in the fqdn set, should be <subdomain>*.<domain>.<fqdn>"
}