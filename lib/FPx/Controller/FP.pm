package FPx::Controller::FP;
use Mojo::Base 'Mojolicious::Controller';

use FPx::Schema;
use uni::perl ':dumper';
use utf8;

my $schema = FPx::Schema->connect(
	'dbi:mysql:database=fpx', 'root', '',
	{ AutoCommit => 1, quote_names => 1,
      mysql_enable_utf8 => 1, }
);

# This action will render a template
sub add {
  	my $self = shift;

	my $date = $self->stash('date') || 'noname';
	my $sum = $self->stash('sum') || 0;

  	# Render template "example/welcome.html.ep" with message
  	$self->render(template => 'inc/main', msg => 'Welcome!', title => 'Welcome');
}

1;
