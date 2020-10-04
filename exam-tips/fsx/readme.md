 # FSx Windows/Lustre
 ## Concepts

 Amazon FSx for Windows File Server provides fully managed Microsoft Windows file servers, backed by a fully native Windows file system. Amazon FSx for Windows File Server has the features, performance, and compatibility to easily lift and shift enterprise applications to the AWS Cloud.

 Amazon FSx supports a broad set of enterprise Windows workloads with fully managed file storage built on Microsoft Windows Server. Amazon FSx has native support for Windows file system features and for the industry-standard Server Message Block (SMB) protocol to access file storage over a network. Amazon FSx is optimized for enterprise applications in the AWS Cloud, with native Windows compatibility, enterprise performance and features, and consistent submillisecond latencies.

 Amazon FSx for Lustre makes it easy and cost-effective to launch and run the popular, high-performance Lustre file system. You use Lustre for workloads where speed matters, such as machine learning, high performance computing (HPC), video processing, and financial modeling.

The open-source Lustre file system is designed for applications that require fast storage—where you want your storage to keep up with your compute. Lustre was built to solve the problem of quickly and cheaply processing the world's ever-growing datasets. It's a widely used file system designed for the fastest computers in the world. It provides submillisecond latencies, up to hundreds of GBps of throughput, and up to millions of IOPS.

## Exam tips
* In scenario question, when to use EFS or FSx:
  * EFS: Used for distributed, highly resilient storage for Linux and Linux-based applications
  * FSx for Windows: centralized storage for Windows-based/native applications. 
  * FSx for Lustre: Used for high-speed, high-capacity distributed storage. Typically with High Performance Compute (HPC). Can store data directly in S3.

## References:
* [About Lustre file-system](https://lustre.org/)