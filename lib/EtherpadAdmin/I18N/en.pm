# Lexicon
package EtherpadAdmin::I18N::en;
use Mojo::Base 'EtherpadAdmin::I18N';

our %Lexicon = (
    cancel              => 'Cancel',
    create_new_pad      => 'Create new pad',
    delete              => 'Delete',
    deletion            => 'Deletion',
    new_pad_name        => 'New pad name',
    newname             => 'New name',
    newname_exists      => 'The pad [_1] already exists. Please choose an other name.',
    newname_noslash     => 'The name of a pad can\'t contain a slash (\'/\'). Please choose an other name.',
    newname_notnull     => 'The new name can\'t be null !',
    pad_delete_notfound => 'The pad [_1] couldn\'t be found and has not been deleted',
    pad_delete_success  => 'The pad [_1] has been deleted.',
    pad_deletion        => 'Delete [_1]',
    pad_name            => 'Pad name',
    pad_rename          => 'Rename [_1] pad',
    pad_rename_notfound => 'The pad [_1] couldn\'t be found and has not been renamed in [_2].',
    pad_rename_success  => 'The pad [_1] has been renamed in [_2].',
    pads_list           => 'Pads list',
    rename              => 'Rename',
    sure                => 'Are you sure ?',
    url                 => 'Url',
    url_ro              => 'Read-only url',
    what_newname        => 'What is the pad\'s new name ?'
);

1;
