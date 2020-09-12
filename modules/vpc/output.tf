output "vpc_subnet_privs" {
    value = [ for ra in aws_route_table_association.rt_ass : ra.subnet_id if ra.route_table_id == aws_route_table.rt_priv.id ]
}

output "vpc_subnet_pubs" {
    value = [ for ra in aws_route_table_association.rt_ass : ra.subnet_id if ra.route_table_id == aws_route_table.rt_pub.id ]
}

output "id" {
    value = aws_vpc.vpc.id 
}