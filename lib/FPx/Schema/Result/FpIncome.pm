use utf8;
package FPx::Schema::Result::FpIncome;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FPx::Schema::Result::FpIncome

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

=head1 TABLE: C<fp_incomes>

=cut

__PACKAGE__->table("fp_incomes");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 fp_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 income_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
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
  "fp_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "income_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 fp

Type: belongs_to

Related object: L<FPx::Schema::Result::Fp>

=cut

__PACKAGE__->belongs_to(
  "fp",
  "FPx::Schema::Result::Fp",
  { id => "fp_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 income

Type: belongs_to

Related object: L<FPx::Schema::Result::Income>

=cut

__PACKAGE__->belongs_to(
  "income",
  "FPx::Schema::Result::Income",
  { id => "income_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-04-18 00:33:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Ymtl4TG9smynouhnRpcwBA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
