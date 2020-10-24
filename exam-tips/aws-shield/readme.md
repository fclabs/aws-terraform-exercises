# AWS Shield

## Concepts

AWS provides **AWS Shield Standard and AWS Shield Advanced for protection against DDoS attacks**. AWS Shield **Standard** is **automatically included** at no extra cost beyond what you **already pay for AWS WAF and your other AWS services**. For added protection against DDoS attacks, AWS offers AWS Shield Advanced. AWS Shield Advanced provides expanded DDoS attack protection for your resources.

A distributed denial of service (DDoS) attack is an attack in which multiple compromised systems attempt to flood a target, such as a network or web application, with traffic. A DDoS attack can prevent legitimate users from accessing a service and can cause the system to crash due to the overwhelming traffic volume.

### AWS Shield Standard
All AWS customers benefit from the automatic protections of AWS Shield Standard, at no additional charge. AWS Shield Standard defends against most common, frequently occurring network and transport layer DDoS attacks that target your website or applications. While AWS Shield Standard helps protect all AWS customers, you get particular benefit if you are using Amazon CloudFront and Amazon Route 53. These services receive comprehensive availability protection against all known infrastructure (Layer 3 and 4) attacks.

### AWS Shield Advanced
For higher levels of protection against attacks, you can subscribe to AWS Shield Advanced. When you subscribe to AWS Shield Advanced and add specific resources to be protected, AWS Shield Advanced provides expanded DDoS attack protection for web applications running on the resources.

## Exam Tips
* Differences between AWS Shield Standard and Advanced:

AWS Shield Standard | AWS Shield Advanced
------------------ | -------------------
Automatically enabled for all the services at **no cost** | USD 3,000 per month, per organization
Protects against common layer 3 and 4 attacks: **SYN/UDB Floods, Reflection Attacks** | Enhanced protection for EC2, ELB, CloudFront, Global Accelerator, Route 53
Stopped a 2.3Tb DDoS attack for three days in Feb 2020 | Business and Enterprise support with 7x24 access to DDoS Response Team (DRT)
   || DDoS cost Protection
