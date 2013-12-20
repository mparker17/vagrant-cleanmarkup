# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# @file
# Specify settings for a Drupal webserver.
#
# Vagrant v1.3.5
# Plugins:
# - vagrant-omnibus
# - vagrant-librarian-chef
#
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = "cleanmarkup.dev"

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true

  # To use NFS folders, we have to use a private (host-only) network with a
  # static IP.
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.synced_folder "./data", "/srv/cleanmarkup", nfs: true

  # Enable SSH agent forwarding so we don't have to copy our private key to
  # the VM.
  config.ssh.forward_agent = true

  # Ensure we're using a recent version of Chef.
  # At time of testing, 11.8.0 is the latest, let's stick to what we know
  # works.
  config.omnibus.chef_version = "11.8.0"

  # Tell Chef where to find cookbooks downloaded with Librarian.
  config.librarian_chef.cheffile_dir = "contrib-recipes"

  # Provision.
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["contrib-recipes/cookbooks", "my-recipes/cookbooks"]
    chef.roles_path = "./my-recipes/roles"
    chef.data_bags_path = "./my-recipes/data_bags"

    # On ubuntu hosts, run recipe "apt::default" first so that apt-get
    # update is run ASAP.
    chef.add_recipe "apt::default"

    # Applications we will need.
    chef.add_recipe "git"
    chef.add_recipe "apache2::mod_php5"
    chef.add_recipe "database::mysql"
    chef.add_recipe "mysql::server"
    chef.add_recipe "mysql::client"
    chef.add_recipe "php"
    chef.add_recipe "drupal_deps"
    chef.add_recipe "drush"
    chef.add_recipe "cleanmarkup"

    # Settings.
    chef.json = {
      "apache" => {
        "listen_ports" => ["80"],
        "log_dir" => "/srv/cleanmarkup/logs"
      },
      "php" => {
        "directives" => {
          "display_errors" => "On",
        }
      },
      "mysql" => {
        "server_root_password" => "root",
        "server_repl_password" => "root",
        "server_debian_password" => "root",
        "tunable" => {
          "wait_timeout" => "28800",
          "innodb_lock_wait_timeout" => "28800"
        }
      },
      "cleanmarkup" => {
        "drupal_download" => "http://ftp.drupal.org/files/projects/drupal-7.24.tar.gz",
        "drop_local_db_database" => "cleanmarkup",
        "drop_local_db_username" => "cleanmarkup",
        "drop_local_db_password" => "cleanmarkup",
        "drop_path" => "/srv/cleanmarkup",
        "root_database_connection" => {
            :password => "root"
        }
      }
    }
  end
end
