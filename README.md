# karamel-chef
This chef cookbook installs Karamel. Used by Vagrant to provision multi-node clusters.



1. Run the init script to download chef-dk and karamel to the downloads directory.

1a. Create your own cluster by copying an existing Karamel cluster definition. If your name is John, call it 'hopsworks.1.john'. Then customize it. 

2. To start a Hopsworks VM, use the run.sh script. The parameters are: <operating sys>(ubuntu or centos), number of VMs in the vagrant configuration (1 or 3),  <cluster-postfix-name> (john, hopsworks, jim, virtualbox, etc), [no-random-ports]  - this will forward the ports in the Vagrantfile.

For example,
./run.sh ubuntu 1 jim no-random-ports

3. To shutdown your cluster, run the kill.sh script:

./kill.sh 

# Hopsworsk with Hopssite/Dela installation details
# Installing the vm with hopssite:
Set the installation parameters in
```
hs_env.sh
```
Run (no parameters requires)
```
run_hopssite.sh
```
When deployment is finished, ssh in the vm and run:
```
(vagrant ssh)
/srv/hops/hopssite/hs_install.sh
```
Note: if you installed hopsworks with multi-user support change the user params in:
```
/srv/hops/hopssite/hs_env.sh
(MYSQL_USER)
(GLASSFISH_USER)
```
If you want to use the hopsworks/dela on this machine, reload hopsworks-ear from glassfish admin console
# Installing a vm with dela enabled(slave):
This vm is supposed to connect to a machine installed as per previous step(hopssite)

Set the installation parameters in
```
dela_env.sh
```
Run (no parameters required)
```
run_dela.sh
```
# Baremetal installation with karamel-ui
Used a kubuntu 16.04 64bit from osboxes(http://www.osboxes.org/kubuntu/):
https://drive.google.com/file/d/0B_HAFnYs6Ur-ZGdZYTNjMkxvM28/view?usp=sharing
password: osboxes.org
Note: The VM requires a bit of time to load everything - otherwise the apt-get install complains about locks being tacken when you try to install openssh, java or git.

1. The installing user must not have a sudo password. If your user has a password, do:
```
sudo visudo
```
and change the sudo line from:
```
%sudo   ALL=(ALL) ALL
```
to 
```
%sudo   ALL=(ALL) NOPASSWD:ALL
```
2. The installation script has to be able to ssh back into the installed vm - since this is a baremetal installation, we require the machine to be able to ssh into itself
  1. generate ssh keys
  ```
  cd
  mkdir .ssh
  chmod 700 .ssh
  ssh-keygen -t rsa
  ```
  2. authorise your key to ssh into this machine
  ```
  cd .ssh
  touch authorized_keys
  cat id_rsa.pub >> authorized_keys
  chmod 600 authorized_keys
  ```
  3. install openssh-server
  ```
  sudo apt-get install openssh-server
  ```
  Note: Make sure you can ssh into the machine with the install user (osboxes) into the 10.0.2.15.
3. Modify in the /etc/hosts file this line:
```
127.0.1.1   osboxes
```
to:
```
10.0.2.15 osboxes
```
4. Install java
```
sudo apt-get install jre-default
```
5. Install git
```
sudo apt-get install git
```
6. Get karamel-chef and change the install user in the cluster definition: `1.hopsworks.yml`
```
cd
git clone https://github.com/o-alex/karamel-chef 
```
Change the install/baremetal users to your user (osboxes) in the cluster definition:
https://github.com/o-alex/karamel-chef/blame/master/cluster-defns/1.hopsworks.yml#L3
https://github.com/o-alex/karamel-chef/blame/master/cluster-defns/1.hopsworks.yml#L13
7. Get karamel (http://karamel.io) version 0.4:
http://www.karamel.io/sites/default/files/downloads/karamel-0.4.tgz
8. Run karamel:
```
cd karamel-0.4
./bin/karamel
```
9. After running karamel it will automatically load in firefox under `localhost:9090/index.html`
10. Within karamel go to `Menu` - `Load Cluster Defn` and load the `1.hopsworks.yml` cluster definition, after which `Launch` the cluster.
Note: remember to change the install/baremetal user from vagrant to osboxes in this case.
11. Launch and check the status until all recipies are installed (status - done).
11. Launch and check the status until all recipies are installed (status - done).
12. Access hops at the `localhost:8080/hopsworks`
