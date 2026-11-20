# Valeurs par défaut utilisées si aucun -var-file n'est passé.
# Pour un déploiement explicite dev/prod, préférez :
#   terraform apply -var-file="envs/dev.tfvars"
#   terraform apply -var-file="envs/prod.tfvars"

project_name = "corvexa"
environment  = "dev"
gcp_region   = "europe-west1"

labels = {
  owner = "aliou"
  cours = "cloud-floci-terraform"
}
