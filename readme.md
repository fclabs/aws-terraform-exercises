# Terraform script to create and test AWS Lab Excercises

## Introduction

This series of exercises help you to undertand all the resources and services included in the AWS Certificated Associated Exam. For the exam you will need to know how to create them through the AWS Console, but this terraform script will help you to setup each resource and them been able to test configurations or compare results.

Additionally, you can use them as a reference about how to create AWS resources with terraform.

To run them, you will need to have terraform installed. A sample secure.auto.tfvars is provided. This file is excluded from the repo ans is where you are going to setup all your credentials. See ```example-secrets.auto.tfvars``` at root folder. 

Run them going in each directory using make:

```
cd lab
make apply
```

Don't forget to destroy all the created resources, that probable will cost you $$$. ```make destroy```will eliminate AWS resources and ```make clean``` will also clean terraform state files. 

```
cd lab
make clean
```

## Labs
* [Wordpress Instance with RDS creation from bootscript. AMI Creation](wp-instance-w-rds-lab/)
* [AMI creation from Instance](ami-lab/)
* [Elastic Load Balancer Classic and Health-Checkers](elb-classic-lab/)
* [Elastic Load Balancer Application and Health-Checkers](elb-alb-lab/)
* [Autoscaling Groups with ELB Application and Health-Checkers and CPU target](auto-scaling/)
* [HA Wordpress deployment](ha-wordpress/)


