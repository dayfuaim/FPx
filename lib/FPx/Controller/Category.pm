package FPx::Controller::Category;
use Mojo::Base 'Mojolicious::Controller';

use FPx::Schema;
use FPx::Model::FP;
use FPx::Model::Category;
use FPx::Model::Payment;
use JSON;

use uni::perl ':dumper';
use utf8;
use DDP;

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

sub fpcat {
    my $self = shift;

    my $fp_curr = $self->model("FP")->current();
	my $cat_id = $self->stash('cat');

    my @fp_pay = $schema->resultset('FpPayment')->search(
		{
			fp_id => $fp_curr->id,
            category_id => $cat_id
		})->all;

    my @fpp;
    foreach my $p (@fp_pay) {
        my $pay = $p->payment;
        my $dt = $pay->date;
        push @fpp => {
            id => $p->id,
            date => qq{$dt},
            sum => sprintf("%.2f", $pay->sum),
            comment => $pay->comment
        }
    }
    @fpp = sort { $a->{date} cmp $b->{date} || $a->{id} <=> $b->{id} } @fpp;

    $self->render(json => {
        fp_curr => $fp_curr->id,
        cat_id => $cat_id,
        fp_pay => \@fpp
    });

}

1;
