package FPx::Model::Category;
use Mojo::Base 'MojoX::Model';
use uni::perl qw(:dumper);

use DDP;

use FPx::Schema;

my $schema = FPx::Schema->connect(
	'dbi:Pg:dbname=fpx', 'dayfuaim', '',
	{ AutoCommit => 1, RaiseError => 1 }
);

sub get {
	my $self = shift;
	my $id = shift;

	my @cat = $schema->resultset('Category')->search($id ? { id => $id } : { sort_order => { '>=' => 0 } }, { order_by => { -asc => 'me.sort_order' }, result_class => 'DBIx::Class::ResultClass::HashRefInflator' })->all;
    p @cat;
    @cat = sort { $a->{sort_order} <=> $b->{sort_order} } @cat unless $id;
	return $id ? @cat : \@cat
}

1;
