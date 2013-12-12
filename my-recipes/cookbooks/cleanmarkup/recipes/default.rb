#
# Cookbook Name:: cleanmarkup
# Recipe:: default
#
# Copyright 2013, M Parker
#
# All rights reserved - Do Not Redistribute
#

# We're going to run this site on a MySQL database.
db_provider      = Chef::Provider::Database::Mysql
db_user_provider = Chef::Provider::Database::MysqlUser

# Set up the database, user and grant privileges.
database node['cleanmarkup']['drop_local_db_database'] do
    connection node['cleanmarkup']['root_database_connection']
    provider db_provider
    action :create
end
database_user node['cleanmarkup']['drop_local_db_username'] do
    connection node['cleanmarkup']['root_database_connection']
    password node['cleanmarkup']['drop_local_db_password']
    database_name node['cleanmarkup']['drop_local_db_database']
    privileges [:all]
    provider db_user_provider
    action :grant
end

# TODO: Run all SQL files in node['cleanmarkup']['drop_path'] on the database
# we just set up.

#new_connection = {
#    :username => node['cleanmarkup']['drop_local_db_username'],
#    :password => node['cleanmarkup']['drop_local_db_password']
#}
#database node['cleanmarkup']['drop_local_db_database'] do
#    connection new_connection
#    sql { ::File.open("#{node['cleanmarkup']['drop_path']}/*.sql").read }
#    action :query
#end

# Download Drupal and install it's files.
remote_file "#{node['cleanmarkup']['drop_path']}/tmp/drupal.tar.gz" do
    source node['cleanmarkup']['drupal_download']
end
execute "tar -x --overwrite -f #{node['cleanmarkup']['drop_path']}/tmp/drupal.tar.gz" do
    cwd node['cleanmarkup']['drop_path']
end
execute "mv ./drupal-7.24 ./code"
    cwd node['cleanmarkup']['drop_path']
end

# Clone the cleanmarkup code.
execute "drush -y dl ctools panels clean_markup"
    cwd "#{node['cleanmarkup']['drop_path']}/code"
end

# Configure Apache to serve the site.
web_app node['hostname'] do
    cookbook "apache2"
    server_name "#{node['hostname']}.dev"
    server_aliases ["www.#{node['hostname']}.dev"]
    allow_override ["All"]
    docroot "#{node['cleanmarkup']['drop_path']}/code"
end

# Set up Drupal's settings.local.php.
template "#{node['cleanmarkup']['drop_path']}/code/sites/default/settings.local.php" do
    source "settings.local.php.erb"
    action :create_if_missing
end
