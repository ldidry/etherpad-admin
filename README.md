#Etherpad-admin

Etherpad-admin est une interface permettant de lister tous les pads existants sur une installation d'[Etherpad-lite](https://github.com/ether/etherpad-lite), de supprimer des pads ou d'en créer un.
Cette installation d'Etherpad-lite doit utiliser une base MySQL pour qu'Etherpad-admin puisse fonctionner.

![Screenshot](https://raw.github.com/ldidry/etherpad-admin/master/demo.png)

##IMPORTANT
Etherpad-admin a été développé vite et pour cette raison ne se base pas sur l'API d'Etherpad-lite mais sur la base MySQL qu'il utilise.
C'est sale, je le sais, c'est peut-être dangereux, je tiens à ce que vous le sachiez.

##Dépendances
Etherpad-admin utilise le framework Perl Mojolicious et, pour l'accès à la base de données, la bibliothèque DBIx::Class.
Utilisez la commande cpan pour les installer ou, pour Debian :
```shell
apt-get install libmojolicious-perl libdbix-class-perl
```

##Configuration
Tout ce dont vous avez besoin est dans le fichier `etherpad_admin.conf`.
* `etherpadurl` est l'adresse du pad qui est administré
* `urlprefix` est le chemin qui vous permet d'accéder à etherpad-admin.
  Par exemple, si vous y accédez par l'URL http://example.com/etherpad-admin/, urlprefix doit être '/etherpad-admin'.
  Si vous y accédez par l'URL http://padadmin.example.com/, ce sera '/'

```perl
{
    hypnotoad => {
        user => 'www-data',
        group => 'www-data',
        listen => ['http://127.0.0.1:4242'],
        workers => 2
    },
    db => {
        host => 'localhost',
        dbname => 'etherpad_dbname',
        dbuser => 'etherpad_dbuser',
        dbpass => 'etherpad_dbpass'
    },
    etherpadurl => 'https://etherpad.example.com',
    urlprefix => '/'
};
```

##Twitter Bootstrap
Etherpad-admin utilise le [Twitter Bootstrap](http://twitter.github.com/bootstrap/), dont le code est sous license [Apache License v2.0](http://www.apache.org/licenses/LICENSE-2.0).

##License
Etherpad-admin est distribué selon les termes de la license [Apache License v2.0](http://www.apache.org/licenses/LICENSE-2.0).

##Divers
Vous trouverez un script d'init et un fichier de configuration nginx dans le dossier examples.
Si vous trouvez qu'Etherpad-admin mérite de fonctionner aussi sur les Etherpad-lite utilisant une base SQLite, faites un patch. Ou ouvrez un ticket, mais alors je ne garantis pas la durée de développement :).
Utilisation de l'API : oui, peut-être un jour.
