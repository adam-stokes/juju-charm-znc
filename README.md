# Overview

DokuWiki is a simple to use and highly versatile Open Source wiki software that
doesn't require a database. It is loved by users for its clean and readable
syntax. The ease of maintenance, backup and integration makes it an
administrator's favorite. Built in access controls and authentication connectors
make DokuWiki especially useful in the enterprise context and the large number
of plugins contributed by its vibrant community allow for a broad range of use
cases beyond a traditional wiki.

# Usage

    $ juju deploy cs:~adam-stokes/dokuwiki

## Login

Initial login and password are

    username: admin
    password: password

## Using development version of Dokuwiki

    $ juju config dokuwiki release=development

# Releases

This charm supports a stable and development release where we track upstream.
New stable and development releases are uploaded to the charmstore via
resources.

# Testing

This charm comes with a `self-test` action that allows you to run individual
hooks and have it report on itself. This particular charm has simple tests
inlined with the flow of the hook code allowing you to get an idea on what's
happening at each step of the run. This also has gaurds that will error out if
items that the test expects are invalid.

To run a test:

    $ juju run-action dokuwiki self-test-hook --string-args hook=install

You can then check on the test status with:

    $ juju show-action-output <uuid displayed from previous run-action>

From there it will give you directions that you can copy and paste to see the
full test report.

    $ juju run --unit dokuwiki/0 "cat report-install.txt"

# Author

Adam Stokes <adam.stokes@ubuntu.com>
