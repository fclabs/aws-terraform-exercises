
### Search resources
data "aws_route53_zone" "zone" {
    name = var.zone
}

resource "aws_route53_record" "r" {
    count = length( var.records )

    zone_id = data.aws_route53_zone.zone.zone_id

    name = lookup ( var.records[ count.index ] , "name" )
    ttl  = lookup ( var.records[ count.index ] , "ttl" )
    type  = lookup ( var.records[ count.index ] , "type" )
    records = lookup ( var.records[ count.index ] , "values" )
}