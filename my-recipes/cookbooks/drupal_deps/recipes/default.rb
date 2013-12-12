#
# Cookbook Name:: drupal_deps
# Recipe:: default
#
package "php5-gd"
package "php5-mysql"
package "libapache2-mod-php5"
package "unzip"

apache_module "rewrite"
apache_module "php5"
