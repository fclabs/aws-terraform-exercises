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

## Instances Roles
* Roles that you can attach to your EC2 instances. It is more secure than use Access/Secure keys.
* Can be attached on-demand while the instance is running using the console or the API/CLI
* As everything in IAM, they are universal. 

## References and complementary readings
