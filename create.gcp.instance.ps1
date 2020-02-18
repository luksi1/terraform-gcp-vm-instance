param (
  [parameter(Mandatory)]
  [string] $instance_name,
  [parameter(Mandatory)]
  [string] $project,
  [string] $credentials = 'secrets/secret.json'
)

Invoke-Expression "& terraform apply -auto-approve -var=`"project=$project`" -var=`"instance_name=$instance_name`" -var=`"credentials=$credentials`""
