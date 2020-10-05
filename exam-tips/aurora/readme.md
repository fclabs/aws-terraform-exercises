# Amazon Aurora
## Concepts

Amazon Relational Database Service (Amazon RDS) is a web service that makes it easier to set up, operate, and scale a relational database in the AWS Cloud. It provides cost-efficient, resizable capacity for an industry-standard relational database and manages common database administration tasks.

## Aurora Serverless

Is an on-demand, autoscaling configuration for the MySQL-compatible and PostgreSQL-compatible editions of Amazon Aurora. An aurora Serverless DB cluster start up, shut down, and scales capacity up or down based on your application needs. 

Provides a relative simple, cost-effective option for infrequent, intermittent, or unpredictable workloads.


* **Storage Autoscaling** - Aurora scales up from 10GB in 10GB increments up to 64TB
* **Computer autoscaling** - Can scale up to 32vCPU and 244GB of memory.
* **Data replication** - 2 copies of your data is contained in each availability zone, with a minimum of three AZ. 6 copies of you data. 
* **Read Replicas** - Aurora can have up to 15 read replicas without impact performance.
* Automatic Fail over without data loss.
* **Automatic Backup without impact on performance**. 
* Support Snapshots that you can share with other accounts.

