output "db_security_group" {
    value = aws_security_group.rds_sg.id
}

output "db_endpoint" {
    value = aws_db_instance.db.endpoint
}
