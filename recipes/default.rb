#
# Cookbook Name:: omnibus-lamvery
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

omnibus_build 'lamvery' do
  project_dir 'https://github.com/willyworks/omnibus-lamvery.git'
  log_level :internal
  config_override(
    append_timestamp: true
  )
end
