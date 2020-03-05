use utf8;
package FPx::Schema::Result::Category;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FPx::Schema::Result::Category

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

=head1 TABLE: C<categories>

=cut

__PACKAGE__->table("categories");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'categories_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 sum_planned

  data_type: 'real'
  default_value: 0.0
  is_nullable: 0

=head2 sort_order

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "categories_id_seq",
  },
  "name",
  { data_type => "text", is_nullable => 0 },
  "sort_order",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
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
  { "foreign.category_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 fp_categories

Type: has_many

Related object: L<FPx::Schema::Result::FpCategory>

=cut

__PACKAGE__->has_many(
  "fp_categories",
  "FPx::Schema::Result::FpCategory",
  { "foreign.category_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 fp_payments

Type: has_many

Related object: L<FPx::Schema::Result::FpPayment>

=cut

__PACKAGE__->has_many(
  "fp_payments",
  "FPx::Schema::Result::FpPayment",
  { "foreign.category_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-05-15 21:46:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QByMjR2sbZhQcKMD64ce1w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
