resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "postgres_instance" {
  name             = "postgres-instance"
  region  = var.region
  project = var.project_id
  database_version = "POSTGRES_14"

  depends_on = [google_service_networking_connection.default]
 
  deletion_protection = false

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier      = "db-f1-micro"
    disk_size = 10

    ip_configuration {
      ipv4_enabled    = "false"
      private_network = google_compute_network.peering_network.id
    }

  }
}

resource "google_sql_user" "user" {
  depends_on = [
    "google_sql_database_instance.postgres_instance",    
  ]

  instance = "${google_sql_database_instance.postgres_instance.name}"
  name     = "${var.sql_user}"
  password = "${var.sql_pass}"
}