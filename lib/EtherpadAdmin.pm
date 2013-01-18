# vim:set sw=4 ts=4 expandtab:
package EtherpadAdmin;
use Mojo::Base 'Mojolicious';
use Schema;

# This method will run once at server start
sub startup {
    my $self = shift;

    # Documentation browser under "/perldoc"
    $self->plugin('PODRenderer');
    my $config = $self->plugin('Config'); 

    $self->app->helper(
        debug => sub {
            use Data::Dumper;
            $self->app->log->debug(Dumper($_[1]));
        }
    );
    $self->app->helper(
        db => sub {
            if ($self->config->{db}->{type} eq 'sqlite') {
                return Schema->connect('dbi:SQLite:dbname='.$self->config->{db}->{dbfile});
            } elsif ($self->config->{db}->{type} eq 'mysql') {
                return Schema->connect(
                    'dbi:mysql:host='.$self->config->{db}->{host}.';dbname='.$self->config->{db}->{dbname}.';port='.$self->config->{db}->{dbport},
                    $self->config->{db}->{dbuser},
                    $self->config->{db}->{dbpass}
                );
            } elsif ($self->config->{db}->{type} eq 'postgresql') {
                return Schema->connect(
                    'dbi:Pg:host='.$self->config->{db}->{host}.';dbname='.$self->config->{db}->{dbname}.';port='.$self->config->{db}->{dbport},
                    $self->config->{db}->{dbuser},
                    $self->config->{db}->{dbpass}
                );
            }
        }
    );
    $self->app->helper(
        pads => sub {
            my $db = $self->db;

            my $rs = $db->resultset('Store')->search(
                { 'me.key' => { -like => "pad2readonly:%" } }
            );

            my %pads;
            while (my $pad = $rs->next()) {
                my $padtitle = substr($pad->{_column_data}->{key}, 13);
                my $padro    = $pad->{_column_data}->{value};
                $padro       =~ s/^"|"$//g;
                $pads{$padtitle} = $padro;
            }
            if ($self->config->{db}->{type} eq 'sqlite' || $self->config->{db}->{type} eq 'mysql') {
                $rs = $db->resultset('Store')->search(
                    { 'me.key' => { 'REGEXP' => '^pad:[^:]*$' } }
                );
            } elsif ($self->config->{db}->{type} eq 'postgresql') {
                $rs = $db->resultset('Store')->search(
                    { 'me.key' => { '~' => '^pad:[^:]*$' } }
                );
            }
            while (my $pad = $rs->next()) {
                my $padtitle = substr($pad->{_column_data}->{key}, 4);
                $pads{$padtitle} = '' if (!defined($pads{$padtitle}));
            }
            return %pads
        }
    );


    # Router
    my $r = $self->routes;

    # Normal route to controller
    $r->get('/')->
        name('home')->
        to(controller => 'Admin', action => 'index');

    if ($config->{allowdelete}) {
        $r->get('/delete/:pad' => sub {
            $self = shift;
            $self->render(template => 'admin/delete', info => '')
        });

        $r->post('/delete')->
            to(controller => 'Admin', action => 'delete');
    }

    if ($config->{allowrename}) {
        $r->get('/rename/:pad' => sub {
            $self = shift;
            $self->render(template => 'admin/rename', info => '')
        });

        $r->post('/rename')->
            to(controller => 'Admin', action => 'rename');
    }
}

1;
