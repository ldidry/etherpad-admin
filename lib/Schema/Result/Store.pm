use utf8;
package Schema::Result::Store;

=head1 NAME

Schema::Result::Store

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<store>

=cut

__PACKAGE__->table("store");

=head1 ACCESSORS

=head2 key

  data_type: 'varchar'
  is_nullable: 0

=head2 value

  data_type: 'longtext'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
    "key",
    { data_type => "varchar", is_nullable => 0 },
    "value",
    { data_type => "longtext", is_nullable => 0 }
);

=head1 PRIMARY KEY

=over 4

=item * L</key>

=back

=cut

__PACKAGE__->set_primary_key("key");

1;
