param (
  [parameter(Mandatory)]
  [string] $instance_name,
  [parameter(Mandatory)]
  [string] $project,
  [string] $region = 'europe-west4',
  [string] $zone = 'europe-west4-a',
  [string] $image = 'ubuntu-1804-lts',
  [string] $machine_type = 'f1-micro',
  [string] $ssh_pub_key_file = './id_rsa.pub',
  [string] $credentials_file = 'secrets/secret.json'
)

[hashtable] $vars = @{
  instance_name    = $instance_name;
  project          = $project;
  region           = $region;
  zone             = $zone;
  image            = $image;
  machine_type     = $machine_type;
  ssh_pub_key_file = $ssh_pub_key_file;
  credentials_file = $credentials_file
}

$vars.Keys | ForEach-Object { $variables += "-var=`"$_=$vars.Item($_)`" " }

Invoke-Expression "& terraform apply -auto-approve $variables"
