# RedShift
## Concepts

OLAP: Online analytical processing is an approach to answer multi-dimensional analytical (MDA) queries swiftly in computing.

Amazon Redshift is a **fully managed**, petabyte-scale **data warehouse** service in the cloud. An Amazon Redshift data warehouse is a collection of computing resources called nodes, which are organized into a group called a cluster. Each cluster runs an Amazon Redshift engine and contains one or more databases.

Nodes consists of a leader node and one or more compute nodes. The type and number of compute nodes that you need depends on the size of your data, the number of queries you will execute, and the query execution performance that you need.

Depending on your data warehousing needs, you can start with a small, single-node cluster and easily scale up to a larger, multi-node cluster as your requirements change. You can add or remove compute nodes to the cluster without any interruption to the service.

Amazon RedShift uses multiple compressions techniques, achieving significant more compression than relational databases. When you load data in your database, RedShift sample the data to find the most appropriate compression method.

Using a data distribution algorithm, RedShift **distributes data across all the nodes** maintaining a fast query performance. You can add nodes and Amazon makes all the work to redistribute the data as the database grows.

Backup is enabled by default with 1 day retention period. You can take snapshots and replicate to other regions for disaster recovery.

Currently available in one AZ.

## RedShift pricing
Is charged by Compute Node Hours, how many hours per computing node. Not charge for the leader node.
S3 price for backups.

## Exam Tips
* **RedShift** is used for **business intelligence**.
* Backup defaults is 1 days, max 35 days.
* Available in **one Availability Zone**.
* RedShift always tries to maintain at least three copies of your data. The original, the replica on the compute nodes and the backup in S3.
* You can asynchronously replicate you snapshots to other regions for disaster recovery.
