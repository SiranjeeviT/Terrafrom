Project Overview:

The purpose of an infrastructure project is to establish and maintain a reliable and scalable technology foundation 
that supports the organization's applications, services, and operations. This foundation typically includes computing 
resources, networking components, storage solutions, and other essential infrastructure elements.

Application or Server Deployment: 

Creating an infrastructure to deploy and run service efficiently, ensuring optimal performance and reliability.

Scalability: 

Designing the infrastructure to handle varying levels of workload and scale resources dynamically as demand fluctuates.

Automation: 

Implementing automated processes for provisioning, configuration, and management of infrastructure components, enhancing efficiency and reducing manual intervention.

Reusable and time saving: 

Develop reusable for common tasks, such as provisioning resources or updating configurations.
These can be integrated into your automation workflows, saving time creating infrastruture used to HCL code.

Dependencies: 

Tools required to use or run the Terraform.
AWS account, putty gen, putty exe and visual studio code. Download Terrafrom zip file then unzip it. 
Set the system path if it is ubuntu machine system path is /usr/local/bin/ and any other machine to find out system path then moved to terraform file with file extension.
Create a role because AWS one service to communicated to other services, so created then given access for that services.
Then written program using HashiCorp Configuration Language HCL.

Resource Descriptions:

Include information on resource keyword resource names and resource reference.
Dependencies of vpc, subnet id, tags, etc.

Execution and Usage:

terraform init this command reads your configuration files, installs the required providers, and sets up the backend.
terraform plan this command shows you the proposed changes without actually applying them. Review the plan to ensure it aligns with your expectations.
terraform apply Terraform will prompt you to confirm that you want to apply the changes. Type 'yes' and press Enter. This step may take some time, 
depending on the complexity of your infrastructure and the changes being made.

Resource Tracking:

The state file maintains a record of the current state of the infrastructure. It includes information about all the resources that Terraform manages, such as their attributes, dependencies, and relationships.
If any service added to the infrastruture for example data base service added in mannually on AWS then use terraform import this command updated the terraform state file.
If any service reconfigure it for example to increase the size of EBS in mannually on AWS then use terraform refresh this command also updated the terraform state file.

Destroying Resources:

terraform destroy: Similar to the apply this command, Terraform will prompt you to confirm the destruction of resources. Type 'yes' and press Enter. 
Then destroyed all the infrastruture on that system path terraform file on it.
