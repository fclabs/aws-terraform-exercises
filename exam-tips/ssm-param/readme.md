# SSM Parameter Store

## Concepts

AWS Systems Manager Parameter Store provides secure, hierarchical storage for configuration data management and secrets management. You can store data such as passwords, database strings, Amazon Machine Image (AMI) IDs, and license codes as parameter values. You can store values as plain text or encrypted data. You can reference Systems Manager parameters in your scripts, commands, SSM documents, and configuration and automation workflows by using the unique name that you specified when you created the parameter.

Parameter Store offers these benefits:
* You can use a **secure, scalable, hosted secrets management service** with no servers to manage.
* Improve your security posture by **separating your data from your code**.
* **Store configuration** data and encrypted strings in hierarchies and track versions.
* **Control and audit access at granular levels**.

## Services that can reference SSM-Parameters
You can use Parameter Store parameters with other Systems Manager capabilities and AWS services to retrieve secrets and configuration data from a central store. Parameters work with Systems Manager capabilities such as Run Command, State Manager, and Automation. You can also reference parameters in a number of other AWS services, including the following:
* Amazon Elastic Compute Cloud (Amazon EC2)
* Amazon Elastic Container Service (Amazon ECS)
* AWS Secrets Manager
* AWS Lambda
* AWS CloudFormation
* AWS CodeBuild
* AWS CodePipeline
* AWS CodeDeploy

## Exam Tips
* **Store Secrets and centralized** values for distributed applications.
* Integrated with KMS to encrypt and decrypt values.
  
