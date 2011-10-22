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

# Load the configs up
config = MPMConfig.new global_opts
pm = MPMPackageManager.new config.options[:storage]

cmd = ARGV.shift
cmd_opts = case cmd
  when "list"
    list
  when "use"
    use ARGV.inspect
  when "new"
    create_new ARGV.inspect
  else
    Trollop::die "Unknown subcommand"
  end


# Gets all the packages
def list
  pm.list()
end

def use name
  pm.use name
end

def create_new name
  pm.create_new name
end