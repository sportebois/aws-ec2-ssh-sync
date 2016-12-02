.PHONY: all plan apply destroy refresh

all: plan apply

refresh:
	terraform refresh -var-file secret.tfvars

plan:
	terraform plan -var-file secret.tfvars -out terraform.tfplan

apply:
	terraform apply -var-file secret.tfvars

destroy:
	terraform plan -destroy -var-file secret.tfvars -out terraform.tfplan
	terraform apply terraform.tfplan