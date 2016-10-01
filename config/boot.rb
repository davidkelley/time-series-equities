require 'rubygems'
require 'bundler/setup'
require 'yajl/json_gem'
require 'rom-dynamo'
require 'active_support'

Bundler.require :default, ENV['RACK_ENV']
