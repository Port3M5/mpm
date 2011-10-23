#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'

require 'trollop'
require './config'
require './packagemanager'

# Configure Trollop for ARGs
SUB_COMMANDS = %w(use list new)
global_opts = Trollop::options do
  banner "Minecraft Profile Manager. Minecraft management made easy :)"
  opt :config, "Use config file from this location", :type => String
  opt :storage, "Select the location to store the mpm folder", :type => String
  stop_on SUB_COMMANDS
end

# Load the configs up
p global_opts
@config = MPMConfig.new global_opts
@pm = MPMPackageManager.new @config.options[:storage]

## Define the functions

# Gets all the packages
def list path
  @pm.list path
end

def use name
  @pm.use name
end

def create_new name
  @pm.create_new name
end

# Get the subcommands and respond accordingly
cmd = ARGV.shift
cmd_opts = case cmd
  when "list"
    list @config.options[:storage]
  when "use"
    use ARGV.inspect
  when "new"
    create_new ARGV.inspect
  else
    Trollop::die "Unknown subcommand"
  end