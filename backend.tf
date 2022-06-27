terraform {
  cloud {
    organization = "Duran-Israel"

    workspaces {
      name = "terraform-docker-nodered"
    }
  }
}