.DEFAULT_GOAL := apply

vars = -var-file="../config.auto.tfvars" -var-file="../../secrets.auto.tfvars" -var-file="../secrets.auto.tfvars"

init: 
	terraform init

plan: *.tf init 
	terraform plan $(vars) -out plan.out

repo2s3.zip: repo2s3.py
	zip repo2s3.zip repo2s3.py

apply: plan repo2s3.zip
	terraform apply "plan.out"
	rm plan.out

destroy: 
	terraform destroy $(vars) -auto-approve

show: 
	terraform show 

clean: destroy
	rm -rf plan.out terraform.tfstate* Func.zip
    
