use utf8;
package FPx::Schema::Result::Payment;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FPx::Schema::Result::Payment

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

=head1 TABLE: C<payments>

=cut

__PACKAGE__->table("payments");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'payments_id_seq'

=head2 date

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 sum

  data_type: 'numeric'
  default_value: 0.00
  is_nullable: 1
  size: [9,2]

=head2 comment

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "payments_id_seq",
  },
  "date",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "sum",
  {
    data_type => "numeric",
    default_value => "0.00",
    is_nullable => 1,
    size => [9, 2],
  },
  "comment",
  { data_type => "varchar", is_nullable => 1, size => 128 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 fp_payments

Type: has_many

Related object: L<FPx::Schema::Result::FpPayment>

=cut

__PACKAGE__->has_many(
  "fp_payments",
  "FPx::Schema::Result::FpPayment",
  { "foreign.payment_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-05-15 21:46:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QRSDXg51H3f80ghxxBekPg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
