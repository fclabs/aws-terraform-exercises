# CloudWatch

## Concepts

Amazon CloudWatch monitors your Amazon Web Services (AWS) resources and the applications you run on AWS in real time. You can use CloudWatch to collect and track metrics, which are variables you can measure for your resources and applications.
You can create alarms that watch metrics and send notifications or automatically make changes to the resources you are monitoring when a threshold is breached. 

![CloudWatch](./CW-Overview.png)

Metrics are **stored separately in Regions**, but you can use CloudWatch cross-Region functionality to aggregate statistics from different Regions.

The following terminology and concepts are central to your understanding and use of Amazon CloudWatch:
* **Namespaces**: is a ***container*** for CloudWatch metrics. Metrics in different namespaces are isolated from each other, so that metrics from different applications are not mistakenly aggregated into the same statistics.
* **Metrics**: represents a time-ordered set of data points that are published to CloudWatch. Metrics are **uniquely defined by a name, a namespace, and zero or more dimensions**. Metrics can have different resolutions:
  * Standard Resolution: one-minute granularity
  * High Resolution: one second granularity
* **Dimensions**: is a ***name/value pair*** that is part of the identity of a metric. You can assign ***up to 10 dimensions to a metric***.
* **Statistics**: metric ***data aggregations*** over specified periods of time. Aggregations are made using the namespace, metric name, dimensions, and the data point unit of measure, within the time period you specify. Following are the supported statistics:
  * Minimum
  * Maximum
  * Sum
  * Average
  * SampleCount: The count (number) of data points used for the statistical calculation.
  * pNN.NN: The value of the specified percentile. You can specify any percentile, using up to two decimal places (for example, p95.45). Percentile statistics are not available for metrics that include any negative values.
* **Percentiles**: indicates the relative standing of a value in a dataset. Percentiles help you get a better understanding of the distribution of your metric data. Percentiles are often ***used to isolate anomalies.***
* **Alarms**: You can use an alarm to automatically ***initiate actions*** on your behalf. An alarm watches a single metric over a specified time period, and performs one or more specified actions, based on the value of the metric relative to a threshold over time. 

## Essential Tips


## Labs about
*

## References and complementary readings

