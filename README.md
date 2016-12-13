# Vagrant PrestaShop

This project is dedicated to PrestaShop modules and theme developers which are
searching for a rock solid and easy to setup development environment.

## Table Of Contents

- [Overview](#overview)
  - [PrestaShop](#prestashop)
  - [Vagrant](#vagrant)
  - [Puppet](#puppet)
  - [ngrok](#ngrok)
- [Installation](#installation)
- [Basic Usage](#basic-usage)
  - [Back Office](#back-office)
  - [MySQL](#mysql)
  - [PHPmyAdmin](#phpmyadmin)
  - [XDebug](#xdebug)
  - [Vagrant](#vagrant)
- [Development](#development)
  - [Module](#module)
  - [Theme](#theme)
  - [Expose local server](#expose-local-server)

## Overview

### PrestaShop

PrestaShop is a free and Open Source e-commerce web application, committed to
providing the best shopping cart experience for both merchants and customers.
It is written in PHP, is highly customizable, supports all the major payment
services, is translated in many languages and localized for many countries,
has a fully responsive design (both front and back office), etc.

The development environment includes PrestaShop version 1.7.

### Vagrant

[Vagrant](https://www.vagrantup.com/) provides easy to configure,
reproducible, and portable work environments built on top of
industry-standard technology and controlled by a single consistent
workflow to help maximize the productivity and flexibility of
you and your team.

To achieve its magic, Vagrant stands on the shoulders of giants. Machines
are provisioned on top of VirtualBox, VMware, AWS, or any other provider.
Then, industry-standard provisioning tools such as shell scripts, Chef, or
Puppet, can be used to automatically install and configure software on
the machine.

The development environment is based on Debian Jessie 64-bit.

### Puppet

[Puppet](https://puppet.com/), an automated administrative engine
for your Linux, Unix, and Windows systems, performs administrative
tasks (such as adding users, installing packages, and updating
server configurations) based on a centralized specification.

The development environment includes Puppet by default.

### ngrok

[ngrok](https://ngrok.com/) is a handy tool and service that allows you
tunnel requests from the wide open Internet to your local machine when
it's behind a NAT or firewall. This is useful in a number of cases,
such as when you want to show your client the current development status,
but you haven't yet deployed your code to an Internet accessible
host or PaaS.

## Installation

First, you need to make sure that you have [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and
[Vagrant](https://www.vagrantup.com/downloads.html) installed.

Then open up a terminal window and `cd` into the directory containing this README:

```shell
$ cd your-path-to-the-project
```

Now you only need to fire up Vagrant and everything will be installed and configured:

```shell
$ vagrant up
```

## Basic Usage

### Back Office

You can access the back office by the following url:

- [127.0.0.1:8080/admin123](http://127.0.0.1:8080/admin123)

To log into the back office use the credentials below:

- User: dev@prestashop.com
- Pass: prestashop

### MySQL

You can access the MySQL database with the following credentials:

- Host: localhost
- Port: 3306
- DB: prestashop
- User: prestashop
- Pass: prestashop

### PHPmyAdmin

You can access PHPmyAdmin by the following url:

- [127.0.0.1:8080/phpmyadmin](http://127.0.0.1:8080/phpmyadmin)

### XDebug

XDebug is included and enabled by default.

To configure XDebug you need to:

- set the server source root to `/var/www/`
- set the local source root to your current workspace

Now you can connect to XDebug on port 9000

Note: All XDebug settings can be configured in the php.ini file located in
the puppet directory.

### Vagrant

Vagrant is [very well documented](https://www.vagrantup.com/docs/) but here are a few common commands:

- `vagrant up` - starts the virtual machine and provisions it
- `vagrant suspend` - will essentially put the machine to 'sleep' with vagrant resume waking it back up
- `vagrant halt` - attempts a graceful shutdown of the machine and will need to be brought back with vagrant up
- `vagrant ssh` - gives you shell access to the virtual machine

## Development

### Module

To develop a PrestaShop module you only have to change Vagrant's synchronized directory. To do so, you
need to change the directory in the `Vagrantfile` to match your module name. And create a `src` directory in
the project root. For example:

```
config.vm.synced_folder "./src", "/var/www/modules/examplemodule"
```

to

```
config.vm.synced_folder "./src", "/var/www/modules/moduleXYZ"
```

### Theme

To develop a PrestaShop theme you only have to change Vagrant's synchronized directory. To do so, you
need to change the directory in the `Vagrantfile` to match your theme name. And create a `src` directory in
the project root. For example:

```
config.vm.synced_folder "./src", "/var/www/modules/examplemodule"
```

to

```
config.vm.synced_folder "./src", "/var/www/themes/themeXYZ"
```

### Expose local server

Don’t constantly redeploy your in-progress work to get feedback from clients.
ngrok creates a secure public URL (https://yourapp.ngrok.io) to a local webserver
on your machine. Iterate quickly with immediate feedback without interrupting
flow.

To expose your local server you need to do the following steps:

```
$ vagrant ssh
$ cd /var/www
$ ./ngrok http 80
```

Now you only need to copy the public URL and send it to your client.

CAUTION: You need to change the PrestaShop Site URL to the public ngrok URL.
Otherwise PrestaShop will redirect you to localhost.
