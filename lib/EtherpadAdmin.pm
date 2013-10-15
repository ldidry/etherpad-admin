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


    # Template handling
    $self->plugin('Template');


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
            my $parameters = {
                url    => $self->config->{etherpadapiurl} || $self->config->{etherpadurl},
                apikey => $self->config->{apikey}
            };
            if (defined($self->config->{epluser}) && defined($self->config->{eplpassword})) {
                $parameters->{user}     = $self->config->{epluser};
                $parameters->{password} = $self->config->{eplpassword};
            }
            my $ep = Etherpad::API->new($parameters);

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
        $r->get('/delete/*pad' => sub {
            my $self = shift;
            $self->render(
                template => 'admin/delete',
                info     => undef
            );
        });

        $r->post('/delete')->
            to(controller => 'Admin', action => 'delete');
    }

    $r->get('/infos/*pad')->
        to(controller => 'Admin', action => 'infos');

    $r->post('/create')->
        name('createpad')->
        to(controller => 'Admin', action => 'create');

    $r->get('templates')->
        to(controller => 'template', action => 'index');

    $r->get('templates/add' => sub {
        my $self = shift;
        $self->render(
            template => 'template/add',
            info     => undef,
            tname    => '',
            ttext    => ''
        );
    })->name('add_template');

    $r->post('templates/add')->
        name('add_template')->
        to(controller => 'template', action => 'add');

    $r->get('templates/modify/:clean_name' => sub {
        my $self = shift;
        $self->render(
            template   => 'template/modify',
            info       => undef,
            clean_name => $self->param('clean_name'),
            datas      => $self->templates->{$self->param('clean_name')}
        );
    })->name('modify_template');

    $r->post('templates/modify/:clean_name')->
        name('modify_template')->
        to(controller => 'template', action => 'modify');

    $r->get('templates/delete/:clean_name' => sub {
        my $self = shift;
        $self->render(
            template   => 'template/delete',
            info       => undef,
            clean_name => $self->param('clean_name'),
            datas      => $self->templates->{$self->param('clean_name')}
        );
    })->name('delete_template');

   $r->post('templates/delete')->
       to(controller => 'template', action => 'delete');
}

1;
