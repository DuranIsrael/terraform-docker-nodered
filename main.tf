
#local-exec provisioner basically runs a command that will create the volume directory for out container.
resource "null_resource" "dockervol" {
  provisioner "local-exec" {
    command = "mkdir noderedvol/ && sudo chown -R 1000:1000 noderedvol/" #this bash script will create the directory for the volume
  }
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}



resource "random_string" "random" { #What this will do is when createing multiples of a resource this will fill in the attributes such as "names" to prevent duplicates.
  count   = var.containter_count    #the cout function will work with any resoucre to create multiples. coupled with random will ensure no duplicates are created.
  length  = var.string_length       #for example if you created 3 containers you will not have to figure out names for each. the random resouce will do it for you.
  special = false
  upper   = false

}


resource "docker_container" "nodered_container" {
  count = var.containter_count                                             #this will allow is to choose how many container resources to spin up. the Random function will give them unique names
  name  = join("-", ["nodered", random_string.random[count.index].result]) #this will be sure that container names never clash. one random string per resource.
  image = docker_image.nodered_image.latest
  ports {
    internal = var.int_port
    external = var.ex_port
  }
  volumes { #nodred needs a volume for storage in order for the container to continue running. This will attach our volume
    container_path = "/data"
    host_path       = "YOUR DIRECTORY HERE"

  }
}
