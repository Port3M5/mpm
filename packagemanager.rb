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
      p = Pathname.new @path
      p = p.expand_path
      if !p.exist?
        p.mkdir
      end
    rescue
      puts "#{@path} could not be created"
    end
  end
  
  def list
    begin
      p = Pathname.new path
      p = p.expand_path
      
      p.children.select do |c|
        if c.directory? then
          puts c.basename
          if not in_restricted_folders? c.basename.to_s
            @packages << c
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
      if val.basename.to_s == name
        package = val.basename.to_s
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
    from = Pathname.new @options[:minecraftdir]
    to = Pathname.new(@path + packagename).expand_path
    
    if from.symlink? or !from.exist?
      begin
        if from.exist?
          begin
            File.unlink from
          rescue
            puts "Unable to remove #{from}"
          end
        end
        File.symlink to, from
      rescue
        puts "Unable to create symlink from #{from} to #{to}"
      end
    else
      puts "#{from} is not a symlink"
    end
  end
  
  def setup
    minecraft = Pathname.new @options[:minecraftdir]
    if File.exist? minecraft and not File.symlink? minecraft
      # Move the contents of the dir to the Default Profile
      create_new "default"
      begin
        FileUtils.cp_r minecraft, Pathname.new(@options[:storage] + "default").expand_path
      rescue
        puts "Cannot copy Minecraft folder"
      end
      begin
        FileUtils.remove_dir minecraft, true
      rescue
        puts "Cannot delete minecraft folder"
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
    p = Pathname.new(@path + name).expand_path
    if not p.exist? and not in_restricted_folders? name
      begin
        p.mkdir
      rescue
        puts "Cannot make #{name}"
      end
      if use
        self.use name
      end
    else
      puts "A profile called #{name} already exists"
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
    puts @packages
    list.each do |val|
      str += val.basename.to_s + "\n"
    end
    return str
  end
end