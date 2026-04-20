# =========================
# Instance Template
# =========================
resource "google_compute_instance_template" "template" {
  name         = "instance-template"
  machine_type = "e2-medium"

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = google_compute_network.vpc.name

    access_config {
      # Permet accès internet
    }
  }

  metadata_startup_script = file("scripts/startup.sh")

  tags = ["http-server", "ssh"]
}

# =========================
# Health Check (obligatoire pour load balancer)
# =========================
resource "google_compute_health_check" "hc" {
  name = "http-health-check"

  http_health_check {
    port = 80
  }
}

# =========================
# Instance Group Manager
# =========================
resource "google_compute_instance_group_manager" "igm" {
  name = "instance-group"
  zone = var.zone

  base_instance_name = "app"

  version {
    instance_template = google_compute_instance_template.template.id
  }

  target_size = 2

  named_port {
    name = "http"
    port = 80
  }
}

# =========================
# Autoscaler
# =========================
resource "google_compute_autoscaler" "autoscaler" {
  name   = "autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.igm.id

  autoscaling_policy {
    min_replicas = 2
    max_replicas = 5

    cpu_utilization {
      target = 0.6
    }
  }
}