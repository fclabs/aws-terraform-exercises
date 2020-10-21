.DEFAULT_GOAL := apply

vars = -var-file="../../secrets.auto.tfvars" -var-file="../config.auto.tfvars" 

config.tf: 
	ln -s ../config.tf

init: config.tf
	terraform init

plan: *.tf init 
	terraform plan $(vars) -out plan.out

apply: plan
	terraform apply "plan.out"

destroy: 
	terraform destroy $(vars) -auto-approve

show: 
	terraform show 

clean: destroy
	rm -rf plan.out terraform.tfstate*
    
