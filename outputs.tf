#we can use the "*" to get all container names since we only have the one arguement.
#you cannot use the count function on an ouptut. so you have to reference them by their index. so we use the "*" to tell it all resources.
# all for loops must be in brackets because they provide a list.
#here we will combine the join function with a for loop to get a list of our desired attributes.


output "IP_Address" {
  value = [for i in docker_container.nodered_container[*] : join(":", [i.ip_address], i.ports[*]["external"])] 
  # all for loops must be in brackets because they provide a list.
}
#the "join" fuction will join the ip address and external port via ":". For example it will look like this: 123.123.123.123 : 1880


output "container_name" {
  value = docker_container.nodered_container[*].name
}
