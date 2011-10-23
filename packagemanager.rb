require 'pathname'

class MPMPackageManager
  attr_accessor :options, :path, :restricted_folders
  
  def initialize(options = {})
    @options = options
    @path = @options[:storage]
    @restricted_folders = ['conf', 'bin']
    
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
      
      @packages = p.children.select do |c|
        if not in_restricted_folders? c
          c.directory?
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
        begin
          File.unlink from
        rescue
          puts "Unable to remove #{from}"
        end
        File.symlink to, from
      rescue
        puts "Unable to create symlink from #{from} to #{to}"
      end
    else
      puts "#{from} is not a symlink"
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
    list.each do |val|
      str += val.basename.to_s + "\n"
    end
    return str
  end
end