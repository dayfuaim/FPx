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
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'tinytext'
  is_nullable: 0

=head2 sum

  data_type: 'double precision'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "name",
  { data_type => "tinytext", is_nullable => 0 },
  "sum",
  { data_type => "double precision", is_nullable => 0 },
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

=head2 fp_pockets

Type: has_many

Related object: L<FPx::Schema::Result::FpPocket>

=cut

__PACKAGE__->has_many(
  "fp_pockets",
  "FPx::Schema::Result::FpPocket",
  { "foreign.pocket_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-04-18 00:33:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:dVmPhqqpMxSapki5dG/Www


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
