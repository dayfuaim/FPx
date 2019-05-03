package FPx::Controller::Category;
use Mojo::Base 'Mojolicious::Controller';

use FPx::Schema;
use uni::perl ':dumper';
use utf8;

my $schema = FPx::Schema->connect(
	'dbi:Pg:dbname=fpx', 'dayfuaim', '',
	{ AutoCommit => 1, RaiseError => 1, }
);

# This action will render a template
sub list {
	my $self = shift;

	my @cats = $self->model('Category')->get();

	return \@cats
  	# $self->render(json => [ @cats ]);
}

sub item {
  	my $self = shift;
	my $id = $self->stash('id') || 1;
	my $cat = {};
	$id =~ s/\D//g;
	if ($id) {
		$cat = $self->model('Category')->get($id);
	}

  	$self->render(json => $cat);
}

1;
