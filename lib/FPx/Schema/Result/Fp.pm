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
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'fps_id_seq'

=head2 date_in

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 date_out

  data_type: 'timestamp'
  is_nullable: 1

=head2 sum_total

  data_type: 'numeric'
  default_value: 0.00
  is_nullable: 0
  size: [9,2]

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "fps_id_seq",
  },
  "date_in",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "date_out",
  { data_type => "timestamp", is_nullable => 1 },
  "sum_total",
  {
    data_type => "numeric",
    default_value => "0.00",
    is_nullable => 0,
    size => [9, 2],
  },
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

=head2 fp_payments

Type: has_many

Related object: L<FPx::Schema::Result::FpPayment>

=cut

__PACKAGE__->has_many(
  "fp_payments",
  "FPx::Schema::Result::FpPayment",
  { "foreign.fp_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-05-15 21:46:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NSlepj58PmYP9mHx3uY5Vg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
