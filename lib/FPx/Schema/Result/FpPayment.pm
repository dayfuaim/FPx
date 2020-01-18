use utf8;
package FPx::Schema::Result::FpPayment;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

FPx::Schema::Result::FpPayment - Главная таблица ФП: Платежи по Категориям в текущее ФП.

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

=head1 TABLE: C<fp_payments>

=cut

__PACKAGE__->table("fp_payments");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'fp_payments_id_seq'

=head2 fp_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 category_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 payment_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 pocket_id

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 comment

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 date_in

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "fp_payments_id_seq",
  },
  "fp_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "category_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "payment_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "pocket_id",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "comment",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "date_in",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
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

=head2 payment

Type: belongs_to

Related object: L<FPx::Schema::Result::Payment>

=cut

__PACKAGE__->belongs_to(
  "payment",
  "FPx::Schema::Result::Payment",
  { id => "payment_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-05-15 21:49:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kUTfJ3eitfjLIuTrU8lskQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
