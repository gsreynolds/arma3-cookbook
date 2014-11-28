#
# Cookbook Name:: steamcmd_arma3
# Recipe:: default
#
# Copyright 2014 The Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# chef_gem 'chef-rewind'
# require 'chef/rewind'

include_recipe 'steamcmd::default'

# node['arma3']['app_name'] = 'arma3'

# rewind :template => "/etc/init/#{node['arma3']['app_name']}.conf" do
#   source 'upstart.erb'
#   cookbook_name 'steamcmd_arma3'
# end

# steamcmd_app node['arma3']['app_name'] do
#   app_id 233780
#   app_name node['arma3']['app_name']
#   app_game 'arma3'
#   hostname node['arma3']['hostname']
#   cfg_file 'server.cfg'
# end

package 'lib32stdc++6'

template "#{node['steamcmd']['home']}/a3update.sh" do
  source "a3update.sh.erb"
  owner node['steamcmd']['user']
  group node['steamcmd']['group']
  mode 0755
  variables(
    :steamcmd => "#{node['steamcmd']['steamcmd_dir']}/steamcmd.sh",
    :a3update => "#{node['steamcmd']['home']}/a3update.txt"
  )
end

template File.join(node['steamcmd']['home'], 'a3update.txt') do
  source "a3update.txt.erb"
  owner node['steamcmd']['user']
  group node['steamcmd']['group']
  mode 0644
  variables(
    :username => node['steamcmd']['steam']['username'],
    :password => node['steamcmd']['steam']['password'],
    :install_dir => "#{node['steamcmd']['home']}/#{node['arma3']['app_name']}"
  )
end
