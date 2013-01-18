#Etherpad-admin

Etherpad-admin est une interface permettant de lister tous les pads existants sur une installation d'[Etherpad-lite](https://github.com/ether/etherpad-lite), de supprimer des pads, de les renommer ou d'en créer un.

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

Pour l'accès à la base de données, vous aurez besoin de DBD::SQLite, de DBD::mysql ou de DBD::Pg selon votre type de base de données.
Pour Debian, ces modules sont fournis respectivement par les paquets libdbd-sqlite3-perl, libdbd-mysql-perl et libdbd-pg-perl.

##Configuration
Vous trouverez trois exemples de fichiers de configurations dans le dépôt git : `etherpad_admin.conf.sqlite.sample`, `etherpad_admin.conf.mysql.sample` et `etherpad_admin.conf.postgresql.sample`.
Recopiez ou renommez celui dont vous avez besoin en `etherpad_admin.conf`.
* `showreadonly` : affiche (si égal à 1) ou cache (si égal à 0) l'URL en lecture seule des pads.
* `allowrename`  : permet de bloquer le renommage des pads si égal à 0, permet (à tout visiteur !) de renommer les pads si égal à 1.
* `allowdelete`  : permet de bloquer la suppression des pads si égal à 0, permet (à tout visiteur !) de supprimer les pads si égal à 1.
* `etherpadurl`  : est l'adresse du pad qui est administré.
* `urlprefix`    : le chemin qui vous permet d'accéder à etherpad-admin.
  Par exemple, si vous y accédez par l'URL http://example.com/etherpad-admin/, urlprefix doit être '/etherpad-admin'.
  Si vous y accédez par l'URL http://padadmin.example.com/, ce sera ''.
* `db -> type`  : trois choix sont possibles, 'sqlite', 'mysql' et 'postgresql'.
 * sqlite      : vous devrez créer une entrée `dbfile`. Mettez un chemin absolu.
 * mysql       : vous devrez créer des champs `host`, `dbname`, `dbuser`, `dbpass` et `dbport`.
 * postgresql  : vous devrez créer des champs `host`, `dbname`, `dbuser`, `dbpass` et `dbport`.
* `hypnotoad -> inactivity_timeout` : il est nécessaire d'avoir une valeur élevée pour éviter un bug de redemande de renommage à cause d'un temps de traitement trop long.
* `hypnotoad -> workers`            : nombre de threads du serveur hypnotoad

```perl
{
    hypnotoad => {
        user               => 'www-data',
        group              => 'www-data',
        listen             => ['http://127.0.0.1:4242'],
        workers            => 10,
        inactivity_timeout => 600
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
        dbpass => 'etherpad_dbpass',
        dbport => 3306
    },
## Pour postgresql
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

##Dépendance à d'autres projets
Etherpad-admin utilise le [Twitter Bootstrap](http://twitter.github.com/bootstrap/) dont le code est sous license [Apache License v2.0](http://www.apache.org/licenses/LICENSE-2.0) ainsi que [Spin.js](http://fgnass.github.com/spin.js/) dont le code est sous license [MIT](http://opensource.org/licenses/mit-license.php).

##License
Etherpad-admin est distribué selon les termes de la license [Apache License v2.0](http://www.apache.org/licenses/LICENSE-2.0).

##Code source
Pour consulter et/ou récupérer le code source d'Etherpad-admin, vous pouvez vous rendre sur la [page officielle](http://dev.fiat-tux.fr/projects/etherpad-admin), cloner le dépôt git officiel (`git clone git://git.fiat-tux.fr/etherpad-admin.gt`) ou utiliser le miroir [github](http://github.com/ldidry/etherpad-admin).

##Divers
Vous trouverez un script d'init et un fichier de configuration nginx dans le dossier examples.
Utilisation de l'API : oui, peut-être un jour.
