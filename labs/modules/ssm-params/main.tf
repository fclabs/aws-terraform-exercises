resource "aws_ssm_parameter" "p" {
    count = length( var.params )

    name        = lookup( var.params[ count.index ] , "name" )
    type        = lookup( var.params[ count.index ] , "type" )
    value       = lookup( var.params[ count.index ] , "value" )

    key_id = var.key_id
}
