require 'pathname'

class MPMPackageManager
  attr_accessor :path, :packages
  
  def initialize(path)
    @path = path
    
    # Create the dir if it doesnt exist
    begin
      p = Pathname.new @path
      p = p.expand_path
      if !p.exist?
        p.mkdir
      else
        puts "#{@path} already exists"
      end
    rescue
      puts "#{@path} could not be created"
    end
      
    @packages = {}
    
    find_packages(@path)
  end
  
  def list(path)
    begin
      p = Pathname.new path
      p = p.expand_path
      
      @packages = p.children.select { |c| c.directory? }
      puts @packages
      
    rescue
      puts "Unable to read #{path}"
    end
  end
  
end