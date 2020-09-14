# Wordpress Instance with RDS backend db

This labs creates an RDS Instance to support a WordPress Server and configures the Instance installing Wordpress and running the configuration script in the bootstrap script. Both instances run in a VPC.

The RDS instance is connected in a private subnet and the Web front end in a public subnet.

The lab divede three resource groups:
* Networking: Creates VPCs, subnets, Internet Gateeway, and allocates a Security Group for the servers
* Database: Creates RDS instance and the server Security Group as valid source for the RDS endpoint
* Server: Adds additional access for server Security group, creates the instance and create a route53 record with the server address

The approach of have resources groups let you minimize the impact of an error and help you to create different environments. A more modern approach of orchestration than the Makefile could be done with Terraform Cloud or other orchestrators.

The drawback, is that you need to query all the resources as data structures before you can use them.
