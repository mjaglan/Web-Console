# DEV

Actual means of providing consistent docker host (Ex: UBUNTU-16.04 OS) on local-machine which runs the delivered docker image (without editing the OPS and SRC)

```
./init.sh [OPTIONS]

OPTIONS
    rmi    destroy the vagrant vm and all the vagrant boxes
```

Three ways:

- (This example) Install VirtualBox + Vagrant. Run vagrant with VMM (like VirtualBox) provider which will install docker inside vagrant Box.
    - [/src](/src) and [/ops](/ops) are shared inside the vagrant-box (see `synced_folder` in [/dev/Vagrantfile](/dev/Vagrantfile)). That means, you can code on your local machine and still run the [/ops](/ops) (i.e., the docker containers) inside a vagrant-box. And [/src](/src) is already a shared-volume for docker container. That means, you can code on your local machine and still run the [/src](/src) inside a docker container. Following are the directory locations for synced_folder -

      | local-machine <br> (git repository) | vagrant-vm | docker-container |
      |-------------------------------------|------------|------------------|
      | [/src](/src) |  `/tmp/src` | `/tmp/app` |
      | [/ops](/ops) | `/tmp/ops` | NA |
      | [/dev/vagrant-shared](/dev/vagrant-shared) | `/tmp/vagrant-shared` | NA |

    - When you're inside vagrant run the OPS from `/tmp/ops` location:

    - For this experiement, following vagrant plugins were installed:
      ```
      vagrant-registration (1.3.1)
      vagrant-service-manager (1.5.0)
      vagrant-share (1.1.7, system)
      vagrant-vbguest (0.13.0)
      vagrant-reload (0.0.1)
      ```
    - To install a vagrant plugin run following on the same machine where vagrant is installed:
      ```
      vagrant plugin install <plugin-name>
      ```

- Install docker + Vagrant. Run Vagrant with Docker provider (example [tknerr/vagrant-docker-baseimages/.../ubuntu-16.04](https://github.com/tknerr/vagrant-docker-baseimages/blob/master/ubuntu-1604/Dockerfile))

- Install docker + Vagrant. Run Vagrant with Docker provision


## Access Vagrant Guest Box From outside

Checkout following lines of code from the Vagrantfile:
```ruby
  config.vm.network "private_network", ip: "192.168.10.51"
  config.vm.network "public_network", ip: "192.168.100.11", bridge: [
      "en0: Wi-Fi (AirPort)",
  ]
```
This specifically sets the private_network IP and the public_network IP.
