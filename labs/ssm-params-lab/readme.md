# SS Paramater Manager Lab

## Lab objective

Learn about AWS SSM Paramater use in AWS objects. The lab creates a group of parameters and a lambda funcion that use them.

This labs also use a shared S3 backend tfstate file, so you don't have it, you need to setup the backen using the [setup-s3-backend lab](/setup-s3-backend).

## Labs steps

* iam
  * Creates the lamba profiles required to access the parameters
* create-ssm-params
  * Create all the parameters in the SSM object
* lambda
  * create the lambda function
