package FPx::Model::Category;
use Mojo::Base 'MojoX::Model';
use uni::perl qw(:dumper);

use FPx::Schema;

my $schema = FPx::Schema->connect(
	'dbi:Pg:database=fpx', 'dayfuaim', '',
	{ AutoCommit => 1, quote_names => 1 }
);

sub get {
	my $self = shift;
	my $id = shift;

	my @cat = $schema->resultset('Category')->search($id ? { id => $id } : undef, { result_class => 'DBIx::Class::ResultClass::HashRefInflator' })->all;
	return $id ? @cat : \@cat
}

1;
