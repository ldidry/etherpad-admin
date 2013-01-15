# vim:set sw=4 ts=4 expandtab:
package EtherpadAdmin::Admin;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub index {
    my $self = shift;

    my $db = $self->db;
    my $rs = $db->resultset('Store')->search(
        { 'me.key' => { -like => "pad2readonly:%" } }
    );

    my @pads;
    while (my $pad = $rs->next()) {
        my $padtitle = substr($pad->{_column_data}->{key}, 13);
        push @pads, $padtitle;
    }
    @pads = sort(@pads);

    # Render template "example/welcome.html.ep" with message
    $self->render(
        pads => \@pads,
        info => ''
    );
}

sub pdelete {
    my $self = shift;
    my $pad  = $self->param('pad');

    my $db = $self->db;
    my $rs = $db->resultset('Store')->search(
        {
            -or => [ 
                { 'store.key' => { -like => 'pad:'.$pad.'%' } },
                { 'store.key' => { -like => 'pad2readonly:'.$pad.'%' } },
                { 'store.value' => "\"$pad\"" }
            ]
        }
    );

    $rs->delete();
    #while (my $entry = $rs->next()) {
    #    $self->debug($entry);
    #    $entry->delete();
    #}

    $rs = $db->resultset('Store')->search(
        { 'me.key' => { -like => "pad2readonly:%" } }
    );

    my @pads;
    while (my $pad = $rs->next()) {
        my $padtitle = substr($pad->{_column_data}->{key}, 13);
        push @pads, $padtitle;
    }
    @pads = sort(@pads);

    # Render template "example/welcome.html.ep" with message
    $self->render(
        template => 'admin/index',
        pads => \@pads,
        info => 'Le pad '.$pad.' a bien été supprimé.'
    );
}

1;
