# HA Wordpress Lab

## Lab objectives

Create a Fault tolerant Lab for Wordpress server

Network Diagram
![Network-Diagram](../images/HA-Design.png)

This labs will use most of the resources used along the other labs. Two S3 buckets will hold the media and code for WordPress. 

CloudFront will point to the S3 Media bucket to provide content distribution, and the S3 code will be copied the php code to each instance at boot time (TODO Migrate to code repo)

The lab will use Route53 to modify the domain entries but you can skip this step and use de ELB FQDN as main entry point.

Note: The first time that you deploy the product, the target group will keep the instances as unhealthy until you finish the initial configuration of Wordpress. Connect to an instance with the public IP, configure it and the /index.php will stop to redirect the connections and start answering with an 200, required for the health evaluation.

Remember to configure in the Wordpress admin site, the Site URL/Wordpress Site as the route53/Load Balancer FQDN, so all the content is correctly referenced.
![Wordpress Config](../images/wp-config.png)

Once that you finish the WordPress configuration, that will be in the database and the code can be copied to the S3 Code bucket in order to sync you code with each new instance


## Lab takeouts

* Design for failure

## References & good readings
* [The Netflix Simian Army](https://netflixtechblog.com/the-netflix-simian-army-16e57fbab116)
