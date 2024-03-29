require_relative "./osfunctions"
require "yaml"

class MPMConfig
  attr_accessor :defaults, :options

  def initialize(args = {})
    # Define the defaults
    @defaults = {:config => 'conf/config.yaml', :storage => '~/.mpm/'}
    @options = {}
    
    # Clear empty or nil args
    args = args.keep_if do |key, value|
      value
    end
    
    # Add the args to the options
    @options = args
    
    # Load config then add the missing defaults
    config = get_config args[:storage], args[:config]
    @options = @options.merge config
    @options = @options.merge @defaults
    
    # Set the dir for minecraft
    @options[:minecraftdir] = get_minecraft_dir args[:minecraftdir]
    
    # Expand Paths
    @options[:storage] = File.expand_path @options[:storage]
    @options[:minecraftdir] = File.expand_path @options[:minecraftdir] 
    
    save @options[:storage] + '/' + @options[:config]
  end
  
  # Load the config from the given location, otherwise use the default location
  def get_config(storage, path)
    file = (storage and path) ? storage + path : @defaults[:storage] + @defaults[:config]
    file = File.expand_path file
    return load file
  end
  
  def get_minecraft_dir(path = nil)
    if path.nil?
      if OsFunctions::is_mac?
        return File.expand_path '~/Library/Application Support/minecraft'
      elsif OsFunctions::is_linux?
        return File.expand_path '~/.minecraft'
      elsif OsFunctions::is_windows?
        return File.expand_path '~/AppData/Roaming/.minecraft'
      end
    else
      return path
    end
  end
  
  def save(path)
    path = File.expand_path path
    if not File.exists? path
      begin
        FileUtils.mkdir_p File.dirname path
      rescue Exception => e
        puts e.message
      end
    end
    begin
      File.open(path, "w") do |f|
        f.write(@options.to_yaml)
      end
    rescue Exception => e
      puts e.message
    end
  end
  
  def load(path)
    path = File.expand_path path
    if File.exists? path
      begin
        conf = YAML::load File.open path
        return conf
      rescue Exception => e
        puts e.message
      end
    else
      return {}
    end
  end
end
