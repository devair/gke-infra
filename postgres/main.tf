provider "google-beta" {
  region = "us-central1"
  zone   = "us-central1-a"
}


resource "google_sql_database_instance" "my_instance" {
  name             = "postgresql-instance"
  region           = "us-central1"
  database_version = "POSTGRES_14"
  root_password    = "abcABC123!"
  project          = "k8s-fiap"

  settings {
    tier      = "db-f1-micro"
    edition   = "ENTERPRISE"
    disk_size = 10
    availability_type = "REGIONAL"  

    password_validation_policy {
      min_length                  = 6
      reuse_interval              = 2
      complexity                  = "COMPLEXITY_DEFAULT"
      disallow_username_substring = true
      password_change_interval    = "30s"
      enable_password_policy      = true
    }

  }
  # set `deletion_protection` to true, will ensure that one cannot accidentally delete this instance by
  # use of Terraform whereas `deletion_protection_enabled` flag protects this instance at the GCP level.
  deletion_protection = false

}

# Set up Database and Users
resource "google_sql_database" "my_database" {
  name     = "pedidos_db"
  project  = "k8s-fiap"
  instance = google_sql_database_instance.my_instance.name
}

resource "google_sql_user" "my_user" {
  name     = "docker"
  project  = "k8s-fiap"
  instance = google_sql_database_instance.my_instance.name
  password = "Docker123@"
}