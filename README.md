# Terraform-Basics

These are my own notes for Terraform.

CFTs (CloudFormation Templates) are JSON or YAML files used by AWS CloudFormation to define and provision AWS infrastructure as code (IaC). They 
allow us to automate the deployment and management of AWS resources like EC2, S3, RDS, VPCs, Lambda, IAM roles, and more. 

Infrastructure as Code (IaC) → Define our AWS setup in a version-controlled, reusable template.

Automation → Deploy, update, and delete resources automatically.

Consistency → Ensures that deployments remain the same across environments.

Rollback & Change Management → If deployment fails, CloudFormation can roll back changes.

Easier Management → Define multiple AWS services in one file instead of configuring them manually.

We can manage this process well with CloudFormation Templates but what if we need to migrate from AWS to Azure? We cannot use these CFTs on 

Azure as it belongs to AWS. We can create our own templates for Azure but we what if we migrate to on-premises?

We can use Openstack to create our own cloud system. We use Heat Templates here. 

Some companies follow a hybrid cloud infrastructure. They use both AWS and Azure. Let’s say AWS offers good storage services and Azure offers 
devops services. For this, the developers need to learn both AWS CFT and Azure RM for templates. And also Heat Teamplates for on-premises.

To solve this problem we use Terraform. The concept here is “Infrastructure as code”. Instead of learning all the tools we can use just 
Terraform. Terraform uses APIs to interact with cloud providers.

As devops engineers we create a terraform script for each cloud provider separately. We still need to migrate a Terraform script for AWS to a 
Terraform script for Azure but the changes are minimal. 

API as Code is a concept where infrastructure or configurations are managed using API calls rather than manual changes. This means that 
infrastructure, cloud resources, and services are provisioned, updated, and managed through APIs, often defined in code.

How It Works?
    Write Code: Define the infrastructure using a configuration language (e.g., JSON, YAML, HCL).
    Make API Calls: The tool interacts with cloud provider APIs (AWS, Azure, GCP) to provision resources.
    Automate & Manage: Updates and changes are done via API calls instead of manually adjusting settings.

API as Code → Automating cloud interactions via API calls (e.g., using AWS SDK).

Infrastructure as Code → Defining and managing infrastructure in code (e.g., using Terraform).

API is Application Programming Interface. Using APIs, we can talk to an application and get the response. For example, if we want to talk to 
Google, we can open a browser and do it. But if we need to do it programmatically, instead of using a browser we can use a script. And this 
script will talk to Google. It will perform the task and get the response back. For example GitHub created APIs for this. We can use “curl” or 
“https get” requests to talk to GitHub’s APIs.

Imagine we’re at a restaurant:
    Customer (Client/User) → We want to order food.
    Waiter (API) → Acts as a middleman, taking our order to the kitchen and bringing back our food.
    Kitchen (Server/Backend) → Prepares the food and hands it to the waiter.

Terraform uses the same concept. Terraform converts our request into an API call and gets the response from AWS or Azure. So, Terraform is IaC, 
but it uses APIs to manage cloud infrastructure.

Let’s say we use AWS as Terraform Provider. In this case Terraform will convert the configuration files into API calls that AWS will 
understand. And if we want to change our script to Azure later on, we modify the script files and Terraform will do the rest for us. We still 
need to do modification but the Terraform language is the same. If we want to immigrate to another cloud provide ,we need to modify the 
Terraform configuration file but again Terraform will take care of the rest.

Why Use Terraform?

1- Manage Any Infrastructure: Terraform is cloud-agnostic, meaning it supports AWS, Azure, GCP, on-premises, and hybrid environments. It uses 
providers to interact with different platforms, allowing us to define infrastructure as code (IaC) across multiple clouds.

2- Track our Infrastructure: Terraform maintains a state file (terraform.tfstate) that records all deployed resources. This helps in tracking changes, troubleshooting, and ensuring consistency between the actual infrastructure and the desired configuration.

3- Automate Changes: Terraform follows a declarative model, meaning we define the desired state, and it handles the provisioning. The terraform plan and terraform apply commands ensure that only the necessary changes are made, reducing manual effort.

4- Standardize Configurations: Infrastructure can be defined using reusable modules, ensuring consistency across environments.
    This eliminates configuration drift and enforces best practices across teams and projects.

5- Collaborate: Terraform enables team collaboration by storing state remotely (e.g., S3 + DynamoDB for AWS). Terraform Cloud and Terraform 
Enterprise offer features like role-based access control (RBAC) and versioned infrastructure updates.

First step is to write Terraform Configuration Files. For this we can get help from Terraform AWS Documentation. For example we can look at an example for a Lambda function and copy it from there, and make the necessary modification. If a particular AWS resource is not listed in this documentation it means that Terraform doesn’t support that resource yet.

