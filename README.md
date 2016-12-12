# Overview

Portable, open source IRC bouncer written in C++. It can be extended using
modules written either in C++ or in Perl and Tcl.

# Usage

    $ juju deploy cs:~adam-stokes/znc

## Set the admin username

    $ juju config znc admin_user="my_admin"

## Generate a new password for the admin user

The easiest way to generate a new password is via the `mkpasswd` command which
is provided in the `whois` package:

    $ sudo apt install whois
    $ mkpasswd -m sha-256 my_new_password@@@
    $5$fY2f3b0F0V$1kNMY3L1ThihvlRkl206Al0X/qtB8O.cYzqwAi7Y4U8
    $ juju config znc admin_password='$5$fY2f3b0F0V$1kNMY3L1ThihvlRkl206Al0X/qtB8O.cYzqwAi7Y4U8'

# Access webadmin

Once an admin user and password is defined you can use the webadmin page to add
your users and networks.

The default port for the admin is **8888** but can be changed with:

    juju config znc port=9000

# Author

Adam Stokes <adam.stokes@ubuntu.com>

# Copyright

2016 Adam Stokes <adam.stokes@ubuntu.com>

# License

MIT
