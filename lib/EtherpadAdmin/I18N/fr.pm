# Lexicon
package EtherpadAdmin::I18N::fr;
use Mojo::Base 'EtherpadAdmin::I18N';
use utf8;

our %Lexicon = (
    cancel              => 'Annuler',
    create_new_pad      => 'Créer un nouveau pad',
    delete              => 'Supprimer',
    deletion            => 'Suppression',
    new_pad_name        => 'Nom du nouveau pad',
    newname             => 'Nouveau nom',
    newname_exists      => 'Le pad [_1] existe déjà. Veuillez en choisir un autre.',
    newname_noslash     => 'Le nom d\'un pad ne peut pas contenir de slash (\'/\'). Veuillez en choisir un autre.',
    newname_notnull     => 'Le nouveau nom ne peut peut être nul !',
    pad_deletion        => 'Suppression du pad [_1]',
    pad_delete_notfound => 'Le pad [_1] n\'a pas été retrouvé et n\'a donc pu être supprimé',
    pad_delete_success  => 'Le pad [_1] a bien été supprimé.',
    pad_name            => 'Nom du pad',
    pad_rename          => 'Renommage du pad [_1]',
    pad_rename_notfound => 'Le pad [_1] n\'a pas été retrouvé et n\'a donc pu être renommé en [_2].',
    pad_rename_success  => 'Le pad [_1] a bien été renommé en [_2].',
    pads_list           => 'Liste des pads',
    rename              => 'Renommer',
    sure                => 'Êtes-vous bien sûr ?',
    url                 => 'Url',
    url_ro              => 'Url de lecture seule',
    what_newname        => 'Quel est le nouveau nom du pad ?'
);

1;
