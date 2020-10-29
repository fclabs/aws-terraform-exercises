# Cloud Formation

## Concept

AWS CloudFormation is a service that helps you **model and set up your Amazon Web Services** resources so that you can spend less time managing those resources and more time focusing on your applications that run in AWS. You create a template that describes all the AWS resources that you want (like Amazon EC2 instances or Amazon RDS DB instances), and AWS CloudFormation takes care of provisioning and configuring those resources for you. You don't need to individually create and configure AWS resources and figure out what's dependent on what; AWS CloudFormation handles all of that. The following scenarios demonstrate how AWS CloudFormation can help.
* Simplify infrastructure management
* Quickly replicate your infrastructure
* Easily control and track changes to your infrastructure

### Templates

An AWS CloudFormation template is a JSON or YAML formatted text file. You can save these files with any extension, such as .json, .yaml, .template, or .txt. AWS CloudFormation uses these templates as blueprints for building your AWS resources. For example, in a template, you can describe an Amazon EC2 instance, such as the instance type, the AMI ID, block device mappings, and its Amazon EC2 key pair name. Whenever you create a stack, you also specify a template that AWS CloudFormation uses to create whatever you described in the template.

### Stacks

When you use AWS CloudFormation, **you manage related resources as a single unit called a stack**. You create, update, and delete a collection of resources by creating, updating, and deleting stacks. All the resources in a stack are defined by the stack's AWS CloudFormation template. Suppose you created a template that includes an Auto Scaling group, Elastic Load Balancing load balancer, and an Amazon Relational Database Service (Amazon RDS) database instance. 

### Change sets

If you need to make changes to the running resources in a stack, you update the stack. Before making changes to your resources, you can generate a **change set**, which is a **summary of your proposed changes**. Change sets allow you t**o see how your changes might impact your running resources**, especially for critical resources, before implementing them.

For example, if you change the name of an Amazon RDS database instance, AWS CloudFormation will create a new database and delete the old one. You will lose the data in the old database unless you've already backed it up. If you generate a change set, you will see that your change will cause your database to be replaced, and you will be able to plan accordingly before you update your stack.


## Exam Tips
* **CloudFormation** allow you to manage, configure and provision AWS **infrastructure as code using YAML/JSON**.
* CloudFormation main sections in code:
  * Parameters - input custom value
  * Conditions - e.g. provision resources based on environments
  * **Resources (mandatory)** - AWS resources to be created
  * Mapping - create custom mapping like region/AMI
  * Transforms - reference to code located in S3 (like an include) to use reusable code
* 
* 