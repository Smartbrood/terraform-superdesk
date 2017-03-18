# terraform-superdesk
Terraform and Packer to deploy Superdesk, Apcera, BRL-CAD in Clouds

## Requirements
+ git
+ make
+ terraform


## Caveats
+ Superdesk installator doesn't work on instances with memory less whan 2GB.


## Usage
Install **git**, **make** and **terraform**

Clone repo
```bash
git clone https://github.com/Smartbrood/terraform-superdesk.git
```

Change to repo dir
```bash
cd terraform-superdesk
```

+ Copy **terraform.tfvars.example** to **terraform.tfvars** and fill-in your credentials.

Deploy to AWS
```bash
make aws
```

Destroy AWS
```bash
make destroy_aws
```

## Vagrant

```bash
sudo vagrant up
```

## TODO
+ Ansible playbook: Add https support to superdesk, Backup Superdesk data.
