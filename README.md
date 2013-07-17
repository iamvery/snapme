snapme
======

A small daemon process that takes a snapshot of you at a given interval and
posts it to Snapme for all your team to see!

Requrirements
-------------

* Mac OS X
* Image capture devise (ex. iSight camera)
* Ruby 2.0 *

\* Note: I got fancy with Ruby 2.0's keyword arguments... This was probably a
bad choice for a general purchase library. Complain at me and it will be fixed.

Installation
------------

```bash
gem install snapme
```

Usage
-----

```bash
$ snapme     # process will be daemonized
$ snapme -h  # to print the command line options
```
