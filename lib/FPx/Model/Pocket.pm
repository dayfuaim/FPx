package FPx::Model::Pocket;
use Mojo::Base 'MojoX::Model';
use uni::perl qw(:dumper);
use utf8;

use FPx::Schema;

my $schema = FPx::Schema->connect(
	'dbi:Pg:dbname=fpx', 'dayfuaim', '',
	{ AutoCommit => 1, RaiseError => 1 }
);

sub get {
	my $self = shift;
	my $id = shift;

	my @pocket = $schema->resultset('Pocket')->search($id ? { id => $id } : undef, { result_class => 'DBIx::Class::ResultClass::HashRefInflator' })->all;
	# @cat = sort { $a->{sort_order} <=> $b->{sort_order} } @cat unless $id;
	return $id ? @pocket : \@pocket
}

1;
