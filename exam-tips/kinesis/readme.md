# Kinesis
## Concepts
Amazon Kinesis makes it easy to collect, process, and analyze video and data streams in real time.

## Kinesis Streams

**Amazon Kinesis Data Streams** to collect and process large **streams of data records in real time**. You can create **data-processing applications**, known as Kinesis Data Streams applications. A typical Kinesis Data Streams application reads data from a data stream as data records. These applications can use the Kinesis Client Library, and they can run on Amazon EC2 instances. You can send the processed records to dashboards, use them to generate alerts, dynamically change pricing and advertising strategies, or send data to a variety of other AWS services.

The **producers** continually push data to Kinesis Data Streams, and the **consumers** process the data in real time. Consumers (such as a custom application running on Amazon EC2 or an Amazon Kinesis Data Firehose delivery stream) can store their results using an AWS service such as Amazon DynamoDB, Amazon Redshift, or Amazon S3.

![Kinesis Streams](./architecture.png)

### Terms
* ***Producers*** - put records into Amazon Kinesis Data Streams. 
* ***Consumers*** get records from Amazon Kinesis Data Streams and process them. These consumers are known as Amazon Kinesis Data Streams Application. There can be **multiple applications for one stream**, and each application can consume data from the stream **independently and concurrently**.
* A ***shard*** is a **uniquely identified sequence of data records** in a stream. A stream is composed of one or more shards, each of which provides a fixed unit of capacity.
* A ***Kinesis data stream*** is a **set of shards**. Each shard has a **sequence of data records**. Each data record has a **sequence number** that is assigned by Kinesis Data Streams.
* ***Data Record*** - is the **unit of data stored in a Kinesis** data stream. Data records are composed of a **sequence number**, a **partition key**, and a **data blob**, which is an **immutable** sequence of bytes. **Kinesis Data Streams does not inspect, interpret, or change the data in the blob in any way**. A data blob can be up to 1 MB.
* ***Retention period*** - length of **time that** data records **are accessible after they are added to the stream**. A stream’s retention period is set to a **default of 24 hours** after creation. 
* ***Partition key*** is used to group data by shard within a stream. Kinesis Data Streams segregates the data records belonging to a stream into multiple shards.

## Exam Tips
* **Kinesis load and analyze streaming data**. Also provides the capacity to build your own custom applications.
* ***Kinesis Streams*** process **shards of data**. Supports **retention** of shards from **24 hours (default) to 7 days**
* Shards are processed by consumers (EC2 instances for example) and then deleted.
* **Shards rates**: 
  * 5 transactions/sec for reads
  * 2 MB read per second
  * 1000 records/sec of writes
  * 1 MB write per second
* ***Kinesis Firehose*** do not have shard nor persistence. You need to do something with the data as they arrive. Use Lambda.
* ***Kinesis Analytics*** Analysis data inside Streams and Firehose