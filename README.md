# Terraform script to create and test AWS Lab Excercises

## Introduction

This series of exercises help you to undertand all the resources and services included in the AWS Certificated Associated Exam. For the exam you will need to know how to create them through the AWS Console, but this terraform script will help you to setup each resource and them been able to test configurations or compare results.

Additionally, you can use them as a reference about how to create AWS resources with terraform.

To run them, you will need to have terraform installed. Run them going in each directory using make:

```
cd lab
make apply
```

Don't forget to destray all the created resources, that probable will cost you $$$. ```make destroy```will eliminate AWS resources and ```make clean``` will also clean terraform state files. 

```
cd lab
make clean
```

## [Elastic Load Balancer Classic and Health-Checkers](elb-classic-lab/)

Creates A VPC with two subnets in different subnets, an Instance in each subnet and a classic ELB with an HTTP health-check

## [Elastic Load Balancer Application and Health-Checkers](elb-alb-lab/)

Creates A VPC with two subnets in different subnets, an Instance in each subnet and an Application ELB with an HTTP listener, a target group and a sample rule.

