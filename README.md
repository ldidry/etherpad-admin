#Etherpad-admin

Etherpad-admin is an interface which lists all the existing pads in an [Etherpad-lite](https://github.com/ether/etherpad-lite) installation, allows you to delete pads, create pads and get some informations about the pads.
You can also manage templates for new pads : set texts and reuse them for creating pads.

![Screenshot](https://raw.github.com/ldidry/etherpad-admin/master/demo.png)

##WARNING
There is no authentication, so anyone can delete pads. Remember to set an authentication on the web server (see the nginx example file).

##SECOND WARNING
From version 0.03, Etherpad-admin uses the Etherpad Lite API, there is a lot of changes, so, please, read this README carefully.

##Dependancies
Etherpad-admin uses the Mojolicious Perl framework.
Use the cpan command to install them or, for Debian :
```shell
apt-get install libmojolicious-perl
```

__Note__: The /usr/bin/hypnotoad binary (provided by Mojolicious) used by Etherpad-admin, is only available in the wheezy version (debian7) of the libmojolicious-perl package. Uses the cpan command to install Mojolicious on Debian stable.

```shell
cpan Mojolicious
```

The internationalization system uses the Perl module Mojolicious::Plugin::I18N. It's easier to install it with the CPAN:
```shell
cpan Mojolicious::Plugin::I18N
```

Etherpad-admin now use the [Etherpad::API](http://search.cpan.org/~ldidry/Etherpad-API-0.04/lib/Etherpad/API.pm) module, developed specially for Etherpad-admin.
```shell
cpan Etherpad::API
```

You will also need the DateTime module.
```shell
apt-get install libdatetime-perl
```

or
```shell
cpan DateTime
```

More modules you have to install : Text::CleanFragment and Storable
```shell
cpan Text::CleanFragment Storable
```

##Configuration
You will find a configuration file in the git repository : `examples/etherpad_admin.conf.sample`.
Recopy or rename the one you need in `etherpad_admin.conf`.
* `allowdelete`    : denies the pads' deletion if equal to 0, allows (anyone !) to delete pads if equal to 1.
* `etherpadurl`    : this is the administrated etherpad's URL.
* `etherpadapiurl` : __Optional__ if the etherpad api url needs to be different from etherpadurl
* `epluser`        : __Optional__ the epl user if it needs an authentication
* `eplpassword`    : __Optional__ the epl password if it needs an authentication
* `apikey`         : this is the administrated etherpad's secret API key.
* `urlprefix`      : the path you use to access etherpad-admin.
  For example, if you access it with the http://example.com/etherpad-admin/ URL, urlprefix has to be '/etherpad-admin'.
  If you access it by the http://padadmin.example.com/ URL, it will be ''.
* `hypnotoad`      : the hypnotoad web server configuration. Please, have a look here : http://mojolicio.us/perldoc/Mojo/Server/Hypnotoad

```perl
{
    hypnotoad => {
        user    => 'www-data',
        group   => 'www-data',
        listen  => ['http://127.0.0.1:4242'],
        workers => 2,
    },
    allowdelete  => 0,
    etherpadurl  => 'https://etherpad.example.com',
    apikey       => 'S3cr3tP4ss',
    urlprefix    => '/liste'
};
```

##Others projects dependancies
Etherpad-admin uses the [Twitter Bootstrap](http://twitter.github.com/bootstrap/) which code is available under the [Apache License v2.0](http://www.apache.org/licenses/LICENSE-2.0) and jQuery  which code is available under the [MIT License](http://github.com/jquery/jquery/blob/master/MIT-LICENSE.txt).

##License
Etherpad-admin is distributed under the terms of the [Apache License v2.0](http://www.apache.org/licenses/LICENSE-2.0).

##Source code
In order to consult and/or get Etherpad-admin's source code, you can go to the [github repository](http://github.com/ldidry/etherpad-admin).

##Misc
You'll find an init script and a nginx configuration file in the examples directory.
