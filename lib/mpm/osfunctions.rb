module OsFunctions
  
  def self.is_mac?
    JS = Java::java.lang.System
    JS.get_property 'os.name'.downcase.include? "darwin"
  end
  
  def self.is_windows?
    JS = Java::java.lang.System
    JS.get_property 'os.name'.downcase.include? "windows"
  end
  
  def self.is_linux?
    JS = Java::java.lang.System
    JS.get_property 'os.name'.downcase.include? "linux"
  end
  
end
