.DEFAULT_GOAL := apply

vars = -var-file="../secrets.auto.tfvars"

init: 
	terraform init

plan: *.tf 
	terraform plan $(vars) -out plan.out

apply: plan
	terraform apply "plan.out"

destroy: 
	terraform destroy $(vars) -auto-approve

