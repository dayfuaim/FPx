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
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 sum

  data_type: 'double precision'
  is_nullable: 1

=head2 comment

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "date",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 0 },
  "sum",
  { data_type => "double precision", is_nullable => 1 },
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

=head2 category_payments

Type: has_many

Related object: L<FPx::Schema::Result::CategoryPayment>

=cut

__PACKAGE__->has_many(
  "category_payments",
  "FPx::Schema::Result::CategoryPayment",
  { "foreign.payment_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-04-18 00:33:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Oc3TlNKiMExiT14eCckZeg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
