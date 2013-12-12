#
# Cookbook Name:: cleanmarkup
# Recipe:: default
#
# Copyright 2013, M Parker
#
# All rights reserved - Do Not Redistribute
#

default['cleanmarkup'] = {
    :drupal_download => "http://ftp.drupal.org/files/projects/drupal-7.24.tar.gz",

    :root_database_connection => {
        :host => "localhost",
        :username => 'root'
    },

    :drop_local_db_username => "cleanmarkup",
    :drop_local_db_password => "cleanmarkup",
    :drop_local_db_database => "cleanmarkup"
}
