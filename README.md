# Overview

Portable, open source IRC bouncer written in C++. It can be extended using
modules written either in C++ or in Perl and Tcl.

# Usage

    $ juju deploy cs:~adam-stokes/znc

Before you can make use of your new IRC bouncer you'll need to set the proper
admin credentials.

## Set the admin username

    $ juju config znc admin_user="my_admin"

## Generate a new password for the admin user

    $ juju config znc admin_password='my_super@secret@password'

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
