require "./osfunctions"
require 'pathname'
require "yaml"

class MPMConfig
  attr_accessor :defaults, :options

  def initialize(args = {})
    # Define the defaults
    @defaults = {:config => './conf/config.yaml', :storage => '~/.mpm/'}
    @options = {}
    
    # Clear empty or nil args
    args = args.keep_if do |key, value|
      value
    end
    
    # Set the dir for minecraft
    @options[:minecraftdir] = get_minecraft_dir args[:minecraftdir]
    
    # Load the config if it exists
    file = args[:config] ? args[:config] : @defaults[:config]
    conf = load file
    
    # If the config exists then set the options to the loaded values
    if conf then @options = @options.merge conf end
    @defaults = @defaults.merge args
    @options = @options.merge @defaults
    
    save @options[:config]
  end
  
  def get_minecraft_dir(path = nil)
    if path.nil?
      if OsFunctions::is_mac?
        return Pathname.new('~/Library/Application Support/minecraft').expand_path.to_s
      end
    else
      return path
    end
  end
  
  def save(path)
    begin
      File.open(path, "w") do |f|
        f.write(@options.to_yaml)
      end
    rescue
      puts "Unable to write to #{path}"
    end
  end
  
  def load(path)
    begin
      conf = YAML::load File.open path
      return conf
    rescue
      puts "#{path} does not exist"
    end
  end
end