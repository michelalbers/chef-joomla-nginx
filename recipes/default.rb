# Nginx Config
template "#{node['nginx']['dir']}/sites-available/joomla" do
  source 'joomla.erb'
  owner 'root'
  group node['root_group']
  mode '0644'
  action :create
  notifies :reload, 'service[nginx]'
end

# Enable Joomla
nginx_site 'joomla' do
  enable true
end

# Disable default page
nginx_site 'default' do
  enable false
end

# Enable PHP Error Logging
php_fpm_pool "www" do
  php_options 'php_flag[display_errors]' => 'on', 'php_admin_flag[display_errors]' => 'on', 'php_admin_value[memory_limit]' => '1024M', 'php_admin_value[upload_max_filesize]' => '1024M', 'php_admin_value[post_max_size]' => '1024M', 'php_admin_value[max_execution_time]' => 300, 'php_admin_value[max_input_time]' => 300
end

# Install php-mysql
apt_package "php5-mysql" do
  action :install
end

# Install php5-gd
apt_package "php5-gd" do
  action :install
end

# Install php5-curl
apt_package "php5-curl" do
  action :install
end

# Install graphicsmagick
apt_package "graphicsmagick" do
  action :install
end

# Install sendmail
apt_package "sendmail" do
  action :install
end
