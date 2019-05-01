package FPx::Model::Payment;
use Mojo::Base 'MojoX::Model';
use uni::perl qw(:dumper);
use utf8;

use FPx::Schema;

my $schema = FPx::Schema->connect(
	'dbi:pg:database=fpx', 'dayfuaim', '',
	{ AutoCommit => 1, quote_names => 1 }
);

sub add_pay {
	my $self = shift;
	my ($date, $sum, $comment) = @_;
	my $pay_id = $schema->resultset('Payment')->create({
		date => $date,
		sum => $sum,
		comment => $comment
	})->id;
	return $pay_id
}

1;
