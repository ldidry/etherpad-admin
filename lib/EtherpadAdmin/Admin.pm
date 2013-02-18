# vim:set sw=4 ts=4 expandtab:
package EtherpadAdmin::Admin;
use Mojo::Base 'Mojolicious::Controller';
use DateTime;
use utf8;

sub index {
    my $self = shift;

    my $ep   = $self->ep;
    my $pads = $ep->list_all_pads();

    $self->render(
        pads => $pads,
        info => ''
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

    $self->debug($content);

    # I18n for the anonymous authors
    if ($authors[-1]  =~ s/^(\d+) anonymous$/$1/) {
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
        info            => '',
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
        $info = ['alert-success', $self->l('pad_delete_success', $pad)];
    } else {
        $info = ['alert-error', $self->l('pad_delete_notfound', $pad)];
    }

    my $pads = $ep->list_all_pads();

    $self->render(
        template => 'admin/index',
        pads     => $pads,
        info     => $info
    );
}

1;
