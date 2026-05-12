
provider "google" {
  region  = "global"
}

data "google_organization" "org" {
  organization = var.google_org
}

data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}

resource "google_folder" "top" {
  display_name = "Top"
  parent       = data.google_organization.org.name
}

resource "google_project" "admin" {
  name       = "Boundary Worker"
  project_id = "boundary-worker"
  org_id  = data.google_organization.org.org_id
  billing_account = data.google_billing_account.acct.id
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
  #project_id = "workloads1"
  project_id = "river-treat-495713-e3"
  folder_id  = google_folder.top.name
  billing_account = data.google_billing_account.acct.id
}

resource "google_project" "workloads2" {
  name       = "Workloads 2"
  #project_id = "workloads2"
  project_id = "regal-cursor-495713-t8"
  folder_id  = google_folder.top.name
  billing_account = data.google_billing_account.acct.id
}

resource "google_project_service" "project" {
  project = google_project.admin.project_id
  service = "compute.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_project_service" "admin" {
  project = google_project.admin.project_id
  service = "compute.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_project_service" "workloads1" {
  project = google_project.workloads1.project_id
  service = "compute.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_project_service" "workloads2" {
  project = google_project.workloads2.project_id
  service = "compute.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  timeouts {
    create = "30m"
    update = "40m"
  }
}

