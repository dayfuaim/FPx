use utf8;
package FPx::Schema::Result::Pocket;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FPx::Schema::Result::Pocket

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<pockets>

=cut

__PACKAGE__->table("pockets");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'pockets_id_seq'

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 sum

  data_type: 'numeric'
  default_value: 0.00
  is_nullable: 0
  size: [9,2]

=head2 goal

  data_type: 'numeric'
  default_value: 0.00
  is_nullable: 0
  size: [9,2]

=head2 accum

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 to_date

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "pockets_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 64 },
  "sum",
  {
    data_type => "numeric",
    default_value => "0.00",
    is_nullable => 0,
    size => [9, 2],
  },
  "goal",
  {
    data_type => "numeric",
    default_value => "0.00",
    is_nullable => 0,
    size => [9, 2],
  },
  "accum",
  { data_type => "boolean", default_value => \"false", is_nullable => 0 },
  "to_date",
  { data_type => "timestamp", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 category_pockets

Type: has_many

Related object: L<FPx::Schema::Result::CategoryPocket>

=cut

__PACKAGE__->has_many(
  "category_pockets",
  "FPx::Schema::Result::CategoryPocket",
  { "foreign.pocket_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-05-15 21:46:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uT7/1vrD3Pja9bpDvxLLvg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
