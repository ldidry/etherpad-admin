# vim:set sw=4 ts=4 expandtab:
package EtherpadAdmin;
use Mojo::Base 'Mojolicious';
use Etherpad::API;

# This method will run once at server start
sub startup {
    my $self = shift;

    ## Plugins
    # Documentation browser under "/perldoc"
    $self->plugin('PODRenderer');

    # Config
    my $config = $self->plugin('Config'); 

    # Internationalization
    $self->plugin('I18N');


    ## Helpers
    $self->app->helper(
        debug => sub {
            use Data::Dumper;
            $self->app->log->debug(Dumper($_[1]));
        }
    );
    $self->app->helper(
        ep => sub {
            my $self = shift;
            my $ep = Etherpad::API->new(
                {
                    url    => $self->config->{etherpadurl},
                    apikey => $self->config->{apikey}
                }
            );

            return $ep;
        }
    );


    ## Router
    my $r = $self->routes;


    ## Normal routes to controller
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

    $r->get('/infos/:pad')->
        to(controller => 'Admin', action => 'infos');
}

1;
