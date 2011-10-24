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

    mpm [-cs] list
    mpm [-cs] current
    mpm [-cs] new [-u] profile_name
    mpm [-cs] use profile_name

Changelog
---------

### 24/10/2011 ###
 + Added the current Parameter, which just returns the name of the currently in use profile

### 23/10/2011 ###
+ Initial upload to GitHub
+ Improved logic to detect non-profiles

Todo
----
+ This.
+ Make it compatible with Linux
+ Neaten up code
+ Fix any bugs
