# IAM
## Essentials Tips

### General
* **IAM is global**. It applies to all the regions
* Root account is the account created when you open an account. It has full access to any resource inside your account.
* **New users have not permissions** when their are created.
* Every new user is created with an Access Key ID (like a user id) and a Secret Access Key (like the password) to be used in programmatic access (like API or CLI). They cannot be used to access the console. 
* **Secret Key only can be downloaded once**. If you lose it, you need to create a new Access ID & Secret.
* You need to setup multi-factor authentication for root and admin accounts.
* You should create password policies (content and rotation)

###
* IAM Consist of:
  * Users
  * Groups
  * Policies
  * Roles

### Power Users
* Power users are users with an Admin Role to manage all AWS resources except IAM.

## Service Roles
* Roles allow you give permissions to a AWS Service to access or make changes in other AWS services/accounts. 
* Policies should be attached to the role to give permissions to it.
## Instances profiles
* EC2 profiles attach EC2 roles to your EC2 instances. It is more secure than use Access/Secure keys.
* Can be attached on-demand while the instance is running using the console or the API/CLI
* As everything in IAM, they are universal. 

## ARN
Amazon Resource Names (**ARNs**) **uniquely identify AWS resources**. We require an ARN when you need to specify a resource unambiguously across all of AWS, such as in IAM policies, Amazon Relational Database Service (Amazon RDS) tags, and API calls.

```
arn:partition:service:region:account-id:resource-id
arn:partition:service:region:account-id:resource-type/resource-id
arn:partition:service:region:account-id:resource-type:resource-id
```

## IAM Policies
A policy is an object in AWS that, when associated with an identity or resource, defines their permissions. When you create a permissions policy to restrict access to a resource, you can choose an identity-based policy or a resource-based policy.
* **Identity-based policies** are attached to an **IAM user, group, or role**. These policies let you specify what that identity can do (its permissions). Identity-based policies can be managed or inline.
* **Resource-based policies** are attached to a resource. For example, Amazon S3 buckets, Amazon SQS queues, and AWS Key Management Service encryption keys. **Allow you to define who can access and what actions they can perform**.

### Policy JSON Document
  
* Al JSON policies have a **Version**. **2010-10-17** is the last one.
* Each content will have one or more **Statements**
* Each Statement match a API Request and define:
  * **Effect**: **Allow** / **Deny**
  * **Actions**: in the form **ServiceName**:**ActionName**. Can support wild cards.
  * **Resource**: Which is the **resource** associates with this actions. 
  * **Principals**: Who is the entity that can **make the actions**.
  * **Conditions**: Conditions evaluated on the request to access the resource. Usually are base on request content (API call arguments).
* Any permission that **is not explicit Allow, is Denied**. 
* Always a Deny **Effect** will have **precedence** over an **Allow**.
* AWS **joins** all the policies associated with a Principal to evaluate the access.
* There are AWS-Managed policies and Customer-Managed policies.

## Permissions Boundaries

Is used to limit the **maximum permission** of a user/role and prevent privilege escalation or unnecessarily broad permissions. It is an additional constrain over the IAM policy.

The effective access will be defined for the common permissions between the boundary and the policy.

## IAM Securoty Tools
### IAM Credential Report (account-level)

Report that lists all your account's users and the status of their various credentials

### IAM Access Advisor (user-level)

Access advisor shows the service permissions granted to a user and when those services were last 

### Generate policy based on CloudTrail history
Analize CloudTrail access for that role and propose a new role with the least access required to reproduce the same access actions executed in the past. 