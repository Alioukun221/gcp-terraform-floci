# Tests unitaires du module storage, exécutés en mode "plan" uniquement
# contre un provider google MOCKÉ (aucun appel réseau, aucune dépendance à
# Floci-GCP) : terraform test tests/storage.tftest.hcl

mock_provider "google" {}

variables {
  bucket_name = "corvexa-dev-media-archive-a1b2c3"
  project     = "floci-local"
  region      = "europe-west1"
}

run "default_storage_class_is_standard" {
  command = plan

  module {
    source = "./modules/storage"
  }

  assert {
    condition     = google_storage_bucket.this.storage_class == "STANDARD"
    error_message = "La classe de stockage par défaut doit être STANDARD."
  }

  assert {
    condition     = google_storage_bucket.this.force_destroy == false
    error_message = "force_destroy doit être false par défaut (protection en prod)."
  }

  assert {
    condition     = google_storage_bucket.this.uniform_bucket_level_access == true
    error_message = "L'accès uniforme au niveau bucket doit toujours être activé."
  }
}

run "prod_profile_uses_nearline_and_versioning" {
  command = plan

  variables {
    storage_class      = "NEARLINE"
    versioning_enabled = true
  }

  module {
    source = "./modules/storage"
  }

  assert {
    condition     = google_storage_bucket.this.storage_class == "NEARLINE"
    error_message = "Le profil prod doit utiliser la classe NEARLINE."
  }
}

run "rejects_invalid_storage_class" {
  command = plan

  variables {
    storage_class = "INVALID"
  }

  module {
    source = "./modules/storage"
  }

  expect_failures = [
    var.storage_class,
  ]
}

run "rejects_invalid_bucket_name" {
  command = plan

  variables {
    bucket_name = "-invalid-name-"
  }

  module {
    source = "./modules/storage"
  }

  expect_failures = [
    var.bucket_name,
  ]
}
