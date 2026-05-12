
# This SA is used through ADC via instance attachment or impersonate
resource "google_service_account" "boundary_service_account" {
  account_id   = "boundary-sa"
  display_name = "Boundary Service Account"
  project = google_project.admin.project_id
}

resource "google_folder_iam_member" "boundary_folder_viewer" {
  folder = google_folder.top.folder_id
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${google_service_account.boundary_service_account.email}"
}

##############################################################################
# This SA has keys managed by Boundary
resource "google_service_account" "boundary_managed_sa" {
  account_id   = "boundary-managed-sa"
  display_name = "Boundary Service Account"
  project = google_project.admin.project_id
}

resource "google_folder_iam_member" "boundary_managed_viewer" {
  folder = google_folder.top.folder_id
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${google_service_account.boundary_managed_sa.email}"
}

resource "google_folder_iam_member" "boundary_managed_keys" {
  folder = google_folder.top.folder_id
  role    = "roles/iam.serviceAccountKeyAdmin"
  member  = "serviceAccount:${google_service_account.boundary_managed_sa.email}"
}

# This one is only needed to allow access to a project outside the folder
# this code base deploys the worker to such a project, and the code below 
# allows access to that project
resource "google_project_iam_member" "boundary_managed_viewer" {
  project = google_project.admin.project_id
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${google_service_account.boundary_managed_sa.email}"
}

# need to enable iam service to allow this:
resource "google_project_service" "iam-for-admin" {
  project = google_project.admin.project_id
  service = "iam.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  timeouts {
    create = "30m"
    update = "40m"
  }
}

##############################################################################
# This SA is used by Boundary to impersonate the other account
resource "google_service_account" "boundary_impersonation_sa" {
  account_id   = "boundary-impersonation-sa"
  display_name = "Boundary Service Account for impersonation"
  project = google_project.admin.project_id
}

resource "google_service_account_iam_member" "boundary" {
  service_account_id = google_service_account.boundary_service_account.id
  #role               = "roles/iam.serviceAccountUser"
  role    = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${google_service_account.boundary_impersonation_sa.email}"
}

resource "google_folder_iam_member" "boundary_impersonation_keys" {
  folder = google_folder.top.folder_id
  role    = "roles/iam.serviceAccountKeyAdmin"
  member  = "serviceAccount:${google_service_account.boundary_impersonation_sa.email}"
}


