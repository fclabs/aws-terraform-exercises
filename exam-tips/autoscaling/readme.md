# Autoscaling
## Concepts

Amazon EC2 Auto Scaling helps you ensure that you have the **correct number** of Amazon EC2 instances available **to handle the load** for your application. 

You create collections of EC2 instances, called **Auto Scaling groups**. You can specify the minimum number of instances in each Auto Scaling group, and Amazon EC2 Auto Scaling ensures that your group never goes below this size. You can specify the maximum number of instances in each Auto Scaling group, and Amazon EC2 Auto Scaling ensures that your group never goes above this size. If you specify the desired capacity, either when you create the group or at any time thereafter, Amazon EC2 Auto Scaling ensures that your group has this many instances. If you specify **scaling policies**, then Amazon EC2 Auto Scaling can **launch or terminate instances as demand on your application increases or decreases**.

Components in Auto Scaling groups:
* **Groups** - Your EC2 instances are organized into groups so that they can be treated as a logical unit for the purposes of scaling and management. **When you create a group, you can specify its minimum, maximum, and, desired number of EC2 instances**.
* **Configuration templates** - Your group uses a launch template or a launch configuration as a configuration template for its EC2 instances. You can **specify information such as the AMI ID, instance type, key pair, security groups, and block device mapping** for your instances.
* **Scaling options** - Amazon EC2 Auto Scaling provides several ways for you to scale your Auto Scaling groups. For example, you can configure a group to **scale based on** the occurrence of specified **conditions (dynamic scaling) or on a schedule**.

![AutoScaling](./as-basic-diagram.png)

### Scaling Options
* **Maintain current instance levels at all times** -  maintains **a specified number** of running instances **at all times**. Amazon EC2 Auto Scaling **performs** a periodic **health check on running instances** within an Auto Scaling group. When Amazon EC2 Auto Scaling finds an **unhealthy instance, it terminates that instance and launches a new one**. 
* **Scale manually** - most basic way to scale your resources, where you **specify only the change in the maximum, minimum, or desired capacity** of your Auto Scaling group. Amazon EC2 Auto Scaling manages the process of creating or terminating instances to maintain the updated capacity. 
* **Scale based on a schedule** - scaling actions are performed **automatically** as a **function of time and date**. This is useful when **you know exactly** when to **increase or decrease** the number of instances in your group, simply because the need arises on a predictable schedule.
* **Scale based on demand** - lets you define parameters that control the scaling process. This method is useful for **scaling in response to changing conditions**, when you don't know when those conditions will change. 
* **Use predictive scaling** - You can also use Amazon EC2 Auto Scaling in combination with AWS Auto Scaling to scale resources across multiple services. **AWS Auto Scaling** can help you maintain optimal availability and performance by combining predictive scaling and dynamic scaling (proactive and reactive approaches, respectively) to **scale your Amazon EC2 capacity faster**.

### Warm-up time
After determining that a newly launched instance is healthy, Amazon EC2 Auto Scaling does not immediately move on to the next replacement. It provides a window for each instance to **warm up after launching**, which you can configure. This can be helpful when you have** configuration scripts that take time to run**. To protect your application's availability, ensure that the instance **warm-up period covers the expected startup time for your application, from when a new instance comes into service to when it can receive traffic**.

### Scaling Cooldown
A scaling cooldown helps you **prevent** your Auto Scaling group from **launching or terminating additional instances before the effects of previous activities are visible**.

When you use simple scaling, after the Auto Scaling group scales using a simple scaling policy, it waits for a cooldown period to complete before any further scaling activities due to simple scaling policies can start. An **adequate cooldown period helps to prevent the initiation of an additional scaling activity based on stale metrics**. 



## Exam Tips
* Scaling Options:
  * **Maintain current instance levels at all times**  
  * **Scale manually** - specify only the change in the maximum, minimum, or desired capacity
  * **Scale based on a schedule** - as a function of time and date. **you know exactly** when.
  * **Scale based on demand** - scaling in response to changing conditions. 
  * **Use predictive scaling** - Amazon EC2 Auto Scaling in combination with AWS Auto Scaling to scale resources across multiple services. **Scales your Amazon EC2 capacity faster**.
* **Before** you can create an **Autoscaling Group** you need to **create a Launch configuration**.
* If add **multiple subnets**, it will **distribute** instances between subnets.
* **Warm-up time** is the how much time new instances need to start being considered as **functional in the scaling group**. 