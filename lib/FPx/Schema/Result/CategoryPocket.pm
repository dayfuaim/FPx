use utf8;
package FPx::Schema::Result::CategoryPocket;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FPx::Schema::Result::CategoryPocket - Связка Категорий с Карманами. 1 -> N

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

=head1 TABLE: C<category_pockets>

=cut

__PACKAGE__->table("category_pockets");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'category_pockets_id_seq'

=head2 category_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 pocket_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "category_pockets_id_seq",
  },
  "category_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "pocket_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 category

Type: belongs_to

Related object: L<FPx::Schema::Result::Category>

=cut

__PACKAGE__->belongs_to(
  "category",
  "FPx::Schema::Result::Category",
  { id => "category_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 pocket

Type: belongs_to

Related object: L<FPx::Schema::Result::Pocket>

=cut

__PACKAGE__->belongs_to(
  "pocket",
  "FPx::Schema::Result::Pocket",
  { id => "pocket_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-05-15 21:46:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FHx5CGX5fvmYWC+3mLXpDw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
