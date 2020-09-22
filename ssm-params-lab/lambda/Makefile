.DEFAULT_GOAL := apply

vars = -var-file="../../secrets.auto.tfvars" -var-file="../secrets.auto.tfvars"

init: 
	terraform init

Func.zip: Func.py
	zip Func.zip Func.py

plan: *.tf init Func.zip 
	terraform plan $(vars) -out plan.out

apply: plan 
	terraform apply "plan.out"
	rm plan.out

destroy: 
	terraform destroy $(vars) -auto-approve

show: 
	terraform show 

clean: destroy
	rm -rf plan.out terraform.tfstate*
    
