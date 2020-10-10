# Route53
## Concepts

**Amazon Route 53** is a **highly available and scalable Domain Name System (DNS)** web service. You can use Route 53 to perform three main functions in any combination: domain registration, DNS routing, and health checking. If you choose to use Route 53 for all three functions, perform the steps in this order:
1. **Register domain names** - Your website needs a name, such as example.com. Route 53 lets you register a name for your website or web application, known as a domain name.
2. **Route internet traffic to the resources for your domain** - When a user opens a web browser and enters your domain name (example.com) or subdomain name (acme.example.com) in the address bar, Route 53 helps connect the browser with your website or web application.
3. **Check the health of your resources** - Route 53 sends automated requests over the internet to a resource, such as a web server, to verify that it's reachable, available, and functional. You also can choose to receive notifications when a resource becomes unavailable and choose to route internet traffic away from unhealthy resources.

## Health Checking

Amazon Route 53 health checks monitor the health of your resources such as web servers and email servers. You can optionally configure Amazon CloudWatch alarms for your health checks, so that you receive notification when a resource becomes unavailable.

![Health Check](how-health-checks-work.png)

Concepts related to Amazon Route 53 health checking:
* **DNS failover** - A method for routing traffic away from unhealthy resources and to healthy resources. Route53 can check the healthy of your AWS endpoints.
* **Endpoints** - **The resource**, such as a web server or an email server, that you configure a health check to monitor the health of.
* **Health check** - A Route 53 component that lets you do the following:
  * **Monitor whether a specified endpoint, such as a web server, is healthy**
  * Optionally, get notified when an endpoint becomes unhealthy
  * Optionally, configure DNS failover, which allows you to reroute internet traffic from an unhealthy resource to a healthy resource
* **Routing policies** - determines how Amazon Route 53 **responds to queries**

You can configure SNS notifications when a health check is failing.

Types of health checks:
* Health checks that **monitor an endpoint** - You can configure a health check that monitors an endpoint that you specify either by IP address or by domain name. 
* Health checks that **monitor other health checks** (**calculated** health checks)
* Health checks that **monitor CloudWatch alarms**. To improve resiliency and availability, Route 53 doesn't wait for the CloudWatch alarm to go into the ALARM state. 

## Routing policies
* **Simple routing** - Simple routing lets you configure standard DNS records, with **no special Route 53 routing** such as weighted or latency. It depends on the DNS client how it manage its content. If **multiple values** are specified, Route53 return all the values to the client in a **random order**. 
* **Failover routing** - route traffic to a resource when the resource is **healthy or to a different resource when the first resource is unhealthy**. The primary and secondary records can route traffic to anything from an Amazon S3 bucket that is configured as a website to a complex tree of records.
* **Geolocation routing** - Geolocation routing lets you choose the resources that serve your traffic based on the **geographic location** of your users, meaning the **location that DNS queries originate from**. You can specify geographic locations by continent, by country, or by state in the United States. If you create separate records for **overlapping geographic regions**—for example, one record for North America and one for Canada—priority **goes to the smallest geographic** region. You can create a **default record** that handles both queries from **IP addresses that aren't mapped** to any location and queries that come from locations that you haven't created geo-location records for
* **Geoproximity routing** (traffic flow only) - route **traffic to your resources based on the geographic location of your users and your resources**. You can also optionally choose to route more traffic or less to a given resource by specifying a value, known as a bias. **A bias expands or shrinks the size of the geographic region from which traffic is routed to a resource**.
* **Latency-based routing** - Route traffic based on the lowest network latency for your end user, **measured from latency between regions**. It determines which AWS Regions you've created latency records for, determines which region gives the user the lowest latency, and then selects a latency record for that region.
* Multi-value answer routing - return multiple values, such as IP addresses for your web servers, in response to DNS queries. **You can specify multiple values for almost any record, but multivalue answer** routing also lets you check the health of each resource, so Route 53 **returns only values for healthy resources**. It's not a substitute for a load balancer, but the ability to return multiple health-checkable IP addresses is a way to use DNS to improve availability and load balancing.
* **Weighted routing** - lets you associate multiple resources with a single domain name (example.com) or subdomain name (acme.example.com) and **choose how much traffic is routed to each resource**. This can be useful for a variety of purposes, including load balancing and testing new versions of software.

## ECS record
EDNS client subnet option (ECS) allows authoritative DNS providers to use the extra information to make more informed traffic routing decisions.

![ECS](./ECS%20record.png)

## Exam Tips
* You can buy domains directly from AWS
* Register a domain can take up to three days, depending in the validation process. 
* **Simple Routing** can only have one record with **one or multiple values**. If **multiple values** are specified, Route53 return all the values to the client in a **random order**. 
* **Weighted routing** - Distribute traffic based on ratios. Supports Health checks on individual records.
* **Latency Routing** - Based on latency between the user region and the latency between regions. 
* **Failover Routing** - Route traffic based on an Active/Passive schema using health checks to verify a resource failure. 
* **Geolocation Routing** - Route traffic based on geographical location os the source IP dns query.
* **Geoproximity routing** - Geolocation with bias to expand geographic regions.
* **Multivalue answer routing** - return multiple records of the health records.
* Route 53 support **edns-client-subnet extension of EDNS0** record, that holds part of the source IP that made the query to the client DNS server.
* Route 53 have a soft **limit of 50 domain names**, but it can increased contacting AWS Support.
* **Alias Record is an Route 53 extension** and can point to records in other accounts adding manually the ARN of the endpoint.