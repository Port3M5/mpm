require "mpm/version"
require 'mpm/trollop'
require 'mpm/config'
require 'mpm/packagemanager'

# Configure Trollop for ARGs
SUB_COMMANDS = %w(use launch list new setup current)
global_opts = Trollop::options do
  banner <<-EOS
  Minecraft Profile Manager. Minecraft management made easy :)
  Usage: mpm [-csm] command [--help]
  Available commands are: #{SUB_COMMANDS}
  EOS
  version "0.2"
  opt :config, "Use config file from this location", :type => String
  opt :storage, "Select the location to store the mpm folder", :type => String
  opt :minecraftdir, "Select the location of your minecraft folder", :type => String
  stop_on SUB_COMMANDS
end

# Load the configs up
@config = MPMConfig.new global_opts
@pm = MPMPackageManager.new @config.options

## Define the functions

# Gets all the packages
def list
  puts @pm
end

def use name
  @pm.use name
end

def create_new name, use
  @pm.create_new name, use
end

# Get the subcommands
cmd = ARGV.shift
cmd_opts = case cmd
when "current"
when "setup"
when "list"
when "use"
when "launch"
when "new"
  Trollop::options do
    opt :use, "Uses the newly created profile", :default => false
  end
else
  Trollop::die "Unknown command #{cmd.inspect}. Run with --help to see available commands."
end

# Run the commands
case cmd
when "setup"
  @pm.setup
when "launch"
  `java -jar "#{@config.options[:minecraftdir]}/minecraft.jar" &`
when "list"
  list
when "use"
  use ARGV.first
when "new"
  create_new ARGV.first, cmd_opts[:use]
when "current"
  puts "Current Profile is: #{@pm.get_current_package}"
end