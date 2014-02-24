docker-ssh-ubuntu
=================

This is a Docker file to mimic the AWS Ubuntu 12.04 image as closely as possible.

Problem being adressed
======================
Things take too long to test on AWS instances because: 
1. Intance launch takes over 90 seconds
2. Data transfer is low
3. Takes longer to inspect files created 

These problems can be seen at worse when debugging a chef recipe because every run shall be done on a clear environment which takes several minutes. 

Solution
========
We use this repository within Flux7 Labs as cheap way to test chef recipes that are under development. It helps in three ways: 

1. Quick start/stop time of a container singnifncalty shortens the debug loop
2. The ease of logging into a container and the speed is far better than logging in to an EC2 instance
3. You can easily read files from within the container from the outside host 
4. You dont have to pay for launching wasteful EC2 instance repeatedly as you debug 

Known Issues
============
* apparmor is not installed which can cause some applications to fail
