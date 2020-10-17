# Elastic Load Balancers
## Concepts
Elastic Load Balancing **distributes incoming application or network traffic across multiple targets**, such as Amazon EC2 instances, containers, and IP addresses, in multiple Availability Zones. Elastic Load Balancing scales your load balancer as traffic to your application changes over time. It can automatically scale to the vast majority of workloads.

You can **add and remove compute resources** from your load balancer as your needs change, **without disrupting **the overall flow of requests to your applications.

A **load balancer accepts incoming traffic from clients and routes requests to its registered targets** (such as EC2 instances) in one or more Availability Zones. The load balancer also **monitors the health of its registered targets** and ensures that it routes traffic only to healthy targets. When the load balancer detects an unhealthy target, it stops routing traffic to that target. It then resumes routing traffic to that target when it detects that the target is healthy again.

You configure your load balancer to accept incoming traffic by specifying one or more listeners. **A listener is a process that checks for connection requests**. It is configured with a protocol and port number for connections from clients to the load balancer. Likewise, it is configured with a protocol and port number for connections from the load balancer to the targets.

Elastic Load Balancing supports three types of load balancers:
* Application Load Balancers
* Network Load Balancers
* Classic Load Balancers

### Components
* **Load balancer** - serves as the **single point of contact** for clients. The load balancer distributes incoming application traffic across multiple targets, such as EC2 instances, in multiple Availability Zones. This increases the availability of your application. 
* **Listener** - checks for connection **requests from clients**, using the **protocol and port** that you configure. The **rules that you define** for a listener determine **how the load balancer routes requests to its registered targets**. Each rule consists of a priority, one or more actions, and one or more conditions. When the conditions for a rule are met, then its actions are performed. You must define a **default rule for each listener**, and you can optionally define additional rules.
* **Target group** - routes requests to one or more registered targets, such as EC2 instances, using the protocol and port number that you specify. You can register a target with multiple target groups. You can configure **health checks on a per target group** basis. Health checks are **performed on all targets** registered to a target group that is specified in a listener rule for your load balancer. You can target to IP addresses outside your VPC. 

![ALB](./component_architecture.png)

### Application Load Balancers
An Application Load Balancer **functions at the application layer**, the seventh layer of the Open Systems Interconnection (OSI) model. After the load balancer receives a request, it **evaluates the listener rules** in priority order to determine which rule to apply, and then **selects a target** from the target group for the rule action. You can configure listener rules to route requests to different target groups based on the content of the application traffic. **Routing is performed independently for each target group**, even when a target is registered with multiple target groups. You can configure the routing algorithm used at the target group level. The **default routing algorithm is round robin**; alternatively, you can specify the least outstanding requests routing algorithm.

### Network Load Balancers
A Network Load Balancer **functions at the fourth layer** of the Open Systems Interconnection (OSI) model. It can **handle millions of requests per second**. After the load balancer receives a connection request, it selects a target from the target group for the default rule. It attempts to open a TCP connection to the selected target on the port specified in the listener configuration.

For **TCP traffic**, the load balancer **selects a target using a flow hash algorithm based on the protocol, source IP address, source port, destination IP address, destination port, and ***TCP sequence number*****. The TCP connections from a client have different source ports and sequence numbers, and can be routed to different targets. **Each individual TCP connection is routed to a single target for the life of the connection.**

For UDP traffic, the load balancer **selects a target using a flow hash algorithm based on the protocol, source IP address, source port, destination IP address, and destination port**. A UDP flow has the same source and destination, so it is consistently routed to a single target throughout its lifetime. Different UDP flows have different source IP addresses and ports, so they can be routed to different targets.

### Classic Load Balancer
Classic Load Balancer provides basic load balancing across multiple Amazon EC2 instances and operates at both the request level and connection level. Classic Load Balancer is intended for applications that were built within the EC2-Classic network. We recommend Application Load Balancer for Layer 7 and Network Load Balancer for Layer 4 when using Virtual Private Cloud (VPC).


### Cross-zone load balancing
The nodes for your load balancer distribute requests from clients to registered targets. When **cross-zone load balancing is enabled**, each load balancer node distributes traffic across the registered **targets in all enabled Availability Zones**. When **cross-zone load balancing is disabled**, each load balancer node **distributes traffic only across the registered targets in its Availability Zone**.


### Sessions Affinity or Sticky Sessions
**By default, a Classic Load Balancer** routes each request independently to the registered instance with the **smallest load**. However, you can use the **sticky session feature ** (also known as session affinity), which enables the load balancer to **bind a user's session to a specific instance**. This ensures that all requests from the user during the session are sent to the same instance.

### Path Patterns
The rules that you define for your **listener** determine how the load balancer **routes requests** to the targets in one or more target groups.

Each rule consists of a priority, one or more actions, and one or more **conditions**.

## Exam Tips
* **Application Load Balancers**, for **L7 decisions**. Act like a reverse proxy. Recommended for any VPC application.
* **Network Load Balancers** for **TPC/UDP traffic**, supports millions of connections and low latency. Recommended for TCP/UDP traffic, non HTTP.
* **Classic Load Balance**, Recommended for **EC2-Classic** instances.
* **Error 504** means the gateway has timed out. A**pplication is not responding**.
* HTTP Load Balancers use **X-Forwarded-For** to register the original IP address of the request to the load balancer.
* You **never get an IP address** for an Application Load Balancer. Always a domain name.
* When you register EC2 instances as targets, you must ensure that the **security groups** for these instances allow traffic on both the **listener port and the health check port**.
* Instances are reported as: **InService** or **OutofService**, based on health check results. 
* SLA for ELB is 99.99%
* **Cross-zone load balancing** is already **enabled by default** in Application Load Balancer.
* ELB Classic can **only load balance on the following ports**: 25, 80, 443, 465, 587, 1024-65535
*  You are not charged for **regional data transfer between Availability Zones** when you **enable cross-zone load balancing for your Classic Load Balancer or Application Load Balancers**.
* You **will be charged for regional data transfer** between Availability Zones with **Network Load Balancer** when cross-zone load balancing is enabled.
* **Sticky Sessions** enables users to stick to the **same EC2** instances.
* **Path Patterns** is conditional **routing** to different **target groups** based on the HTTP/S **request parameters**.
* **ELB only balance between Availability Zones**. They cannot balance between regions.
  