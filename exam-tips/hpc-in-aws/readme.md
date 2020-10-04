# HPC on AWS
## Conceps

High Performance Computing (HPC) can be easily implemented in AWS using different on-demand resources, so you don't need to invest in expensive hardware.

HPC can be achieved in AWS through the use of specific:
* Data transfer
* Computing
* Networking
* Storage
* Orchestration

## HPC Data Transfer
* **Snowball & Snowmobile**, allows to move Terabytes or Petabytes from your locations to AWS, so lated it ban be loaded to S3. Avoid the transit over Internet for large amount of data. 
* **AWS Data sync**, allow to sync data on S3, EFS or FSx for Windows using an on-premise agent that replicated your on-premise data to the cloud. 
* **Direct Connect**, allows to have a dedicated network connection to AWS so you can move data to AWS in high-speed dedicated network links. 

## HPC Computing
* **EC2 GPU/CPU optimized** instances types, that can have high power CPUs.
* **EC2 Fleets** to deploy parallel processing using on-demand and spot instances. 
* **EC2 placement groups** to organize your clusters and reduce latency between cluster nodes.

## HPC Networking
* **Enhanced Networking**, single root IO virtualization that can achieve up to 100Gb lowering your CPU use for networking and getting lower latency.
  * ENA, **Elastic Network Interface** supports up to 100Gb and is the default option for new instances.
  * VF or intel 82599 offers up to 10Gb bandwidth, used in older instances
* **Elastic Fabric Adapters (EFA)**, Can be attached to you instances to achieve lower and consistent latency and high throughput. Can used OSTP to bypass OS in network communication. Only supported in Linux.

## HPC Storage
* **EBS**, attached to instances, can achieve up to 64,000 IOPS with provisioned IOPS.
* **Instance Store**, Scale to millions of IOPS
* **S3**, with distributed object based storage and unlimited storage.
* **EFS**, scale in IOPS based on total size of the file-system or provisioned EFS.
* **FSx for Lustre**, a HPC optimized file-system.

## HPC Orchestration
* **AWS Batch**, allows to run hundreds of thousands of batch computing jobs in AWS. Supports multi-node parallel jobs. It can schedule jobs.
* **AWS Parallel cluster**, Cluster management tools for instances. 