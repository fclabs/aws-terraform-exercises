.DEFAULT_GOAL := apply

vars = -var-file="../secrets.auto.tfvars" -var-file="secrets.auto.tfvars"

init: 
	terraform init

plan: *.tf init 
	terraform plan $(vars) -out plan.out

apply: plan
	terraform apply "plan.out"

destroy: 
	terraform destroy $(vars) -auto-approve

clean: destroy
	rm -rf plan.out terraform.tfstate*
    
