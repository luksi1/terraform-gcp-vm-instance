#!/bin/bash

function usage() {
   echo "Start a GCP VM instance with Terraform"
   echo "Ex: Terraform apply"
   echo "  $0 -a apply -i <instance name> -p <project name> -c <credential file>"
   echo "  $0 --action apply --instance <instance name> --project <project name> --credential_file <credential file>"
   echo "Ex: Terraform destroy"
   echo "  $0 -a destroy -i <instance name> -p <project name> -c <credential file>"
   echo "  $0 --action destroy --instance <instance name> --project <project name> --credential_file <credential file>"
}

while [ "$1" != "" ]; do
  case $1 in
    -h | --help ) usage
                  exit
                  ;;
    -a | --action ) shift
                    action=$1
                    ;;
    -i | --instance ) shift
                      instance=$1
                      ;;
    -p | --project ) shift
                     project=$1
                     ;;
    -c | --credentials_file ) shift
                              credentials_file=$1
                              ;;
    * ) usage
        exit 1
    esac
    shift
done

terraform $action -auto-approve -var="project=${project}" -var="instance_name=${instance}" -var="credentials=${credentials_file}"
