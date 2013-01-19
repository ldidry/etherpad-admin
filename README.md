#Etherpad-admin

Etherpad-admin is an interface which lists all the existing pads in an [Etherpad-lite](https://github.com/ether/etherpad-lite) installation, allows you to delete, rename or create pads.

![Screenshot](https://raw.github.com/ldidry/etherpad-admin/master/demo.png)

##WARNING
Etherpad-admin has been developed really quick and this is the reason it doesn't use the Etherpad-lite API, but the database it uses.
This is dirty, I know, it can be dangerous, I want you to know that.
Furthermore, there is no authentication, so anyone can delete pads. Remember to set an authentication on the web server (see the nginx example file).

##Dependancies
Etherpad-admin uses the Mojolicious Perl framework and, for the database access, the DBIx::Class library.
Use the cpan command to install them or, for Debian :
```shell
apt-get install libmojolicious-perl libdbix-class-perl
```

__Note__: The /usr/bin/hypnotoad binary (provided by Mojolicious) used by Etherpad-admin, is only available in the wheezy version (debian7) of the libmojolicious-perl package. Uses the cpan command to install Mojolicious on Debian stable.

```shell
cpan Mojolicious
```

For the database access, you will need DBD::SQLite, DBD::mysql or DBD::Pg according to your database type.
In Debian, this modules are provided respectively by the libdbd-sqlite3-perl, libdbd-mysql-perl and libdbd-pg-perl packages.

The internationalization system uses the Perl module Mojolicious::Plugin::I18N. It's easier to install it with the CPAN:
```shell
cpan Mojolicious::Plugin::I18N
```

Enfin, pour l'internationalisation, j'utilise Mojolicious::Plugin::I18N. Le plus simple est encore de l'installer par le CPAN :

```shell
cpan Mojolicious::Plugin::I18N
```

##Configuration
You will find three configuration examples in the git repository : `etherpad_admin.conf.sqlite.sample`, `etherpad_admin.conf.mysql.sample` and `etherpad_admin.conf.postgresql.sample`.
Recopy or rename the one you need in `etherpad_admin.conf`.
* `showreadonly` : shows (if equal to 1) or hides (if equal to 0) the pads' read-only URL.
* `allowrename`  : denies the pads' renaming if equal to 0, allows (anyone !) to rename pads if equal to 1.
* `allowdelete`  : denies the pads' deletion if equal to 0, allows (anyone !) to delete pads if equal to 1.
* `etherpadurl`  : this is the administrated etherpad's URL.
* `urlprefix`    : le chemin qui vous permet d'accéder à etherpad-admin.
* `urlprefix`    : the path you use to access etherpad-admin.
  For example, if you access it with the http://example.com/etherpad-admin/ URL, urlprefix has to be '/etherpad-admin'.
  If you access it by the http://padadmin.example.com/ URL, it will be ''.
* `db -> type`  : three choices are availables, 'sqlite', 'mysql' et 'postgresql'.
 * sqlite      : you have to create an `dbfile` entry. Give an absolute path.
 * mysql       : you have to create `host`, `dbname`, `dbuser`, `dbpass` and `dbport` fields.
 * postgresql  : you have to create `host`, `dbname`, `dbuser`, `dbpass` and `dbport` fields.
* `hypnotoad -> inactivity_timeout` : it is necessary to have a high value in order to avoid a renaming bug caused by a long processing time.
* `hypnotoad -> workers`            : hypnotoad server's threads number.

```perl
{
    hypnotoad => {
        user               => 'www-data',
        group              => 'www-data',
        listen             => ['http://127.0.0.1:4242'],
        workers            => 10,
        inactivity_timeout => 600
    },
## sqlite
    db => {
        type   => 'sqlite'
        dbfile => '/var/www/etherpad/var/etherpad.db'
    },
## mysql
    db => {
        type   => 'mysql'
        host   => 'localhost',
        dbname => 'etherpad_dbname',
        dbuser => 'etherpad_dbuser',
        dbpass => 'etherpad_dbpass',
        dbport => 3306
    },
## postgresql
    db => {
        type   => 'postgresql',
        host   => 'localhost',
        dbname => 'etherpad_dbname',
        dbuser => 'etherpad_dbuser',
        dbpass => 'etherpad_dbpass',
        dbport => 5432
    },
##
    showreadonly => 0,
    allowrename  => 0,
    allowdelete  => 0,
    etherpadurl  => 'https://etherpad.example.com',
    urlprefix    => '/liste'
};
```

##Others projects dependancies
Etherpad-admin uses the [Twitter Bootstrap](http://twitter.github.com/bootstrap/) which code is available under the [Apache License v2.0](http://www.apache.org/licenses/LICENSE-2.0) and [Spin.js](http://fgnass.github.com/spin.js/) which code is under the [MIT](http://opensource.org/licenses/mit-license.php) license.

##License
Etherpad-admin is distributed under the terms of the [Apache License v2.0](http://www.apache.org/licenses/LICENSE-2.0).

##Source code
In order to consult and/or get Etherpad-admin's source code, you can go to the [official page](http://dev.fiat-tux.fr/projects/etherpad-admin), clone the git official repository (`git clone git://git.fiat-tux.fr/etherpad-admin.gt`) or use the [github mirror](http://github.com/ldidry/etherpad-admin).

##Misc
You'll find an init script and a nginx configuration file in the examples directory.
API utilisation: one day, maybe.
