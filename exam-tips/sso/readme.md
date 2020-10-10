# AWS Single Sign-On (SSO)
## Concepts

AWS Single Sign-On is a cloud-based single sign-on (SSO) service that makes it easy to centrally manage SSO access to all of your AWS accounts and cloud applications. Specifically, **it helps you manage SSO access and user permissions across all your AWS accounts in AWS Organizations**. AWS SSO also helps you manage access and permissions to commonly used third-party software as a service (SaaS) applications, AWS SSO-integrated applications as well as custom applications that support Security Assertion Markup Language (SAML) 2.0. AWS SSO includes a user portal where your end-users can find and access all their assigned AWS accounts, cloud applications, and custom applications in one place.

A user signs in to the user portal using their user name. When they do, AWS SSO redirects the request to the AWS SSO authentication service based on the directory associated with the user email address. **Once authenticated, users have SSO access to any of the AWS accounts and third-party software-as-a-service (SaaS) applications that show up in the portal without additional sign-in prompts**. This means that users no longer need to keep track of multiple account credentials for the various assigned AWS applications that they use on a daily basis.

AWS SSO supports identity federation with **SAML (Security Assertion Markup Language) 2.0**. SAML 2.0 is an **industry standard** used for securely exchanging SAML assertions that pass information about a user between a SAML authority (called an identity provider or IdP), and a SAML consumer (called a service provider or SP). AWS SSO service uses this information to provide federated single sign-on (SSO) for those users who are authorized to use applications within the AWS SSO user portal.

## Exam Tips
* If you have SAML 2.0 in the question, looks for SSO.
* At this time **SSO only support Active Directory or SSO Authentication Service as Identity Providers**. 
* SSO support integrations to **synchronize users and groups** with other IdP like Okta, OneLogin and Azure AD. 