resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "postgres_instance" {
  name             = "postgres-instance"
  database_version = "POSTGRES_14"

  depends_on = [google_service_networking_connection.default]

  region  = var.region
  project = var.project_id

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

