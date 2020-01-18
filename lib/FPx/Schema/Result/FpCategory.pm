use utf8;
package FPx::Schema::Result::FpCategory;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FPx::Schema::Result::FpCategory - Таблица ФП по Категориям: то, что запланировано.

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

=head1 TABLE: C<fp_categories>

=cut

__PACKAGE__->table("fp_categories");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'fp_categories_id_seq'

=head2 fp_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 category_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 sum

  data_type: 'numeric'
  default_value: 0.0
  is_nullable: 0
  size: [9,2]

=head2 comment

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "fp_categories_id_seq",
  },
  "fp_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "category_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "sum",
  {
    data_type => "numeric",
    default_value => "0.0",
    is_nullable => 0,
    size => [9, 2],
  },
  "comment",
  { data_type => "varchar", is_nullable => 1, size => 64 },
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

=head2 fp

Type: belongs_to

Related object: L<FPx::Schema::Result::Fp>

=cut

__PACKAGE__->belongs_to(
  "fp",
  "FPx::Schema::Result::Fp",
  { id => "fp_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-05-15 21:46:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:x9isFEJpnah6vHSu8oSUSA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
