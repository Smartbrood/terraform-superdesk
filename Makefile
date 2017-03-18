DIGITALOCEAN_SUPERDESK_IMAGE = $(shell jq ".builds[].artifact_id[5:100]" packer/manifest.json)

.PHONY: apply get validate plan digitalocean aws show destroy_aws destroy_digitalocean debug_aws packer
 
get:
	terraform get

validate: get
	terraform validate

plan: validate
	terraform plan

show: plan
	terraform show


#AWS
aws: plan
	terraform apply -target=module.aws \
	terraform refresh \
	terraform output aws_public_ip

destroy_aws: validate
	terraform plan -destroy -target=module.aws ; terraform destroy -target=module.aws

debug_aws:
	TF_LOG=1 ; export TF_LOG ; terraform plan ; terraform apply -target=module.aws


#Digitalocean
##Build image with Packer first
packer:
	packer build \
		-var-file=secrets.json \
		./packer/superdesk.json ; \
	terraform plan ; \
	terraform apply \ 
		-target=module.digitalocean \
		-var digitalocean_superdesk_image=${DIGITALOCEAN_SUPERDESK_IMAGE}	

digitalocean: plan 
	terraform apply -target=module.digitalocean

destroy_digitalocean: validate
	terraform plan -destroy -target=module.digitalocean ; terraform destroy -target=module.digitalocean

