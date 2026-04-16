output "namespace" {
  value = kubernetes_namespace.datauniverse_staging.metadata[0].name
}

output "app_name" {
  value = kubernetes_deployment.datauniverse_app.metadata[0].name
}

output "service_name" {
  value = kubernetes_service.datauniverse_service.metadata[0].name
}