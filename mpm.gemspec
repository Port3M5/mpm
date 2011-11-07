# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mpm/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Anthony Porthouse"]
  gem.email         = ["Admin@port3m5.com"]
  gem.description   = %q{MPM is a profile manager for Minecraft. it supports creation and management of multiple installed versions of minecraft.}
  gem.summary       = %q{MPM is a profile manager for Minecraft. It supports creation and management of multiple installed versions of minecraft. This tool is designed with running multiple different mods in mind, thus it not only changes the Minecraft JAR but the entire Minecraft Folder.}
  gem.homepage      = "http://github.com/port3m5/mpm"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "mpm"
  gem.require_paths = ["lib"]
  gem.version       = Mpm::VERSION
  
  gem.add_dependency "trollop"
end
