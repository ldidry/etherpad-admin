# Lexicon
package EtherpadAdmin::I18N::fr;
use Mojo::Base 'EtherpadAdmin::I18N';
use utf8;

our %Lexicon = (
    add_templates            => 'Le modèle [_1] a été créé avec succès.',
    anonymous                => ' anonyme',
    anonymous_several        => ' anonymes',
    authors_list             => 'Liste des auteurs :',
    cancel                   => 'Annuler',
    content                  => 'Contenu :',
    create_new_pad           => 'Créer un nouveau pad',
    date_format              => '%A %d %B %Y, à %T',
    default                  => 'Modèle par défaut',
    delete                   => 'Supprimer',
    deletion                 => 'Suppression',
    infos                    => 'Détails',
    last_edit                => 'Dernière édition :',
    modify                   => 'Modifier',
    modify_templates         => 'Le modèle [_1] a été modifié avec succès.',
    new_pad_name             => 'Nom du nouveau pad',
    newname                  => 'Nouveau nom',
    newname_exists           => 'Le pad [_1] existe déjà. Veuillez choisir un autre nom.',
    newname_noslash          => 'Le nom d\'un pad ne peut pas contenir de slash (\'/\'). Veuillez en choisir un autre.',
    newname_notnull          => 'Le nouveau nom ne peut peut être nul !',
    no_pads                  => 'Vous n\'avez aucun pad',
    no_templates             => 'Vous n\'avez aucun modèle',
    pad_delete_notfound      => 'Le pad [_1] n\'a pas été retrouvé et n\'a donc pu être supprimé',
    pad_delete_success       => 'Le pad [_1] a bien été supprimé.',
    pad_deletion             => 'Suppression du pad [_1]',
    pad_infos                => 'Détails du pad [_1]',
    pad_name                 => 'Nom du pad',
    pads_list                => 'Liste des pads',
    rev_count                => 'Nombre de révisions :',
    submit                   => 'Valider',
    sure                     => 'Êtes-vous bien sûr ?',
    template_add_btn         => 'Ajouter un modèle',
    template_content         => 'Texte du modèle',
    template_delete          => 'Le modèle [_1] a bien été supprimé',
    template_deletion        => 'Suppression du modèle [_1]',
    template_exists          => 'Le modèle [_1] existe déjà. Veuillez choisir un autre nom.',
    template_modify          => 'Modification du modèle [_1]',
    template_name            => 'Nom du modèle',
    templates                => 'Gérer les modèles de pad',
    templates_list           => 'Liste des modèles',
    url                      => 'Url',
    url_ro                   => 'Url de lecture seule',
    what_newname             => 'Quel est le nouveau nom du pad ?'
);

1;
