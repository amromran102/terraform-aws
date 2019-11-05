# Terraform-AWS
Design a complete AWS cloud architecture in IaC fashion using Terraform

# Demo
Terraform is an infrastructure-as-code tool that makes it easier to define and manage cloud infrastructure throught the powerful syntax of HCL provided by Hashicorp, In this demo we will explain how Terraform works its magic to automate AWS cloud resources

# The aim of the project
- Design a new VPC schema and create associated subnets in different availability zones
- Design the routes and make your subnets public to be reachable from the Internet
- Create necessary security groups in the newly created VPC
- Create an EC2 linux instance in one of the subnets
- Choose specs of the instance: AMI, Instance_Type, Key-Pair, Volumes, etc..
- Attach Elastic IP and security groups to the instance

# What do you need to follow?
AWS account and IAM admin programmatic user, Setup AWS profile in order for Terraform to operate with these credentials.

Notice: we are launching an EC2 Linux server, this demo demands that you have AWS Key_Pair already created in your account. In which case you will update a variable "key_name" in the configuration file variable.tf

# Now its time to operate
Clone the project into your workspace, Issue ($ terraform init) to initiate your project. You can check the config files are valid through ($ terraform validate), Issue ($ terraform plan) to look through the resources that will be created and finally issue ($ terraform apply -auto-approve) to automate the infrastructure creation
