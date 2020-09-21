# KMS Lab 

This labs creates a a Key to manage secrets that are encripted extenally, and the un encripted at boot time in the instance user data.

The lab is organized with the following resources groups:
* networking
  * Creates one VPC, with a public subnet where the valut instance will run
  * Anothr VPC will have the secret consumer
* kms
  * Creates the Key and the IAM profiles required to access the Key
  * Created an Alias to the Key
* server_vault
  * Will create the server 
  * Using user_data script, will encrypt a secret and publish it via HTTP
  * Will register a route53 record with the vault public IP
* server_client
  * Will fetch the secret, unencrypt and publish it :)
  
## Takeout from the lab:
* Every time that you encript the same value, you get different output. KMS includes other changing material with the original data, included the key alias used for encryption
* No alias is required to decript, becuase it is included in the cyphertext. 
* If you remove the IAM profile from the instance, and you try to run the encryp or decrypt operations, it will not find the key, due to the KMS policies.
* You can rotate the keys without modify the code (still, you have re encrypt the secrets, of course)

