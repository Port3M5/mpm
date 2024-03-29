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

* Ruby

Installing MPM
--------------

Run the following in Terminal:

    gem install mpm


Using MPM
---------

    mpm [-csm] launch
    mpm [-csm] list
    mpm [-csm] current
    mpm [-csm] new [-u] profile_name
    mpm [-csm] use profile_name

Changelog
---------

### 7/11/2011 ###
+ Turned application into a gem to make it more portable.
+ Updated this to reflect changes.

### 28/10/2011 ###
+ Added the launch command
+ On creation of a new profile the launcher is downloaded into the root of the folder.

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
