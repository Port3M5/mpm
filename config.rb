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
    
    p "Args after emptying: #{args}"
    
    # Set the dir for minecraft
    set_minecraft_dir args[:minecraftdir]
    
    # Load the config if it exists
    file = args[:config] ? args[:config] : @defaults[:config]
    conf = load file
    
    if conf then @options = conf end
    @options = @defaults.merge args
    
    save @options[:config]
  end
  
  def set_minecraft_dir(path = nil)
    if path.nil? or path.empty?
      if OsFunctions::is_mac?
        @options[:minecraftdir] = Pathname.new('~/Library/Application Support/minecraft').expand_path
      end
    else
      @options[:minecraftdir] = path
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