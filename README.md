# Infrastructure as code in AWS using terraform

## An infrastructure to deploy three instances namely webserver, bastion and database respectively.

## A custom VPC with two public and a private subnet is setup.

## The instances webserver and bastion are created on public subnet and database on private subnet.

## A NAT gateway is created and an Elastic IP is allocated.

## Security groups are created for each instances and route tables are configured.

## Userdata scripts are added for instances webserver and database.


Execution
=========

***terraform validate***   - Syntax check.

***terraform plan*** - Creating an execution plan.

***terraform apply*** - Apply the changes.

***terraform destroy*** - Destroy the terraform managed infrastructure.
