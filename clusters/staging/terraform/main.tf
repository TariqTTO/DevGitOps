terraform {
  required_version = ">= 1.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Create staging namespace
resource "kubernetes_namespace" "datauniverse_staging" {
  metadata {
    name = "datauniverse-staging"
    labels = {
      environment = "staging"
      managed-by  = "terraform"
      app         = "datauniverse"
    }
  }
}

# Create Deployment
resource "kubernetes_deployment" "datauniverse_app" {
  metadata {
    name      = "datauniverse-app"
    namespace = kubernetes_namespace.datauniverse_staging.metadata[0].name
    labels = {
      app = "datauniverse-app"
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "datauniverse-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "datauniverse-app"
        }
      }

      spec {
        container {
          name  = "datauniverse-app"
          image = var.app_image
          
          port {
            container_port = 80
          }
          
          resources {
            requests = {
              memory = "64Mi"
              cpu    = "50m"
            }
            limits = {
              memory = "128Mi"
              cpu    = "100m"
            }
          }
        }
      }
    }
  }
}

# Create Service
resource "kubernetes_service" "datauniverse_service" {
  metadata {
    name      = "datauniverse-service"
    namespace = kubernetes_namespace.datauniverse_staging.metadata[0].name
  }

  spec {
    selector = {
      app = "datauniverse-app"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}