Second step is to plan. Once we have the configuration file, Terraform will take the configuration file, create and API for it and submits the API to the target cloud provider. 
If there are any mistakes or we want to take a look at the list of the things that are going to be created, we use Terraform plan.

Last step is apply.

We can install Terraform by following the steps of their official documentation.

“terraform init” will initialize terraform. 

We create a terraform file with “vim main.tf”. And we copy the source code in it to create an EC2 instance. We can get the source code from 
Terraform documentation.

In this main.tf file, we start with our cloud providers’ information. We usually modify the last part where we define our resources. 

We use input.tf file to define input variables. This file contains input variables that allow users to provide values dynamically instead of 
hardcoding them.

And we use output.tf file to define output values. This file contains output values that display important information after applying the 
configuration. Outputs display key resource information after deployment. Useful for referencing values in scripts or Terraform modules.

But now we have main.tf file and let’s execute it. 

We execute “terraform plan.” If we get authentication error we should create an access key in IAM. 

After executing “aws configure” we can write access key and secret access key and get authenticated. Then we execute “terraform plan”.

When we run terraform plan, Terraform generates an execution plan, showing what changes it will make to our infrastructure.

Resources to be Created (+ sign): + aws_instance.app_server
Resources to be Updated (~ sign): ~ instance_type = "t2.micro" -> "t2.small"
Resources to be Destroyed (- sign): - aws_instance.app_server
Resources That Will Be Replaced (-/+ sign): -/+ aws_instance.app_server (forces replacement)
Outputs (if defined in output.tf)

If everything looks correct, we can appy changes by running “terraform apply”.

Then we can execute “aws ec2 describe-images --owners amazon” to see if our instance has been created.

The output.tf file in Terraform is used to define outputs that we want Terraform to display after it successfully applies changes. These 
outputs can include information like the public IP of an EC2 instance, the ID of a resource, or any other important value that can be useful 
for subsequent actions or for manual inspection.

The variables.tf file in Terraform is used to define input variables that allow us to pass values into our Terraform configuration. Variables 
make our Terraform scripts more flexible and reusable because they let us customize resource properties without changing the main code.

Why Use Variables?
    Reuse the same Terraform code in different environments (e.g., dev, prod).
    Provide customizable values for different resources, like instance types, regions, etc.
    Avoid hardcoding values in our configuration files.

The terraform.tfstate file is critical in Terraform as it contains the state of our infrastructure. This file is automatically created by 
Terraform when we run commands like terraform apply, and it is updated every time we make changes to our infrastructure. The terraform.tfstate 
file holds a snapshot of the infrastructure that Terraform manages. It includes the current configuration and metadata about the resources 
we’ve created, updated, or destroyed. The terraform.tfstate file is the source of truth for Terraform. It allows Terraform to understand the 
current state of our infrastructure and make necessary changes when we modify our configuration.

When we run terraform plan or terraform apply, Terraform compares the current configuration (in your .tf files) to the information in the 
terraform.tfstate file to determine what changes need to be made. The state file helps ensure consistency in managing infrastructure. Without it, Terraform wouldn’t be able to track our resources across different runs.

We shouldn’t push the terraform.tfstate file to our GitHub as it contains sensitive data like passwords or secret keys. We should never store 
our state files on our local machine, or in source control. We should store them in remote backends.

And we do not manipulate the state files as Terraform might get corrupted. That’s why we only give read permissions to state files.

It is a good idea to store the state files in an S3 bucket. Because then when someone modifies the Terraform scripts, the state files in S3 
bucket will get updated automatically. So we store the state files in S3 and use DynamoDB for state locking to prevent concurrent changes. Once 
we set this up Terraform will not allow parallel execution of the scripts. 

We should isolate and organize the state files to reduce the blast radius. We should structure Terraform state files in a way that limits the 
impact of failures or unintended changes. The blast radius refers to the scope of impact when something goes wrong (e.g., accidental deletions, 
misconfigurations, or failed deployments). So we should use multiple state files for different environments like dev, stating, and production.

Problems with Terraform:

- State file is single source of truth. If it is corrupted somehow it messes up with our infrastructure.
- Manual changes to the cloud provider cannot be identified and auto-corrected. If someone modifies AWS resources directly (outside Terraform), Terraform won’t detect and revert them automatically. Running terraform plan may show differences, but it won’t fix things unless we explicitly apply changes.
- Not a GitOps friendly tool. Don’t play well with Flux or Argo CD.
- Can become very compley and difficult to manage. As infrastructure grows, Terraform configurations become large and hard to maintain. Handling multiple environments, state files, and dependencies requires careful organization.
- Trying to position as a configuration management tool as well. But tools have to work natively for their own purposes. Terraform is primarily an infrastructure provisioning tool, but HashiCorp is pushing it into configuration management (like Ansible, Puppet, or Chef).
