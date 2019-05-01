package FPx::Controller::Payment;
use Mojo::Base 'Mojolicious::Controller';

use uni::perl ':dumper';
use utf8;
use DateTime;
use FPx::Schema;

my $schema = FPx::Schema->connect(
	'dbi:mysql:database=fpx', 'root', '',
	{ AutoCommit => 1, quote_names => 1,
      mysql_enable_utf8 => 1, }
);

# Just input FORM
sub form {
  	my $self = shift;
	$self->stash(cats => $self->model("Category")->get());
	$self->render(template => 'inc/in_form')
}

# This action will render a template
sub add {
  	my $self = shift;

	my $date = $self->param('date');
	if ($date =~ /^(\d{1,2})\.(\d{1,2})\.(\d{4})$/) {
		$date = sprintf("%4d-%02d-%02d",$3,$2,$1)
	} else {
		$date = DateTime->now->ymd;
	}
	my $sum = $self->param('sum');
	my $comment = $self->param('comment');
	my $cat_id = $self->param('cat_id');

	$sum =~ s/[^0-9.]//g;
	$sum //= 0;

	my $pay_id = $self->model('Payment')->add_pay($date, $sum, $comment);
	my $catpay = $schema->resultset('CategoryPayment')->update_or_create({
		payment_id => $pay_id,
		category_id => $cat_id,
	})->id;

  	# Render JSON
  	$self->render(json => { catpay_id => $catpay, pay_id => $pay_id, date => $date, sum => $sum, comment => $comment });
}

1;
