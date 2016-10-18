# IAC-Terraform
## Automation for the People Using Terraform!
Infrastructure as Code (IaC) is not only a powerful process for DevOps but a way of life!
Instead of depending on physical hardware configurations or interactive configuration tools,  
We can instead use tools like [Terraform](https://www.terraform.io) to automatically: 

1. Provision an environment running on the Linux operating system
2. Configure a web server running in the provisioned environment

## Prerequisites
This sample project aims to demonstrate provisioning resources on [Amazon Web Services](https://aws.amazon.com) (AWS). 
Ensure you have the following before proceeding:
* AWS access and secret keys
* AWS key pair

## AWS Free-Tier Usage
For this example, we'll be using resources which qualify under the AWS [free-tier](https://aws.amazon.com/free/). 

**Warning!** 
If you're not using an account that qualifies under the AWS free-tier, you may be charged to run this example. 
The most you should be charged is a few dollars, but I am not responsible for any charges that may be incurred.

## Provisioning
The default Terraform plan will provision the following resources:
- VPC x 1
- Internet Gateway (IGW) x 1
- Subnet x 2
- Route x 1
- Security Group x 3
- EC2 x 2
- IAM Instance Profile x 1
- IAM Instance Role x 1
- ELB x 1

Furthermore, each EC2 instance will be provisioned with [nginx](http://nginx.org/en/) as the HTTP server 
and a custom index page with the inspirational message: "Automation for the People!".

## Planning
Execute the following steps to provision a basic two-tier architecture on AWS:

1. Download and [install Terraform](https://www.terraform.io/intro/getting-started/install.html)
2. Clone or fork this repository
3. Customize `terraform.template` and save it as `terraform.tfvars` in the project root
4. Save a copy of `launch.template` as `launch.sh` in the project root
5. Open a terminal window in your local repository location and make the launch script executable:
```$ chmod u+x launch.sh```
6. Run the following command to examine the Terraform execution plan before deploying to AWS:
```$ terraform plan```
7. Review the proposed changes and make any modifications necessary
8. Repeat steps 6 and 7 until satisfied with the execution plan
9. Run the following command to execute the Terraform plan and deploy the infrastructure to AWS:
```$ ./launch.sh```
10. After the infrastructure is deployed, the public DNS of the load balancer will be displayed in the terminal:
```
$ Outputs:

address = <resource_name>-<resource_id>.<aws_region>.elb.amazonaws.com
```

Visit `https://<elb-address>/` in your favorite web browser to see the new infrastructure in action.

**NOTE** The ELB DNS address will likely be available before all instances are registered 
so wait at least 10 minutes prior to visiting that address in a browser or reload the page after 10 minutes have passed.

## Cleanup
Once you're finished with the sample infrastructure you should destroy it to avoid any unnecessary charges.
From the project root, execute the following command:

```$ terraform plan -destroy```

which will allow you to review the changes prior to termination. Once you're satisfied, run:

```$ terraform destroy```

to confirm the termination and destroy your infrastructure resources.

## Future Enhancements
This project is only an sample of what is possible using Terraform. For example, further enhancements could be made by
provisioning [Launch Configurations](https://www.terraform.io/docs/providers/aws/r/launch_configuration.html) and [Auto Scaling Groups](https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html) to replace some of the variable interpolation
currently present.
