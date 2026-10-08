
module "boundary-enterprise-worker-hvd" {
  source  = "./terraform-google-boundary-enterprise-worker-hvd/"
  #source  = "hashicorp/boundary-enterprise-worker-hvd/google"
  #version = "0.2.0"

  friendly_name_prefix = var.prefix
  project_id = var.project_id
  region = var.region
  subnet_name = var.subnet_name
  vpc = var.vpc
  vpc_project_id = var.vpc_project_id

  additional_package_names = ["jq", "unzip"]

  boundary_version = "1.0.0+ent"

  enable_iap = var.enable_iap
  image_name = var.image_name
  image_project = var.image_project_id
  machine_type = "n2-standard-4"

  instance_count = 1

  common_labels = { app = "boundary", role = "worker"}

  custom_user_data_template = basename("${path.cwd}/templates/install-and-register.userdata")
  custom_install_template_params = {
      region = var.region,
  boundary_upstream_ips = null,
      disable_vault_integration = var.disable_vault_integration,
      vault_url = var.vault_url,
      vault_gcp_auth_path = var.vault_gcp_auth_path,
      vault_auth_role_name = var.vault_auth_role_name,
      vault_secret_path = var.vault_secret_path,
      vault_namespace = var.vault_namespace,
      boundary_url = local.boundary_url,
      boundary_auth_method_id = var.boundary_auth_method_id,
      boundary_username = var.boundary_username,
      boundary_password = var.boundary_password,
      boundary_dir_home = var.boundary_dir_home,
      }


  enable_session_recording = true
  hcp_boundary_cluster_id = var.hcp_boundary_cluster_id

  #worker_is_internal = true
  worker_is_internal = false
  worker_tags = {cloud = "gcp", region = var.region, type = "egress", environment = "sandbox"}

  }

