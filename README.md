# terraform-superdesk
Terraform and Packer to deploy Superdesk, Apcera, BRL-CAD in Clouds

## Requirements
+ make
+ terraform


## Caveats
+ Superdesk installator doesn't work on instances with memory less whan 2GB.


## AWS

### Deploy
```bash
make aws
```

### Destroy
```bash
make destroy_aws
```

## Vagrant

```bash
sudo vagrant up
```

## TODO
+ Ansible playbook: Add https support to superdesk, Backup Superdesk data.
