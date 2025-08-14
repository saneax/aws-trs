aws training repo
1. given a situation where I would like to create some resources on aws via IaaS, ie. terraform,
can you help me design a simple terraform playbook to create an EC2 instance and delete it. Please
take special care in not storing the authentication in the code. I am planning to put this inside
a github repository. This is to learn terraform and aws and using credentials in a safe manner
2.  



The best practice is to let Terraform read credentials from the environment where it's being run. The official AWS provider for Terraform is built to do this automatically.

Step 1: Set Up Your AWS Credentials Securely

Instead of writing your keys in a .tf file, you will set them as environment variables in your terminal. Terraform will find and use them automatically. This way, your secret keys never get saved in your project's code.

export AWS_ACCESS_KEY_ID="YOUR_AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="YOUR_AWS_SECRET_ACCESS_KEY"

