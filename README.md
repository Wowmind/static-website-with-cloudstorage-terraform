# static-website-with-cloudstorage-terraform without DNS
The simple way to start is to create your static index.html and 404.hmtl file in the same directory of the terraform.
create a project on google cloud, You must have a billing account.
create a service account that have both roles of Editor and storage object admin to have acess.
Download the json-key of the service account and upload it to your code.
Then create your bucket first.
Terraform init. terraform plan, terraform apply.

Then specified the source of your index.html and 404.html file from your local directory.
follow the procedure from the main.tf. 
create the necessary pages for your variable, provider and variable.auto and deploy...
