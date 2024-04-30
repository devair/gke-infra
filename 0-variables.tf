variable "project_id" {
  description = "project id"
  default     = "k8s-fiap"
}

variable "region" {
  description = "region"
  default     = "us-central1"
}

variable "zone" {
  description = "zone"
  default     = "us-central1-a"
}

variable "nodeZone" {
  description = "zone"
  default     = "us-central1-b"
}

variable "sql_user" {
  description = "Username of the host to access the database"
  default = "docker"
}

variable "sql_pass" {
  description = "Password of the host to access the database"
  default = "docker123"
}
