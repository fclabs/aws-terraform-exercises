# VPC
## Concept

Amazon VPC is the networking layer for Amazon EC2. 

A virtual private cloud (VPC) is a virtual network dedicated to your AWS account. It is logically isolated from other virtual networks in the AWS Cloud. You can launch your AWS resources, such as Amazon EC2 instances, into your VPC. You can specify an IP address range for the VPC, add subnets, associate security groups, and configure route tables.

The following are the key concepts for VPCs:
* **Virtual private cloud** (VPC) — A virtual network dedicated to your AWS account.
* **Subnet** — A range of IP addresses in your VPC. Implements Network ACLs.
* **Route table** — A set of rules, called routes, that are used to determine where network traffic is directed.
* **Internet gateway** — A gateway that you attach to your VPC to enable communication between resources in your VPC and the internet.
* **VPC endpoint** — Enables you to privately connect your VPC to supported AWS services and VPC endpoint services powered by PrivateLink without requiring an internet gateway, NAT device, VPN connection, or AWS Direct Connect connection. Instances in your VPC do not require public IP addresses to communicate with resources in the service. Traffic between your VPC and the other service does not leave the Amazon network. For more information, see VPC endpoints and VPC endpoint services (AWS PrivateLink).

## VPC Quotas
Resource | Default | Comment
-------- | :-------: | -------
VPC per region | 5 | Up to 100
Subnet per VPC | 200 | -
IPv4 blocks per VPC | 5 | Up to 50
IPv6 blocks per VPC | 1 | Cannot be incremented

## VPC Peering
A VPC peering connection is a **networking connection between two VPCs** that allows you to route traffic between them using private IPv4 addresses. Instances in either VPC can communicate with each other as if they are part of the same network.

To enable the routing of traffic between VPCs in a VPC peering connection, **you must add a route to one or more of your subnet route tables that points to the VPC peering connection**. This allows you to access all or part of the CIDR block of the other VPC in the peering connection. Similarly, **the owner of the other VPC must add a route to their subnet route table to route traffic back to your VPC**.

## Subnets
A subnet is a range of IP addresses in your VPC. You can launch AWS resources into a specified subnet. Use a public subnet for resources that must be connected to the internet, and a private subnet for resources that won't be connected to the internet.

To protect the AWS resources in each subnet, you can use multiple layers of security, including security groups and network access control lists (ACL). **Network ACLs are stateless.**

Any **new subnet is associated automatically to the Main Route Table**. Don't use Main Route Table as public Route Table (including an Internet Gateway route rule).

**Every Subnet** will have some **IPs reserved** (five) for AWS services:
| Address | Use |
| ------- | --- |
| .0 | Network Address |
| .1 | Default Gateway |
| .2 | DNS server |
| .3 | Reserved by AWS |
| Last IP | Broadcast address |

## NAT Gateways and instances

You can use a NAT device to enable instances in a private subnet to connect to the internet (for example, for software updates) or other AWS services, but prevent the internet from initiating connections with the instances. A NAT device forwards traffic from the instances in the private subnet to the internet or other AWS services, and then sends the response back to the instances. When traffic goes to the internet, the source IPv4 address is replaced with the NAT device’s address and similarly, when the response traffic goes to those instances, the NAT device translates the address back to those instances’ private IPv4 addresses.
AWS offers two kinds of NAT devices:
* **NAT Gateway**: provided by AWS. It has a cost per hour and transfer rates. Needs **one per Availability Zone** that can be shared between multiple private subnets.
* **NAT Instance**: Instances that creates the NATs. Can be shared across AZ but does not provide automatic failover. 

For NAT instances remember to **disable the Source/Destination Check**.

## Exam Tips

### VPCs
* VPC is like your logical datacenter in AWS
* One VPC will include:
  * One Internet Gateway or Virtual Private Gateway (optional)
  * One or more subnet
  * One or more routing table **(one default created automatically)**
  * One or more network access list **(one default created automatically)**
  * One or more Security Groups **(one default created automatically)**
* **One subnet** will always **have an Availability Zone**. Usually subnets are references to select the AZ of other resources. 
* An **Availability Zone** can have **multiple subnets**. 
* **New VPC** will create a **Security Group, a Network ACL and Route Table**.

### Default VPCs
* Created by default. **One in each region.** 
* Used to simplify the developers to deploy instances.
* **All subnets in Default VPC have route to Internet**.
* Will have **one subnet per Availability Zone** in that region. Number of subnets will differ per region.

### VPC Peering
* **Connects VPCs** from the **same or different accounts**, in **same or different region**. 
* **Does not support transitive peering** aka routing traffic between two VPC (A, B) going through a common VPC peer (C). ```A <-> C <-> B```

### NAT Instances/gateways
* When creating a **NAT Instance**, remember to **disable the Source/Destination Check**.
* **NAT Instances** must be in **public subnets**.
* Privates subnets need to have a **```0.0.0.0/0```route** pointing to the **NAT instance/gateway**.
* **NAT Instances** can be added to a **Autoscaling group with a load balancer** for HA or an script that change the route table pointing to the new instance.
* **NAT Gateway** are redundant **inside the Availability Zone**. You also need **one route table** per AZ that point all the resources in that zone to the right gateway.
* **NAT Gateway** scales up from **5 to 45 Gbps** and **does NOT** requires **Security Group**.
* **NAT Gateway** is assigned with a public IP automatically.

### Network ACL/Security Groups
* **Default Network ACL and Security Group** are **automatically created** with a new VPC.
* **Network ACL by default enables all** inbound and outbound traffic until you add a rule.
* **All the subnets have a Network ACL associated**. If you not specify one, the default NACL is used.
* **Security Groups cannot block** IP address. **Network ACL can block** specific traffic using IP or port. 
* A **Network ACL can be associated with multiple subnets**, but a **subnet** can have only **one Network ACL**. 
* Network ACL are stateless. You need to enable rules for the incoming and returning traffic.