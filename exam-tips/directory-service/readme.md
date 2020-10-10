# AWS Directory Service
## Concepts

**AWS Directory Service** for Microsoft Active Directory, also known as AWS Managed Microsoft Active Directory (AD), enables your **directory-aware workloads and AWS resources to use managed Active Directory (AD)** in AWS. AWS Managed Microsoft AD is built on actual Microsoft AD and does not require you to synchronize or replicate data from your existing Active Directory to the cloud. 

You can use the standard AD administration tools and take advantage of the built-in AD features, such as Group Policy and single sign-on. With AWS Managed Microsoft AD, you can easily join Amazon EC2 and Amazon **RDS for SQL Server** instances to your domain, and use AWS End User Computing (EUC) services, such as Amazon WorkSpaces, with AD users and groups.

AWS Directory Services are useful for: 
* Connect AWS services to on-premise AD 
* Stand alone Directory in the Cloud
* Use existing corporate credentials
* SSO to any domain-joined EC2 instance

## AWS Managed Microsoft AD
* AD Domain controllers running Windows Servers
* Reachable by applications in your VPC
* Add DCs for HA and performance
* Exclusive Access to DCs
* Allows to extend existing AD Domain using trust relations (AD Trust)

Responsibilities
| AWS | Customer |
| --- | -------- |
| Multi-AZ deployment | User, Groups, GPOs |
| Patching, monitor, recover | Standard AD Tools |
| Instance Rotations | Scale out DCs |
| Snapshot & Restore | Trusts (resource forest) |
| | Certificate Authorities |
| | Federations |

## Simple AD
* Standalone Managed AD
* Basic AD features
* Small <= 500 users
* Large <= 5000 users
* Easier to Manage EC2
* Linux workloads that need LDAP
* **Can't support Trust relations**

## AD Connectors
* Directory Gateway for  on-premise AD
* Avoid caching information in the cloud
* Allow on-premise users to log into AWS using AD
* Join EC2 instances to your existing AD domain
* Scale across multiple AD Connectors

## Cloud Directory
* Directory based database for developers
* Multiple hierarchies with hundred of millions of objects
* Useful for: 
  * Organization Charts
  * Course Catalogs
  * Device Registries
* NOT compatible with Microsoft AD
* Fully Managed Service

## Amazon Cognito Users Pools
* Managed User Directory for SaaS applications
* Sign-up or Sign-in for web or mobile
* Works with Social Media identities

## AD Compatible 
| AD Compatible | Not Compatible |
| ------------- | -------------- |
| Managed Microsoft AD | Cloud Directory |
| Simple AD | Cognito Users Pools |
| AD Connectors | |
