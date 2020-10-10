# Resource Access Manager (RAM)
## Concepts

AWS Resource Access Manager (AWS RAM) lets you **share your resources** with any **AWS account or through AWS Organizations**. If you have multiple AWS accounts, **you can create resources centrally** and use AWS RAM to share those resources with other accounts.

You can share resources that you own by creating a resource share. When you create a resource share, you specify a name, the resources to share, and the **principals with whom** to share. **Principals can be AWS accounts, organizational units, or an entire organization from AWS Organizations**. Your **account retains full ownership of the resources** that you share.

When the owner of a resource shares it with your account, **you can access the shared resource just as you would if it was owned by your account**. You can access the resource using the respective service's console, AWS CLI, and API. The actions that users are allowed to perform vary depending on the resource type. **All IAM policies and service control policies configured in your account apply**, which enables you to leverage your existing investments in security and governance controls.

RAM work sending **invitation** that needs to be **accepted** before the destination principal can **see the resource**.