
provider "google" {
  region  = "global"
}

#data "google_project" "project" {
#}

data "google_organization" "org" {
  domain = var.google_org_domain
}

resource "google_folder" "top" {
  display_name = "Top"
  parent       = data.google_organization.org.name
}

resource "google_project" "admin" {
  name       = "Boundary Worker"
  project_id = "boundary-worker"
  org_id  = google_organization.org.org_id
}

/*
resource "google_project" "boundary-worker" {
  name       = "Boundary Worker"
  project_id = "boundary-worker"
  folder_id  = google_folder.top.name
}
*/

resource "google_project" "workloads1" {
  name       = "Workloads 1"
  project_id = "workloads1"
  folder_id  = google_folder.top.name
}

resource "google_project" "workloads2" {
  name       = "Workloads 2"
  project_id = "workloads2"
  folder_id  = google_folder.top.name
}

