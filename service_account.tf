
resource "google_service_account" "boundary_service_account" {
  account_id   = "boundary-sa"
  display_name = "Boundary Service Account"
}

resource "google_project_iam_member" "boundary_folder_viewer" {
  folder = google_folder.top.folder_id
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${google_service_account.boundary_service_account.email}"
}

/*
resource "google_project_iam_member" "boundary_project_viewer" {
  project = var.gcp_project_id
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${google_service_account.boundary_service_account.email}"
}
*/


