# CloudTrail
## Concepts

AWS CloudTrail is an AWS service that helps you enable governance, compliance, and operational and risk auditing of your AWS account. Actions taken by a user, role, or an AWS service are recorded as events in CloudTrail. Events include actions taken in the AWS Management Console, AWS Command Line Interface, and AWS SDKs and APIs.

CloudTrail is enabled on your AWS account when you create it. When activity occurs in your AWS account, that activity is recorded in a CloudTrail event. 

You can create two types of trails for an AWS account:
* A trail that applies to all regions
* A trail that applies to one region

**Trails will be viewable only in the AWS Regions where they log events**. If you create a trail that logs events in all AWS Regions, it will appear in the console in all AWS Regions. If you create a trail that only logs events in a single AWS Region, you can view and manage it only in that AWS Region.


## Exam Tips
* **Trails will be viewable only in the AWS Regions where they log events**. If you create a trail that logs events in all AWS Regions, it will appear in the console in all AWS Regions. If you create a trail that only logs events in a single AWS Region, you can view and manage it only in that AWS Region.
* **CloudTrail** is use to know **who did what in AWS**. **CloudWatch** focus in the **service and application logs**, not the API.
* **S3 object or any other data access logs are no CloudTrail events.**