variable "zone" {
    type = string
    description = "Zone to update"
}

### List of records to add
## Each record will have the following
## name
## type
## ttl
## values
variable "records" {
    type = list
    description = "List of the records to be added"
}

