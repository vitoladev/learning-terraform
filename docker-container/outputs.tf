output "container_id" {
  description = "ID of Docker container"
  value = docker_container.nginx.id
}

output "image_Id" {
  description = "ID of the docker image"
  value = docker_image.nginx.id
}