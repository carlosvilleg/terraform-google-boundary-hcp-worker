
resource "google_compute_instance" "worker1" {
  name         = "worker1"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  project = google_project.admin.project_id

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.boundary_service_account.email
    scopes = ["cloud-platform"]
  }

  depends_on = [ google_project_service.admin ]
}
