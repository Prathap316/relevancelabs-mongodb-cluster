# relevancelabs-mongodb-cluster
**ABOUT REPO**
>The repo contains cookbok for forming mongodb cluster with config server with replica set(1 primary,1 secondery),two shard servers each has replicaset(1 primary,1 secondery) and quary router.
>It contains databag folder with databag item name dev used for Dev environment.

**ABOUT COOKBOOK**
>It has recipies,templates and necessary files.


**ABOUT DATABAG**
>It has Databag named mongodb and item named dev used for Dev environment.

**HOW TO USE THIS COOKBOOK**
>Necessary components to use this cookbook.
    >7 centos8 servsrs.Install chefdk on each server.
    >update content in the databag like dbpath,replicanames,ports,config_server replica set ip addresses,shard1_server ip addresses,shard2_server ip addresses.
>Copy the cookbooks and data_bags in home dir of user who is having sudo permissions.
**Executing recipe on nodes or servers**

1.Execute recipe on config servers locally.
>By using command you can run single recipe locally.
  sudo chef-client -z --override-runlist "recipe[mongodb::mongodb_config_server]" --chef-licence=accept 
  -z for running recipe locally
  --override-runlist for execute particular recipe in this case mongodb_config_server.
  --chef-licence=accept for accept licences without prompting while executing.
>repeat above process for other config replica set server.

2.Execute recipe on shard1 servers locally.
>By using command you can run single recipe locally.
  sudo chef-client -z --override-runlist "recipe[mongodb::mongodb_shard1_server]" --chef-licence=accept 
  -z for running recipe locally
  --override-runlist for execute particular recipe in this case mongodb_shard1_server.
  --chef-licence=accept for accept licences without prompting while executing.
>repeat above process for other shard1 replica set server.

3.Execute recipe on shard2 servers locally.
>By using command you can run single recipe locally.
  sudo chef-client -z --override-runlist "recipe[mongodb::mongodb_shard2_server]" --chef-licence=accept 
  -z for running recipe locally
  --override-runlist for execute particular recipe in this case mongodb_shard2_server.
  --chef-licence=accept for accept licences without prompting while executing.
>repeat above process for other shard2 replica set server.

4.Execute recipe on quary router server locally.
.>By using command you can run single recipe locally.
  sudo chef-client -z --override-runlist "recipe[mongodb::mongodb_query_router_server]" --chef-licence=accept 
  -z for running recipe locally
  --override-runlist for execute particular recipe in this case mongodb_query_router_server.
  --chef-licence=accept for accept licences without prompting while executing.
 
