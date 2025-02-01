# AWS Infrastructure with Terraform

This Terraform project provisions an AWS infrastructure that includes a VPC, subnets, ECS clusters, and associated networking components. The infrastructure is designed to host a web application and a database in a secure and scalable manner.

## Architecture Overview

The architecture consists of the following components:

1. **VPC (Virtual Private Cloud)**: A logically isolated network for hosting your resources.
2. **Subnets**:
   - **Public Subnet**: Hosts the web application ECS cluster and is accessible from the internet.
   - **Private Subnet**: Hosts the database ECS cluster and is not directly accessible from the internet.
3. **ECS (Elastic Container Service)**:
   - **Web ECS Cluster**: Deployed in the public subnet to serve the web application.
   - **DB ECS Cluster**: Deployed in the private subnet to host the database.
4. **EBS (Elastic Block Store)**: A persistent storage volume attached to the database ECS instance for data storage.
5. **NAT Gateway**: Allows resources in the private subnet to access the internet for updates and patches while remaining secure.
6. **Internet Gateway**: Enables communication between the public subnet and the internet.
