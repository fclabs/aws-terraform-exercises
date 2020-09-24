# Static Site creation on S3 with Lamda function

The idea behind this lab is to undertand the process of create an static site who uses lambda functions for static content. 
The code use API Gateways to route HTTP call to the right lambda function. 
Additionally, it use a base dir for static content, that is populated in the bucket with the correct content-type maping using a simple extension detector.
Finally, the site is published behind a route53 entry. If you don't have a domain registered, you can comment that last step, and access the S3 buchek using the website endpoint URL 

The lab goes throught the following steps:
* iam
  * Search a Lambda policy using a predefined policy (see [ssm-param-lab](ssm-param-lab/) to see how to create the policy from scratch)
  * Create a Role associated to the Lambda service
* lambda
  * Search the Role
  * Creates the Lambda function
* api
  * Search the Lambda function
  * Creates the API Gateway and target the Lambda function
  * With API Gateway created, added permissions to the Lambda function
  * With the API Gateway endpoint, update the index.html file using templates
* s3_site
  * Create the S3 bucket, with the public access and policies to be accessed directly
  * Calculate the mime types for all the files in the site folder
  * Upload each file as bucket objects
  * Create the www record in your DNS zone to point to the S3 website endpoint