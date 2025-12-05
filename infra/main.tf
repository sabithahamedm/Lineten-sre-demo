terraform {
 required_providers {
  google = {
   source = "hashicorp/google"
   version = ">=4.0"
   }
  }
}


provider "google" {
  credentials = "C:/Users/misir/invoker.json"
  project = var.project_id
  region  = var.region
}

resource "google_cloud_run_service" "service" {
  name      = "sre-demo-service"
  location  = var.region

  template {
    spec {
     containers {
	image = var.container_image
        ports{
          container_port =8080
        }
      }
    }
  }  



traffic {
  percent         = 100
  latest_revision = true
}

  autogenerate_revision_name = true
}

resource "google_cloud_run_service_iam_policy" "public" {
  location = var.region
  service  = google_cloud_run_service.service.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = ["allUsers"]
  }
}

output "service_url"{
value = google_cloud_run_service.service.status[0].url
}
