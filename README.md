#Etherpad-admin

Etherpad-admin est une interface permettant de lister tous les pads existants sur une installation d'[Etherpad-lite](https://github.com/ether/etherpad-lite), de supprimer des pads ou d'en créer un.

![Screenshot](https://raw.github.com/ldidry/etherpad-admin/master/demo.png)

##IMPORTANT
Etherpad-admin a été développé vite et pour cette raison ne se base pas sur l'API d'Etherpad-lite mais sur la base de données qu'il utilise.
C'est sale, je le sais, c'est peut-être dangereux, je tiens à ce que vous le sachiez.
De plus, il n'y a pas d'authentification, et cela permet donc à n'importe qui d'effacer des pads. Pensez à mettre une authentification sur le serveur web (cf fichier d'exemple nginx).

##Dépendances
Etherpad-admin utilise le framework Perl Mojolicious et, pour l'accès à la base de données, la bibliothèque DBIx::Class.
Utilisez la commande cpan pour les installer ou, pour Debian :
```shell
apt-get install libmojolicious-perl libdbix-class-perl
```

Pour l'accès à la base de données, vous aurez besoin de DBD::SQLite ou de DBD::mysql selon votre type de base de données.
Pour Debian, ces modules sont fournis respectivement par les paquets libdbd-sqlite3-perl et libdbd-mysql-perl.

##Configuration
Vous trouverez deux exemples de fichiers de configurations dans le dépôt git : `etherpad_admin.conf.sqlite.sample` et `etherpad_admin.conf.mysql.sample`.
Recopiez ou renommez celui dont vous avez besoin en `etherpad_admin.conf`.
* `allowrename` : permet de bloquer le renommage des pads si égal à 0, permet (à tout visiteur !) de renommer les pads si égal à 1.
* `allowdelete` : permet de bloquer la suppression des pads si égal à 0, permet (à tout visiteur !) de supprimer les pads si égal à 1.
* `etherpadurl` : est l'adresse du pad qui est administré
* `urlprefix`   : le chemin qui vous permet d'accéder à etherpad-admin.
  Par exemple, si vous y accédez par l'URL http://example.com/etherpad-admin/, urlprefix doit être '/etherpad-admin'.
  Si vous y accédez par l'URL http://padadmin.example.com/, ce sera ''
* `db -> type`  : deux choix sont possibles, 'sqlite' et 'mysql'.
 * sqlite : vous devrez créer une entrée `dbfile`. Mettez un chemin absolu.
 * mysql  : vous devrez créer des champs `host`, `dbname`, `dbuser` et `dbpass`

```perl
{
    hypnotoad => {
        user    => 'www-data',
        group   => 'www-data',
        listen  => ['http://127.0.0.1:4242'],
        workers => 2
    },
## Pour sqlite
    db => {
        type   => 'sqlite'
        dbfile => '/var/www/etherpad/var/etherpad.db'
    },
## Pour mysql
    db => {
        type   => 'mysql'
        host   => 'localhost',
        dbname => 'etherpad_dbname',
        dbuser => 'etherpad_dbuser',
        dbpass => 'etherpad_dbpass'
    },
##
    allowrename => 0,
    allowdelete => 0,
    etherpadurl => 'https://etherpad.example.com',
    urlprefix   => ''
};
```

##Twitter Bootstrap
Etherpad-admin utilise le [Twitter Bootstrap](http://twitter.github.com/bootstrap/), dont le code est sous license [Apache License v2.0](http://www.apache.org/licenses/LICENSE-2.0).

##License
Etherpad-admin est distribué selon les termes de la license [Apache License v2.0](http://www.apache.org/licenses/LICENSE-2.0).

##Divers
Vous trouverez un script d'init et un fichier de configuration nginx dans le dossier examples.
Utilisation de l'API : oui, peut-être un jour.
