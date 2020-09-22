
## Map
# name: path of the parameter. Needs to start with /
# type: String, StrinList or SecretString
# value: value of the parameter
variable "params" {
    type = list
    description = "List maps with all the parameters to be created"
}

variable "key_id" {
    type = string
    description = "KMS Key alias to be used to encrypt parameters"
    default = null
}