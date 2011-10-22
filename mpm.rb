#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'

require 'trollop'
require './config'
require './packagemanager'

attr_accessor :config, :storage

# Configure Trollop for ARGs
SUB_COMMANDS = %w(use list new)
global_opts = Trollop::options do
  banner "Minecraft Profile Manager. Minecraft management made easy :)"
  opt :config, "Use config file from this location", :type => String
  opt :storage, "Select the location to store the mpm folder", :type => String
  stop_on SUB_COMMANDS
end

cmd = ARGV.shift
cmd_opts = case cmd
  when "use"
    
    puts "Remaining #{ARGV.inspect}"
  else
    Trollop::die "Unknown subcommand"
  end
config = MPMConfig.new {:config => @config, :storage => @storage}

pm = MPMPackageManager.new config.options[:storage]