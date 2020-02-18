#!/bin/bash

function usage() {
   echo "Start a GCP VM instance with Terraform"
   echo "Ex:"
   echo "  $0 -i <instance name> -p <project name> -c <credential file>"
   echo "  $0 --instance <instance name> --project <project name> --credential_file <credential file>"
}

while [ "$1" != "" ]; do
  case $1 in
    -h | --help ) usage
                  exit
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

terraform apply -auto-approve -var="project=${project}" -var="instance_name=${instance}" -var="credentials=${credentials_file}"
