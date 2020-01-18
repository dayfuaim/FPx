package FPx::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';

use FPx::Schema;
use FPx::Model::FP;
use FPx::Model::Category;
use uni::perl ':dumper';
use utf8;

# my $schema = FPx::Schema->connect(
# 	'dbi:mysql:database=fpx', 'root', '',
# 	{ AutoCommit => 1, quote_names => 1,
#       mysql_enable_utf8 => 1, }
# );

# This action will render a template
sub welcome {
  	my $self = shift;

	my $tt = $self->stash('name') || 'noname';
	$self->stash(cats => $self->model("Category")->get());
	$self->stash(pockets => $self->model("Pocket")->get());
	$self->stash(fp_cats => $self->model("FP")->all_planned());
	my $fp_curr = $self->model("FP")->current();
	$self->stash(fp_curr => $fp_curr);

  	# Render template "example/welcome.html.ep" with message
  	$self->render(template => 'inc/main', msg => 'Welcome!', title => 'Welcome');
}

1;
