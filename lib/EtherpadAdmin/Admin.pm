# vim:set sw=4 ts=4 expandtab:
package EtherpadAdmin::Admin;
use Mojo::Base 'Mojolicious::Controller';
use utf8;

sub index {
    my $self = shift;

    my %pads = $self->pads;

    $self->render(
        pads => \%pads,
        info => ''
    );
}

sub rename {
    my $self     = shift;
    my $pad      = $self->param('pad');
    my $newname  = $self->param('newname');
    if (!$newname) {
        $self->render(
            template => 'admin/rename',
            info     => ['alert-error', $self->l('newname_notnull')],
            pad      => $pad
        );
    }

    if ($newname =~ m/\//) {
        $self->render(
            template => 'admin/rename',
            info     => ['alert-block', $self->l('newname_noslash')],
            pad      => $pad
        );
    } else {
        $newname =~ s/\s+|:+|"/_/g;

        my $db    = $self->db;
        my $taken = $db->resultset('Store')->find(
            {
                'me.key' => 'pad2readonly:'.$newname
            }
        );

        if ($taken) {
            $self->render(
                template => 'admin/rename',
                info     => ['alert-block', $self->l('newname_exists', $newname)],
                pad      => $pad
            );
        } else {
            my $notfound = 0;

            my $rs = $db->resultset('Store')->search({ 'me.value' => "\"$pad\"" });
            if ($rs->count()) {
                while (my $record = $rs->next()) {
                    my $value = $record->{_column_data}->{value};

                    $value =~ s/^"$pad"$/"$newname"/;
                    $record->update(
                        {
                            'value' => $value
                        }
                    );
                }
            } else {
                $notfound++;
            }

            for my $keyword (qw/pad pad2readonly/) {
                $rs = $db->resultset('Store')->search({ 'me.key' => "$keyword:$pad" });
                if ($rs->count()) {
                    while (my $record = $rs->next()) {
                        my $key = $record->{_column_data}->{key};

                        $key    =~ s/^$keyword:$pad/$keyword:$newname/;
                        $record->update(
                            {
                                'key' => $key
                            }
                        );
                    }
                } else {
                    $notfound++;
                }
            }

            $rs = $db->resultset('Store')->search({ 'me.key'   => { -like => 'pad:'.$pad.':%' }});
            if ($rs->count()) {
                while (my $record = $rs->next()) {
                    my $key   = $record->{_column_data}->{key};

                    $key      =~ s/^pad:$pad:/pad:$newname:/;
                    $record->update(
                        {
                            'key' => $key
                        }
                    );
                }
            } else {
                $notfound++;
            }

            my $info;
            if ($notfound == 4) {
                $info = ['alert-error', $self->l('pad_rename_notfound', $pad, $newname)];
            } else {
                $info = ['alert-success', $self->l('pad_rename_success', $pad, $newname)];
            }

            my %pads = $self->pads;

            $self->render(
                template => 'admin/index',
                pads     => \%pads,
                info     => $info
            );
        }
    }
}

sub delete {
    my $self = shift;
    my $pad  = $self->param('pad');

    my $db = $self->db;
    my $rs = $db->resultset('Store')->search(
        {
            -or => [
                { 'value' => "\"$pad\""},
                { 'key'   => 'pad:'.$pad },
                { 'key'   => 'pad2readonly:'.$pad },
                { 'key'   => { -like => 'pad:'.$pad.':%' } }
            ]
        }
    );

    my $info;
    if ($rs->count()) {
        $rs->delete();

        $info = ['alert-success', $self->l('pad_delete_success', $pad)];
    } else {
        $info = ['alert-error', $self->l('pad_delete_notfound', $pad)];
    }

    my %pads = $self->pads;

    $self->render(
        template => 'admin/index',
        pads     => \%pads,
        info     => $info
    );
}

1;
