MPM: A Minecraft Profile Manager
================================

ToC
---

1. Installing MPM
1. Using MPM
2. Changelog
3. Todo

Installing MPM
--------------

Clone the repository into your home folder with `git clone git://github.com/Port3M5/mpm.git ~/.mpm` then add

    # Enable MPM.
    [[ -s "/Users/anthony/.mpm/bin/mpm" ]] && export PATH="$PATH:/Users/anthony/.mpm/bin"

to your `.bash_profile`

Using MPM
---------

    mpm [-cs] list
    mpm [-cs] new [-u] profile_name
    mpm [-cs] use profile_name

Changelog
---------

### 23/10/2011 ###

+ Initial upload to GitHub
+ Improved logic to detect non-profiles

Todo
----

+ This.
+ Make it compatible with Linux
+ Neaten up code
+ Fix any bugs
