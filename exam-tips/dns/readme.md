# DNS Review

## Record types
* SOA - Star of Authority Record. Store name server that holds information about a zone, Admintrator name, versión of the records database file and default TTL to the zone.
    ```
    ;; ANSWER SECTION:
    google.com.		26	IN	SOA	ns1.google.com. dns-admin.google.com. 335602779 900 900 1800 60
    ```
* NS - Name Server Record. Authoritative information about the records of this zone.
    ```
    ;; ANSWER SECTION:
    google.com.		21599	IN	NS	ns3.google.com.
    google.com.		21599	IN	NS	ns1.google.com.
    google.com.		21599	IN	NS	ns2.google.com.
    google.com.		21599	IN	NS	ns4.google.com.
    ```
* A - Address associated with a DNS record.
    ```
    ;; ANSWER SECTION:
    ns3.google.com.		21599	IN	A	216.239.36.10
    ```
* CNAME - Canonical Name. Resolve a domain name with another. Used to redirect public known records to the service that provides. **Not the same as Alias**. **Cannot point to a naked domain record.** 
    ```
    ;; ANSWER SECTION:
    www.nyt.com.		299	IN	CNAME	www.nytimes.com.
    ```
* PTR - Pointer. Used to reverse 
    ```
    ;; ANSWER SECTION:
    56.154.253.54.in-addr.arpa. 299	IN	PTR	ec2-54-253-154-56.ap-southeast-2.compute.amazonaws.com.
    ```
* Alias - Alias **can point to a naked domain** (Naked domain is the SOA domain without a record). Is used to declare and alias for the complete domain. 
    ```
    ;; ANSWER SECTION:
    mydomain.net 299	IN	ALIAS	mydomain.com.
    ```