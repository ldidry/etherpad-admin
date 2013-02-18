# Lexicon
package EtherpadAdmin::I18N::en;
use Mojo::Base 'EtherpadAdmin::I18N';


our %Lexicon = (
    anonymous           => ' anonymous',
    anonymous_several   => ' anonymous',
    authors_list        => 'Authors list:',
    cancel              => 'Cancel',
    content             => 'Content:',
    create_new_pad      => 'Create new pad',
    date_format         => '%A %d %B %Y, at %T',
    delete              => 'Delete',
    deletion            => 'Deletion',
    infos               => 'Details',
    last_edit           => 'Last edition:',
    new_pad_name        => 'New pad name',
    newname             => 'New name',
    newname_exists      => 'The pad [_1] already exists. Please choose an other name.',
    newname_noslash     => 'The name of a pad can\'t contain a slash (\'/\'). Please choose an other name.',
    newname_notnull     => 'The new name can\'t be null !',
    pad_delete_notfound => 'The pad [_1] couldn\'t be found and has not been deleted',
    pad_delete_success  => 'The pad [_1] has been deleted.',
    pad_deletion        => 'Delete [_1]',
    pad_infos           => 'Details of [_1] pad',
    pad_name            => 'Pad name',
    pads_list           => 'Pads list',
    rev_count           => 'Revisions count:',
    sure                => 'Are you sure ?',
    url                 => 'Url',
    url_ro              => 'Read-only url',
    what_newname        => 'What is the pad\'s new name ?'
);

1;
