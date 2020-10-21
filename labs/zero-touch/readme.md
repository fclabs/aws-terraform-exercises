# Zero-Touch Prod model using CloudCommit, Lambda triggers and Terraform Instances

## Introduction

This labs will help you to create a Zero-Touch Prod resources using CloudCommit and a two stage approval process using SNS to mail admis. 

CloudCommit hold the code to be implemented in different branches and master is the production running code. Lambda triggers (based on CodeCommit changes) are used to created instances that will run terraform code and notify via SNS the result to the subscripted users.

There is going to be one common AMI to be used as base for Instances, and using user_data and ENVVARs, this instance will be configured. 

S3 and Dynamo DB is used as backend system, using a key-prefix to associate resources groups and avoid long plannings processes. See this [lab](../setup-s3-backend/readme.md) to create it.

Planning Instance will run with a planning Role, that read resources states but cannot make changes. It won't be able to modify tfplan file either.
Applying Instances will run with an Admin Role.

Lab steps:
* IAM
  * Creates Lambda Function Roles
  * Creates Instance Profiles for applying and planning instances
  * Attaches EC2, S3 & CodeCommit policies to instances roles
  * 
* codecommit
  * Creates CodeCommit repository
  * Creates CodeCommit policies for admins and devels
  * Attach CodeCommit policies to User Groups
Creates a Role and User Groups to enable users as Developers & Admins
* AMI
  * Creates an instance that install terraform on boot
  * Uses that instance as model for the AMI creation
  * Saves the AMI id in SSM-Params
* Lambda
  * Creates roles for applying and planning functions
  * Attaches CodeCommit and EC2 Creation policies to role
  * Creates functions for planning/applying



## References
* [Zero Touch Prod](https://www.usenix.org/conference/srecon19emea/presentation/czapinski)