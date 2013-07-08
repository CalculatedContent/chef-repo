#
# Cookbook Name:: sinatra_app
# Recipe:: default
#
# Copyright 2013, Calculated Content
#
# All rights reserved - Do Not Redistribute

include_recipe "sinatra_app::webserver"
include_recipe "sinatra_app::deploy"

