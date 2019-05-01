use utf8;
package FPx::Schema::Result::Fp;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FPx::Schema::Result::Fp

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

=head1 TABLE: C<fps>

=cut

__PACKAGE__->table("fps");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 date_in

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 date_out

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 sum_total

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
  "date_in",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 0 },
  "date_out",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "sum_total",
  { data_type => "double precision", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 fp_categories

Type: has_many

Related object: L<FPx::Schema::Result::FpCategory>

=cut

__PACKAGE__->has_many(
  "fp_categories",
  "FPx::Schema::Result::FpCategory",
  { "foreign.fp_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 fp_incomes

Type: has_many

Related object: L<FPx::Schema::Result::FpIncome>

=cut

__PACKAGE__->has_many(
  "fp_incomes",
  "FPx::Schema::Result::FpIncome",
  { "foreign.fp_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 fp_pockets

Type: has_many

Related object: L<FPx::Schema::Result::FpPocket>

=cut

__PACKAGE__->has_many(
  "fp_pockets",
  "FPx::Schema::Result::FpPocket",
  { "foreign.fp_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-04-18 00:33:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YN80pV4Q+B1ScwC29zF0lw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
