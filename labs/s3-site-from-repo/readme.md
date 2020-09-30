# S3 Static site autoupdated from a repo using lambda functions and a CodeCommit trigger

## Lab objectives

This lab will create all the resources required to handle an static site that updates automatically every time that some one push a new version of the web page to a CodeCommit code repository. 

Using CodeCommit trigger, a Lambda function is called to fetch the content and write it to S3. 

The lambda policy will have a resource policy that will enables the CodeCommit trigger to execute it, and it will need an IAM Role that allows it to write the S3 objects. 

*TODO:*
* Handle dyanmic sites using lambda versions updates nad API Gateways stages to automaticalle update also dynamic content code
* Add a webmaster user creation with permissions to manage objects in S3 and push and commit versions to the repo
* Add HTTPS support creating a certificate, a cloudfront distribution and 

## Steps 
* iam
  * Create a role for the Lambda function
  * Attach a predefined policy for any lambda func
* s3
  * Creates the bucket resource policy allowing public Get and Put only to Lambda role
  * Creates a policy to allow the Lambda func to write to the S3 bucket
  * Creates the bucket
  * Attaches the s3 lambda policy to the landa role
  * Optionally, register a DNS record pointing to the S3 website endpoint
* lambda
  * creates the lambda function
* codecommit
  * Creates a new codecommit repository
  * Create another policy for the lambda function allowing access to the repository
  * Attach the new policy to the Lambda role
  * Create a lambda permission policy allowing the CodeCommit to trigger the function
  * Creates a trigger in the CodeCommit repository pointing to the lambda func arn

To test the environemnt you will need git installed locally and setup the git/sshd client to update content, commit and push it to the repo.

References:
* Lambda code was took from [Michael Niedermayr's article](https://medium.com/@michael.niedermayr/using-aws-codecommit-and-lambda-for-automatic-code-deployment-to-s3-bucket-b35aa83d029b)