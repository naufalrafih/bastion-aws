# bastion-terraform
Setup bastion host in AWS using terrafom and terragrunt <br>
Terrafom step by step:
1. Go to [module](module) directory <br>
2. Change the value in [variables.tf](variables.tf) to customize <br>
3. Run ```terraform apply``` <br>

Terragrunt step by step:
1. Go to [dev](dev) or [prod](prod) directory <br>
2. Run ```terragrunt apply``` <br>
3. You can also run ```terragrunt run-all apply``` in [terragrunt](terragrunt) directory to create both resources
