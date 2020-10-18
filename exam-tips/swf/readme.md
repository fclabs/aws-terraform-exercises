# Simple Workflow Service

The Amazon Simple Workflow Service (Amazon SWF) makes it easy to **build applications that coordinate work across distributed components**. In Amazon SWF, a task represents a logical unit of work that is performed by a component of your application. Coordinating tasks across the application involves managing intertask dependencies, scheduling, and concurrency in accordance with the logical flow of the application. Amazon SWF gives you full control over implementing tasks and coordinating them without worrying about underlying complexities such as tracking their progress and maintaining their state.

When using Amazon SWF, you implement workers to perform tasks. These workers can run either on cloud infrastructure, such as Amazon Elastic Compute Cloud (Amazon EC2), or on your own premises. You can create tasks that are long-running, or that may fail, time out, or require restarts—or that may complete with varying throughput and latency. Amazon SWF stores tasks and assigns them to workers when they are ready, tracks their progress, and maintains their state, including details on their completion. To coordinate tasks, you write a program that gets the latest state of each task from Amazon SWF and uses it to initiate subsequent tasks. Amazon SWF maintains an application's execution state durably so that the application is resilient to failures in individual components. With Amazon SWF, you can implement, deploy, scale, and modify these application components independently.

Components in SWF:
* **Workflow** - coordinate and manage the execution of activities that can be run asynchronously across multiple computing devices and that can feature both sequential and parallel processing.
* **Actor** - In the course of its operations, Amazon SWF interacts with a number of different types of programmatic actors. Actors can be workflow starters, deciders, or activity workers.
* **Workflow starter** - is any application that can initiate workflow executions. 
* **Decider** - is an implementation of a workflow's coordination logic. Deciders control the flow of activity tasks in a workflow execution.
* **Activity worker** - is a process or thread that performs the activity tasks that are part of your workflow. The activity task represents one of the tasks that you identified in your application.
* Tasks - Amazon SWF interacts with activity workers and deciders by providing them with work assignments known as tasks. There are three types of tasks in Amazon SWF:
  * **Activity task** – An Activity task tells an activity worker to perform its function, such as to check inventory or charge a credit card. The activity task contains all the information that the activity worker needs to perform its function.
  * **Lambda task** – A Lambda task is similar to an Activity task, but executes a Lambda function instead of a traditional Amazon SWF activity. 
  * **Decision task** – A Decision task tells a decider that the state of the workflow execution has changed so that the decider can determine the next activity that needs to be performed. The decision task contains the current workflow history.
* **Domains** - provide a way of scoping Amazon SWF resources within your AWS account. All the components of a workflow, such as the workflow type and activity types, must be specified to be in a domain. It is possible to have more than one workflow in a domain; however, ***workflows in different domains can't interact with each other***.

## Exam tips
* **SWF is a workflow** that **coordinate** work across **distributed components**.
* SWF vs SQS
  * **SWF** has a **retention** period for pending task of **up to 1 year**. SQS up to 14 days.
  * **SWF Use a task-oriented API**, SQS offers message-oriented API.
  * **SWF ensures** that a **task is assigned only once and never duplicated**, with SQS you need to control that by yourself. 
  * **SWF keeps track of all the tasks and events in an application**. With Amazon SQS, you need to implement your own application-level tracking