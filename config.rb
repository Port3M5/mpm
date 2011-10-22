require "./osfunctions"
require 'pathname'
require "yaml"

class MPMConfig
  attr_accessor :defaults, :options

  def initialize(args = {})
    # Define the defaults
    @defaults = {:config => './conf/config.yaml', :storage => '~/.mpm/'}
    
    # Set the dir for minecraft
    if !args[:minecraftdir]
      if OsFunctions::is_mac?
        @options[:minecraftdir] = Pathname.new('~/Library/Application Support/minecraft').expand_path
      end
    else
      @options[:minecraftdir] = args[:minecraftdir]
    end
    
    # Load the config if it exists
    file = args[:config] ? args[:config] : @defaults[:config]
    conf = load file
    
    if conf then @options = conf end
    @options = @defaults.merge args
    
    save @options[:config]
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