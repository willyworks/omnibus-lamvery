#
# Cookbook Name:: omnibus-lamvery
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

omnibus_build 'lamvery' do
  project_dir '/lamvery'
  build_user node['omnibus']['build_user']
  log_level :internal
end
