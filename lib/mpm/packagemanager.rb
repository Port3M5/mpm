require 'pathname'
require 'fileutils'

class MPMPackageManager
  attr_accessor :options, :path, :restricted_folders
  
  def initialize(options = {})
    @options = options
    @path = @options[:storage]
    @restricted_folders = ['conf', 'bin', '.git']
    @packages = []
    
    # Create the dir if it doesnt exist
    begin
      @path = File.expand_path @path
      if !File.exists? @path
        Fileutils.mkdir @path
      end
    rescue
      puts "#{@path} could not be created"
    end
  end
  
  def get_current_package
    f = File.basename File.realdirpath File.expand_path @options[:minecraftdir]
    return f
  end
  
  def list
    begin
      f = File.expand_path @path
      p = Pathname.new f
      
      p.children.select do |c|
        if c.directory? then
          if not in_restricted_folders? c.basename.to_s
            @packages << c.basename.to_s
          end
        end
      end
      return @packages
    rescue
      puts "Unable to read #{path}"
    end
  end
  
  def use(name)
    package = nil
    list.each do |val|
      if val == name
        package = val
      end
    end
    
    if package
      puts "Using profile #{package}"
      set_symlink package
    else
      puts "no package called #{name.first} found"
      exit
    end
  end
  
  def set_symlink(packagename)
    from = File.expand_path @options[:minecraftdir]
    to = File.expand_path @path + "/" + packagename
    
    begin
      if File.symlink? from
        begin
          File.unlink from
          File.symlink to, from
        rescue Exception => e
          puts "Unable to remove #{from}"
          puts e.message
        end
      elsif not File.exists? from
        begin
          File.symlink to, from
        rescue Exception => e
          puts e.message
        end
      end
    rescue Exception => e
      puts "Unable to create symlink from #{from} to #{to}"
      puts e.message
    end
  end
  
  def setup
    minecraft = File.expand_path @options[:minecraftdir]
    if File.exist? minecraft and not File.symlink? minecraft
      # Move the contents of the dir to the Default Profile
      create_new "default"
      begin
        FileUtils.cp_r minecraft + "/.", File.expand_path(@options[:storage] + "/" + "default")
      rescue Exception => e
        puts "Cannot copy Minecraft folder"
        puts e.message
      end
      begin
        FileUtils.remove_dir minecraft, true
      rescue Exception => e
        puts "Cannot delete minecraft folder"
        puts e.message
      end
      use 'default'
    elsif not File.exists? minecraft
      # Just create the symlink
      create_new "default", true
    else
      puts "MPM has already been configured"
    end
  end
  
  def create_new (name, use = false)
    p = File.expand_path(@path + "/" + name)
    if not File.directory? p and not in_restricted_folders? name
      begin
        FileUtils.mkdir p
      rescue
        puts "Cannot make #{name}"
      end
      
      get_launcher p + "/minecraft.jar"
      
      if use
        self.use name
      end
    else
      puts "A profile called #{name} already exists"
    end
  end
  
  def get_launcher target
    require 'open-uri'
    begin
      url = 'https://s3.amazonaws.com/MinecraftDownload/launcher/minecraft.jar'
      open(target, "wb") do |f|
        f.write(open(url).read)
        f.close
      end
    rescue Exception => e
      puts e.message
    end
  end
  
  def in_restricted_folders? filename
    if @restricted_folders.include? filename
      return true
    end
    return false
  end
  
  def to_s
    str = "Packages are:\n"
    list.each do |val|
      str += val + "\n"
    end
    return str
  end
end