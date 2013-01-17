# vim:set sw=4 ts=4 expandtab:
package EtherpadAdmin::Admin;
use Mojo::Base 'Mojolicious::Controller';

sub _getpads {
    my $db = shift;

    my $rs = $db->resultset('Store')->search(
        { 'me.key' => { -like => "pad2readonly:%" } }
    );

    my @pads;
    while (my $pad = $rs->next()) {
        my $padtitle = substr($pad->{_column_data}->{key}, 13);
        push @pads, $padtitle;
    }
    return sort(@pads);
}

sub index {
    my $self = shift;

    my @pads = _getpads($self->db);

    $self->render(
        pads => \@pads,
        info => ''
    );
}

sub rename {
    my $self     = shift;
    my $pad      = $self->param('pad');
    my $newname  = $self->param('newname');

    $newname =~ s/ /_/g;

    my $db    = $self->db;
    my $taken = $db->resultset('Store')->find(
        {
            'me.key' => 'pad2readonly:'.$newname
        }
    );

    if ($taken) {
        $self->render(
            template => 'admin/rename',
            info     => 'Le nom '.$newname.' existe déjà. Veuillez en choisir un autre.',
            pad      => $pad
        );
    } else {

        my $rs = $db->resultset('Store')->search({ 'me.value' => "\"$pad\"" });
        while (my $record = $rs->next()) {
            my $value = $record->{_column_data}->{value};

            $value    =~ s/^"$pad"$/"$newname"/;
            $record->update(
                {
                    value => $value
                }
            );
        }

        for my $keyword (qw/pad pad2readonly/) {
            $rs = $db->resultset('Store')->search({ 'me.key' => "$keyword:$pad" });
            while (my $record = $rs->next()) {
                my $key = $record->{_column_data}->{key};

                $key    =~ s/^$keyword:$pad/$keyword:$newname/;
                $record->update(
                    {
                        'key' => $key
                    }
                );
            }
        }

        $rs = $db->resultset('Store')->search({ 'me.key'   => { -like => 'pad:'.$pad.':%' }});
        while (my $record = $rs->next()) {
            my $key   = $record->{_column_data}->{key};

            $key      =~ s/^pad:$pad:/pad:$newname:/;
            $record->update(
                {
                    'key' => $key
                }
            );
        }

        my @pads = _getpads($self->db);

        $self->render(
            template => 'admin/index',
            pads     => \@pads,
            info     => 'Le pad '.$pad.' a bien été renommé en '.$newname.'.'
        );
    }
}

sub delete {
    my $self = shift;
    my $pad  = $self->param('pad');

    my $db = $self->db;
    my $rs = $db->resultset('Store')->search(
        {
            -or => [
                { 'store.value' => "\"$pad\"" },
                { 'store.key'   => 'pad:'.$pad },
                { 'store.key'   => 'pad2readonly:'.$pad },
                { 'store.key'   => { -like => 'pad:'.$pad.':%' } }
            ]
        }
    );

    $rs->delete();

    $rs = $db->resultset('Store')->search(
        { 'me.key' => { -like => "pad2readonly:%" } }
    );

    my @pads = _getpads($self->db);

    $self->render(
        template => 'admin/index',
        pads     => \@pads,
        info     => 'Le pad '.$pad.' a bien été supprimé.'
    );
}

1;
