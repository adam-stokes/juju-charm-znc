# Overview

znc - irc bouncer

# Usage

    $ juju deploy cs:~adam-stokes/znc

# Access webadmin

Use this page to add your users and networks, default port for the admin is **8888** but can bet changed with:

    juju config znc port=9000

The initial admin account is already created:

    username: admin
    password: password

This can be changed in the webview as well.

# Author

Adam Stokes <adam.stokes@ubuntu.com>
