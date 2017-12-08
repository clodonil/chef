#
# Cookbook:: aula5
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

node.default['message'] ="Curso de Chef"

file "/welcome" do
  content "#{node['message']}"
end
