# chef-scipy [![Build Status](https://secure.travis-ci.org/bflad/chef-scipy.png?branch=master)](http://travis-ci.org/bflad/chef-scipy)

## Description

Installs [SciPy](http://www.scipy.org) according to [Scipy Stack 1.0 specification](http://www.scipy.org/stackspec.html#stackspec).

## Requirements

### Platforms

* CentOS 6
* Fedora 17, 18, 19
* Red Hat Enterprise Linux 6
* Ubuntu 12.04, 12.10, 13.04

### Cookbooks

[Opscode Cookbooks](https://github.com/opscode-cookbooks/)

* [apt](https://github.com/opscode-cookbooks/apt)
* [python](https://github.com/opscode-cookbooks/python)
* [yum](https://github.com/opscode-cookbooks/yum)

## Attributes

These attributes are under the `node['scipy']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
install_type | "package" or "source" | String | package
packages | OS packages for installation | Array of Strings | auto-detected (see attributes/default.rb)
pip_packages | PIP packages for installation | Array of Strings | auto-detected (see attributes/default.rb)

## Recipes

* `recipe[scipy]` default installation of SciPy
* `recipe[scipy::package]` Installs SciPy via OS packages
* `recipe[scipy::source]` Installs SciPy via source

## Usage

### SciPy Installation

* Optionally set `node['scipy']['install_type']`
* Add `recipe[scipy]` to your node's run list.

## Testing and Development

Here's how you can quickly get testing or developing against the cookbook thanks to [Vagrant](http://vagrantup.com/) and [Berkshelf](http://berkshelf.com/).

    git clone git://github.com/bflad/chef-scipy.git
    cd chef-scipy
    vagrant plugin install vagrant-berkshelf
    vagrant plugin install vagrant-omnibus
    vagrant up BOX # BOX being centos6, ubuntu1204, ubuntu1210, or ubuntu1304

You can then SSH into the running VM using the `vagrant ssh` command.
The VM can easily be stopped and deleted with the `vagrant destroy`
command. Please see the official [Vagrant documentation](http://vagrantup.com/v1/docs/commands.html)
for a more in depth explanation of available commands.

## Contributing

Please use standard Github issues/pull requests and if possible, in combination with testing on the Vagrant boxes.

## License and Authors

See [LICENSE](LICENSE) file for more information.

* Author:: Brian Flad (<bflad417@gmail.com>)
* Copyright:: 2013 Brian Flad
