package Mojolicious::Plugin::Template;
use Mojo::Base 'Mojolicious::Plugin';
use File::Spec::Functions 'file_name_is_absolute';
use Storable;

sub register {
    my ($self, $app, $conf) = @_;

    my $home = $app->home;
    my $file = $app->moniker . '.' . 'templates';
    $file = $home->rel_file($file) unless file_name_is_absolute $file;

    $app->helper(
        templates => sub {
            my $self = shift;
            if (defined($self->stash('templates'))) {
                return $self->stash('templates');
            } else {
                my $templates = {};
                if (-e $file) {
                    $templates = retrieve($file);
                } else {
                    store $templates, $file;
                }
                $self->stash(templates => $templates);
                return $templates;
            }
        }
    );

    $app->helper(
        write_templates => sub {
            my $self = shift;

            my $templates = $self->templates;

            store $templates, $file;
        }
    );

    return $app->templates;
}

1;
