# Module 3: Infrastructure as Code intro

Infrastructure as Code (IaC) is the management of infrastructure (networks, virtual machines, load balancers, and connection topology) in a descriptive model, using the same versioning as DevOps team uses for source code. Like the principle that the same source code generates the same binary, an IaC model generates the same environment every time it is applied. IaC is a key DevOps practice and is used in conjunction with continuous delivery.

![Infrastructure as code defines the environment in a versioned file](img/m31.png)

## Jumpstarting our IaC experience

In order to get a running start with Infrastructure as code, in Azure, we can export previously deployed resources as an Azure Resource Manager Template (ARM Template). While this offers us a great place to get started, the "**Export**" feature exports as much of the information as it can get its hands on, making the exported template quite verbose. Oftentimes the exported template must be modified before it can be of any real use.

We can demonstrate this feature via the Portal, where we can export a template of the storage account from module two!

1. Navigate to your storage account in the Azure Portal
2. Open the storage account resource
3. Scroll down to "Export Template"
4. Download the template.
4. Unpack the downloaded archive, it should contain two files: "**template.json**" and "**parameters.json**"

## Redeploying an exported template

1. Redeploy the template with new parameters by selecting "***+ Create a resource**"
2. Search for "**Template deployment (deploy using custom templates)**" and select the "**Create**" option
3. Select the "**Build your own template in the editor**" and load the "**template.json**"
4. Hit the "**Save**" button
5. You may optionally do the same for the parameters file.
6. Select your "**hogent-(your-initials)-rg**" resource group.
7. Since a storage account must be globally unique, you must slightly modify the storage account's name.
8. Select  "**Review + create**" to deploy the resource.

⚠️ Notice that the deployment may fail, this is could be due to:

- The "**Export**" may export redundant information which conflicts with defaults that are set by the Resource Provider at deployment time.
- The storage account's name must be globally unique and if your storage account from module two is still operational then the Resource Provider will not be able to deploy another one with the same name. Try slightly modifying the storage account's name.

## Was everything deployed succesfully?

Take a look at the storage account that we just deployed, can you see what didn't get deployed?