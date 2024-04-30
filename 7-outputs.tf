output "instance_name" {
  value = google_sql_database_instance.postgres_instance.name
}

output "database_ip" {
  value       = google_sql_database_instance.postgres_instance.ip_address.0.ip_address
  description = "The IPv4 address assigned for master"
}