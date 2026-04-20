resource "google_sql_database_instance" "db" {
  name             = "BASEDEDONNEES"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "database" {
  name     = "app-db"
  instance = google_sql_database_instance.db.name
}

resource "google_sql_user" "user" {
  name     = "Khurtz"
  instance = google_sql_database_instance.db.name
  password = "Espoire27+"
}