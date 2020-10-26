# Elastic Container Service (ECS)

## Concepts

Amazon Elastic Container Service (Amazon ECS) is a highly scalable, fast, container management service that makes it easy to run, stop, and manage containers on a cluster. Your containers are defined in a task definition which you use to run individual tasks or as a service. You can run your tasks and services on a serverless infrastructure that is managed by AWS Fargate or, for more control over your infrastructure, you can run your tasks and services on a cluster of Amazon EC2 instances that you manage.

### Components
* **Cluster** - An Amazon ECS cluster is a **logical grouping of tasks or services**. If you are running tasks or services that use the **EC2** launch type, a **cluster is also a grouping of container instances**. If you are using capacity providers, a cluster is also a logical grouping of capacity providers. When you first use Amazon ECS, a default cluster is created for you, but you can create multiple clusters in an account to keep your resources separate. **Clusters are region specific.**
* **Task Definition** - Defines you application. You can define multiple containers in a task definition. Definition includes:
  * The **Docker image** to use with each container in your task
  * How much **CPU and memory** to use with each task or each container within a task
  * The **launch type** (Fargate vs EC2) to use, which determines the infrastructure on which your tasks are hosted
  * The Docker **networking mode** to use for the containers in your task
  * The **logging** configuration to use for your tasks
  * Whether the task should **continue to run** if the container finishes or fails
  * The **command** the container **should run** when it is started
  * Any **data volumes** that should be used with the containers in the task
  * The **IAM role** that your tasks should use
* **Container Definition** - Inside a task definition, it defines the individual containers a task uses. Controls CPU and Memory allocation and port mapping.
* **Task** - Single running copy of any container defined by a task definition. It is a working copy of an application.
* **Services** - enables you to **run and maintain a specified number of instances** of a task definition simultaneously in an Amazon ECS cluster. If any of your tasks should fail or stop for any reason, the Amazon ECS service scheduler launches another instance of your task definition to replace it in order to maintain the desired number of tasks in the service. In addition to maintaining the desired number of tasks in your service, you can optionally **run your service behind a load balancer**. The load balancer distributes traffic across the tasks that are associated with the service.
* **Registry** - Storage for container images. Elastic Container Registry os Docker Hub. It's used to store and download the container's images.

### AWS Fargate

AWS Fargate is a technology that you can use with **Amazon ECS** to run containers **without having to manage servers or clusters of Amazon EC2 instances**. With AWS Fargate, you no longer have to provision, configure, or scale clusters of virtual machines to run containers. This removes the need to choose server types, decide when to scale your clusters, or optimize cluster packing.

When you run your tasks and services with the Fargate launch type, you package your application in containers, specify the CPU and memory requirements, define networking and IAM policies, and launch the application. **Each Fargate task has its own isolation boundary and does not share the underlying kernel, CPU resources, memory resources, or elastic network interface with another task.**

### Elastic Container Registry (ECR)

Amazon Elastic Container Registry (Amazon ECR) is a **managed AWS container image registry service that is secure, scalable, and reliable**. Amazon ECR supports private container image repositories with resource-based permissions using AWS IAM so that specific users or Amazon EC2 instances can access repositories and images. Developers can use their preferred CLI to push, pull, and manage Docker images, Open Container Initiative (OCI) images, and OCI compatible artifacts.

### Elastic Kubernetes Services (EKS)

Amazon EKS is a managed service that makes it easy for you to **run Kubernetes on AWS without needing to install, operate, and maintain your own Kubernetes control plane** or nodes. Kubernetes is an open-source system for automating the deployment, scaling, and management of containerized applications.

Amazon **EKS runs Kubernetes control plane** instances across **multiple Availability Zones** to ensure high availability. Amazon EKS automatically detects and replaces unhealthy control plane instances, and it provides automated version upgrades and patching for them. Amazon EKS is integrated with many AWS services to provide scalability and security for your applications, including the following:
* Amazon ECR for container images
* Elastic Load Balancing for load distribution
* IAM for authentication
* Amazon VPC for isolation

## Exam Tips
* **ECS** is the **managed container service**. 
* **ECR** is the managed **containers image registry** for ECS, EKS or any OCI compatible container system.
* Fargate is the serverless container node for ECS or EKS
* EKS is the Kubernetes AWS managed control service that will manage Fargate or EC2 worker nodes.
* Each **container** in ECS (or **Pod** in EKS) can have **its own IAM policy**, which provides more granularity than EC2 Instances Profile roles. 