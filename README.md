MPM: A Minecraft Profile Manager
================================

ToC
---
1. Requirements
1. Installing MPM
1. Using MPM
2. Changelog
3. Todo

Requirements
------------

* Ruby >= 1.9.2
* Bundler

Installing MPM
--------------

Run the following in Terminal:

    git clone git://github.com/Port3M5/mpm.git ~/.mpm
    cd .mpm
    bundle install
    cd ~
    echo '# Enable MPM.
    [[ -s "$HOME/.mpm/bin/mpm" ]] && export PATH="$PATH:$HOME/.mpm/bin"' >> ~/.bash_profile
    source ~/.bash_profile
    mpm setup


Using MPM
---------

    mpm [-csm] list
    mpm [-csm] current
    mpm [-csm] new [-u] profile_name
    mpm [-csm] use profile_name

Changelog
---------

### 27/10/2011 ###
+ Fixed Setup copying the entire directory, not the contents, as is intended
+ Added a default location for minecraft on linux to be ~/.minecraft
+ Added the option to allow you to specify the location of the minecraft directory
+ Updated the help text

### 26/10/2011 ###
+ Removed as many references to Pathname.new as possible to speed up MPM. Using File.expand_path for path expansion and Fileutils for filesystem management. Pathname is now only used when getting the child packages in Packagemanager.list

### 24/10/2011 ###
 + Added the current Parameter, which just returns the name of the currently in use profile

### 23/10/2011 ###
+ Initial upload to GitHub
+ Improved logic to detect non-profiles

Todo
----
+ Neaten up code
+ Fix any bugs
