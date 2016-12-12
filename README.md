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

# Developers

This charm uses Rake (a make like utility) for defining hooks and can be seen in
the **Rakefile**. It also uses a simple library **Charmkit** for providing some
additional helper methods such as templating.

To learn more visit [Charmkit](https://github.com/charmkit/charmkit).


# Maintainers

## Testing

The tests cover installation and verification that ZNC is installed and
running correctly. It'll also excercise the various `juju config` options.

## Ways to run the tests

### Use bundletester

```
sudo bundletester -F -t cs:~adam-stokes/znc -l DEBUG -v -r json -o /tmp/results.json
```

### Run tests via Ruby bundler

```
bundle install --local --with development
bundle exec rake znc:test
```

A few package dependencies may be required for testing locally, have a look in **tests/tests.yaml** for those package names.

# Author

Adam Stokes <adam.stokes@ubuntu.com>

# Copyright

2016 Adam Stokes <adam.stokes@ubuntu.com>

# License

MIT
