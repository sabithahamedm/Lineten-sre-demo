terraform {
 required_providers {
  google = {
   source = "hashicopr/google"
   version = ">=4.0"
   }
  }
}


provider "google" {
  project = var.project_id
  region  = var.region
}


resource "google_artifact_registry_repository" "repo" {
  repository_id = "sre-demo-repo"
  format        = "DOCKER"
  location      = var.region
}


#Cloud run Service 

resource "google_cloud_run_service "service" {
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

resource "google_cloud_run_iam_member" "invoker"{
location  = google_cloud_run_service.location
service   = google_cloud_run_service.service.name
roel      = "roles/run.invoker"
member    = "allUsers"  #public users

}

output "service_url"{
value- google_cloud_run_service.service.status[0].url
}
