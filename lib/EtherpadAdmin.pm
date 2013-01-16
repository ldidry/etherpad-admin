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
                    'dbi:mysql:host='.$self->config->{db}->{host}.':dbname='.$self->config->{db}->{dbname},
                    $self->config->{db}->{dbuser},
                    $self->config->{db}->{dbpass}
                );
            }
        }
    );

    # Router
    my $r = $self->routes;

    # Normal route to controller
    $r->get('/')->
        name('home')->
        to(controller => 'Admin', action => 'index');

    $r->get('/delete/:pad')->
        to('admin#delete');

    $r->post('/delete')->
        to(controller => 'Admin', action => 'pdelete');
}

1;
