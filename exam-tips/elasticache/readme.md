# Elasticache
## Concepts

Amazon ElastiCache makes it easy to set up, manage, and scale distributed **in-memory cache** environments in the AWS Cloud. It provides a high performance, resizable, and cost-effective in-memory cache, while removing complexity associated with deploying and managing a distributed cache environment. **ElastiCache works with both the Redis and Memcached engines**.

### Comparing Memcache vs Redis

Feature|MemCache|Redis
:-------|:--------:|:-----:
Simple Cache to Offload DB | Yes | Yes
Ability to scale horizontally | Yes | Yes
Multi-threaded performance | Yes | No
Advanced Data Types | No | Yes
Ranking/Sorting Data sets | No | Yes
Pub/Sub capabilities | No | Yes
Persistence | No | Yes
Multi-AZ | No | Yes
Backup & Restore Capabilities | No | Yes

## Exam tips
* **Elasticache** is used to **increase DB and Web application performance**
* **Redis** is **Multi-AZ**
* **Redis** supports **Backup & Restore**
* If you need **horizontally scaling**, use **Memcache**.