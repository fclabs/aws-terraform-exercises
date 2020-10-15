# On-Premise Strategies in AWS
## Available Services

### Data Migration Services

See [Data Migration Services](../dms/readme.md)

###  Server Migration Service
AWS Server Migration Service **automates the migration of your on-premises VMware vSphere, Microsoft Hyper-V/SCVMM, and Azure virtual machines to the AWS Cloud**. AWS SMS **incrementally replicates your server VMs as cloud-hosted Amazon Machine Images (AMIs) ready for deployment on Amazon EC2**. Working with AMIs, you can easily test and update your cloud-based images before deploying them in production.

### AWS Application Discovery Service
AWS Application Discovery Service helps you **plan your migration to the AWS cloud** by collecting usage and configuration data about your on-premises servers. Application Discovery Service is integrated with AWS Migration Hub, which simplifies your migration tracking as it aggregates your migration status information into a single console. You can view the discovered servers, group them into applications, and then track the migration status of each application from the Migration Hub console in your home region.

All discovered data is stored in your AWS Migration Hub home region. Therefore, you must set your home region in the Migration Hub console or with CLI commands before performing any discovery and migration activities. Your data can be exported for analysis in Microsoft Excel or AWS analysis tools such as Amazon Athena and Amazon QuickSight.

Application Discovery Service offers **two ways of performing discovery and collecting data** about your on-premises servers:
* **Agent-less discovery** - can be performed by deploying the AWS Agent-less Discovery Connector (OVA file) through your VMware vCenter. After the Discovery Connector is configured, it identifies virtual machines (VMs) and hosts associated with vCenter. 
* **Agent-based discovery** - can be performed by deploying the AWS Application Discovery Agent on each of your VMs and physical servers. 

### VM Import/Export
**VM Import/Export enables you to easily import virtual machine images from your existing environment to Amazon EC2 instances and export them back to your on-premises environment**. This offering allows you to leverage your existing investments in the virtual machines that you have built to meet your IT security, configuration management, and compliance requirements by bringing those virtual machines into Amazon EC2 as ready-to-use instances. You can also export imported instances back to your on-premises virtualization infrastructure, allowing you to deploy workloads across your IT infrastructure.

VM Import/Export is available at no additional charge beyond standard usage charges for Amazon EC2 and Amazon S3.