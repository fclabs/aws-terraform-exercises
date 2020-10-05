# Elastic Map Reduce (EMR)
## Concepts

**Amazon EMR** is the industry-leading cloud **big data platform** for processing vast amounts of data using open source tools such as **Apache Spark, Apache Hive, Apache HBase, Apache Flink, Apache Hudi, and Presto**. With EMR you can run **Petabyte-scale analysis** at less than half of the cost of traditional on-premises solutions and over 3x faster than standard Apache Spark. For short-running jobs, **you can spin up and spin down clusters and pay per second for the instances used**. For long-running workloads, you can create highly available clusters that automatically scale to meet demand. 

The **central component of Amazon EMR is the cluster**. A cluster is a collection of Amazon Elastic Compute Cloud (Amazon EC2) instances. Each instance in the cluster is called a node. Each node has a role within the cluster, referred to as the node type. Amazon EMR also installs different software components on each node type, giving each node a role in a distributed application like Apache Hadoop.

The node types in Amazon EMR are as follows:
* **Master node**: A node that manages the cluster by running software components to **coordinate the distribution of data and tasks among other nodes for processing**. The master node tracks the status of tasks and monitors the health of the cluster. Every cluster has a master node, and it's possible to create a single-node cluster with only the master node.
* **Core node**: A node with software components that **run tasks and store data** in the Hadoop Distributed File System (HDFS) on your cluster. Multi-node clusters have at least one core node.
* **Task node**: A node with software components that **only runs tasks** and does not store data in HDFS. Task nodes are optional.

![EMR](./cluster-node-types.png)

**Master nodes store log files, that can be persist on S3 with 5-minute replication but it needs to be defined when you setup the cluster for the first time**.