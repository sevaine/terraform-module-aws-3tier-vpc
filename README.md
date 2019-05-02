Standard AWS VPC module
-----------------------

Simple terraform module to deploy a 3-tier ( public, private, data ) VPC in AWS.  See below for list of resources deployed


## What gets deployed

 * AWS VPC
 * Public subnets ( 3 availability zones )
 * Private subnets ( 3 availability zones )
 * Data subnets ( 3 availability zones )
 * Internet Gateway
 * Single NAT Gateway in AZ A
