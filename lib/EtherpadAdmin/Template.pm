# vim:set sw=4 ts=4 expandtab:
package EtherpadAdmin::Template;
use Mojo::Base 'Mojolicious::Controller';
use Text::CleanFragment;
use utf8;

sub index {
    my $self = shift;

    my $templates = $self->templates;

    my $info = (keys %{$templates}) ? [] : [['alert', $self->l('no_templates')]];

    $self->render(
        templates => $templates,
        info      => $info
    );
}

sub add {
    my $self = shift;
    my $name = $self->param('name');
    my $text = $self->param('text');

    my $templates = $self->templates;
    my %names     = map { $templates->{$_}->{name}, 1 } keys %{$templates};
    my $info;
    if (!defined($names{$name})) {
        my $clean_name = clean_fragment($name);
        while (defined($templates->{$clean_name})) {
            $clean_name .= '_';
        }

        $templates->{$clean_name} = {
            name => $name,
            text => $text
        };
        $self->write_templates;
        $info = [['alert-success', $self->l('add_templates', $name)]];

        $self->render(
            template  => 'template/index',
            templates => $templates,
            info      => $info
        );
    } else {
        $info = [['alert-error', $self->l('template_exists', $name)]];

        $self->render(
            template  => 'template/add',
            info      => $info,
            tname     => $name,
            ttext     => $text
        );
    }
}

sub modify {
    my $self       = shift;
    my $clean_name = $self->param('clean_name');
    my $name       = $self->param('name');
    my $text       = $self->param('text');

    my $templates  = $self->templates;
    my $info;
    $templates->{$clean_name} = {
        name => $name,
        text => $text
    };
    $self->write_templates;
    $info = [['alert-success', $self->l('modify_templates', $name)]];

    $self->render(
        template  => 'template/index',
        templates => $templates,
        info      => $info
    );
}

sub delete {
    my $self = shift;
    my $name = $self->param('clean_name');

    my $templates  = $self->templates;
    my $human_name = $templates->{$name}->{name};
    delete $templates->{$name};
    $self->write_templates;

    my $info = (keys %{$templates}) ? [] : [['alert', $self->l('no_templates')]];
    push @{$info}, ['alert-success', $self->l('template_delete', $human_name)];

    $self->render(
        template  => 'template/index',
        templates => $templates,
        info      => $info
    );
}

1;
