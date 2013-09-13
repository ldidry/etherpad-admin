# vim:set sw=4 ts=4 expandtab:
package EtherpadAdmin::Admin;
use Mojo::Base 'Mojolicious::Controller';
use DateTime;
use utf8;

sub index {
    my $self = shift;

    my $ep   = $self->ep;
    my $pads = $ep->list_all_pads();

    my $info;
    $info = ['alert', $self->l('no_pads')] unless(@{$pads});

    $self->render(
        pads => $pads,
        info => $info
    );
}

sub create {
    my $self       = shift;
    my $pad        = $self->param('pad');
    my $clean_name = $self->param('clean_name');
    my ($result, $message);

    my $template = ($clean_name eq '') ? undef : $self->templates->{$clean_name};

    my $ep   = $self->ep;
    my @pads = $ep->list_all_pads();
    my %hash = map { $_, 1 } @pads;

    if (defined $hash{$pad}) {
        $result  = 0;
        $message = $self->l('newname_exists', $pad);
    } else {
        $result = $ep->create_pad($pad, $template->{text});
    }

    $self->render(json => {
            success => $result,
            message => $message,
            pad     => $pad
        }
    );
}

sub infos {
    my $self = shift;
    my $pad  = $self->param('pad');

    my $ep              = $self->ep;
    my $revisions_count = $ep->get_revisions_count($pad);
    my @authors         = $ep->list_names_of_authors_of_pad($pad);
    my $last_edited     = $ep->get_last_edited($pad);
    my $read_only_id    = $ep->get_read_only_id($pad);
    my $content         = $ep->get_html($pad);

    # I18n for the anonymous authors
    if (@authors && $authors[-1]  =~ s/^(\d+) anonymous$/$1/) {
        if ($authors[-1] == 1) {
            $authors[-1] .= $self->l('anonymous');
        } else {
            $authors[-1] .= $self->l('anonymous_several');
        }
    }
    my $authors = join(', ', @authors);

    # $last_edited is in millisecondes
    $last_edited =~ s/\d{3}$//;
    my $dt = DateTime->from_epoch(epoch => $last_edited, locale => $self->languages);
    $last_edited = $dt->strftime($self->l('date_format'));

    # Create the ro url
    my $read_only_url = $self->config->{etherpadurl}.'/p/'.$read_only_id;

    $self->render(
        info            => undef,
        pad             => $pad,
        revisions_count => $revisions_count,
        authors         => $authors,
        last_edited     => $last_edited,
        read_only_url   => $read_only_url,
        content         => $content
    );
}

sub delete {
    my $self = shift;
    my $pad  = $self->param('pad');

    my $ep = $self->ep;
    my $result = $ep->delete_pad($pad);

    my $info;
    if ($result == 1) {
        $info = [['alert-success', $self->l('pad_delete_success', $pad)]];
    } else {
        $info = [['alert-error', $self->l('pad_delete_notfound', $pad)]];
    }

    my $pads = $ep->list_all_pads();
    unshift @{$info}, ['alert', $self->l('no_pads')] unless(@{$pads});

    $self->render(
        template => 'admin/index',
        pads     => $pads,
        info     => $info
    );
}

1;
