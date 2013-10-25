# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# @file
# Specify settings for a Drupal testing webserver.
#
# Vagrant 1.3.5
# Plugins:
# - vagrant-omnibus
# - vagrant-librarian-chef

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true

  # To use NFS folders, we have to use a private (host-only) network with a 
  # static IP
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.synced_folder "./data", "/srv/cleanmarkup", nfs: true

  # Enable SSH agent forwarding so we don't have to copy our private key to the
  # VM.
  config.ssh.forward_agent = true

  # Ensure we're using the latest version of Chef.
  config.omnibus.chef_version = :latest
  
  # Tell Chef where to find cookbooks downloaded with Librarian.
  config.librarian_chef.cheffile_dir = "contrib-recipes"

  # TODO: Provision.
  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = ["contrib-recipes/cookbooks", "my-recipes/cookbooks"]
  #   chef.roles_path = "./my-recipes/roles"
  #   chef.data_bags_path = "./my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end
end
