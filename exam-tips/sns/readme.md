# Simple Notification Service
## Concepts

Amazon Simple Notification Service (Amazon SNS) is a managed service that provides message delivery from publishers to subscribers (also known as producers and consumers). Publishers communicate asynchronously with subscribers by sending messages to a topic, which is a logical access point and communication channel. Clients can subscribe to the SNS topic and receive published messages using a supported protocol, such as Amazon SQS, AWS Lambda, HTTP, email, mobile push notifications, and mobile text messages (SMS).

![SNS](./sns-how-works.png)

## Exam Tips
* Instantaneous, **push-based delivery (no polling)**
* Simple API and easy integration with applications
* Flexible message **delivery over multiple transport protocols**
* Inexpensive, pay-as-you-go model with no up-front costs.
* Web-based AWS Management Console offers the simplicity of a point-and-click interface.
* SNS vs SQS:
  * Both are messaging systems in AWS
  * **SNS - Push**
  * **SQS - Pull**
