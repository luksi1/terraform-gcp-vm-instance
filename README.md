[![Build Status](https://travis-ci.org/luksi1/terraform-gcp-vm-instance.svg?branch=master)](https://travis-ci.org/luksi1/terraform-gcp-vm-instance)

# terraform-gcp-vm-instance
Configure a bare bones GCP VM instance with Terraform

## Description
This terraform file, and accompanying bash and powershell wrappers, provide a simple way to create a GCP VM instance with SSH access. Additionally, Terraform will output the external IP of the instance.

The private use case for this was simply to create up a GCP VM instance to work via VSCode remote, but this could be used for anything.

## Dependencies
- Terraform

## Up and running
The following examples will create GCP VM instance with:

- region: europe-west4
- zone: europe-west-a
- image: ubuntu-1804-lts
- machine_type: f1-micro
- ssh_pub_key_file: ./id_rsa.pub

### Powershell

###### Create instance
```powershell
gcp.instance.ps1 -action apply -instance_name foo -project my-project -credential secrets/my.json
```

###### Destroy instance
```powershell
gcp.instance.ps1 -action destroy -instance_name foo -project my-project -credential secrets/my.json
```

### Terraform
```terraform
terraform apply -auto-approve -var="project=my-project" -var="instance_name=foo" -var="credentials=./secrets/my.json"
```

##### Additional Terraform parameters
Simply add any one of the following variable by appending `-var="key=value"`

- region (default: europe-west4)
- zone (default: europe-west4-a)
- image (default: ubuntu-1804-lts)
- machine_type (default: f1-micro)
- ssh_pub_key_file (default: ./id_rsa.pub)
