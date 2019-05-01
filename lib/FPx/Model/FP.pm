package FPx::Model::FP;
use Mojo::Base 'MojoX::Model';
use uni::perl qw(:dumper);
use Date::Calc qw(:all);

use FPx::Schema;

my $schema = FPx::Schema->connect(
	'dbi:pg:database=fpx', 'dayfuaim', '',
	{ AutoCommit => 1, quote_names => 1 }
);

sub current {
	my $self = shift;
	my $fp = $schema->resultset('Fp')->search({
			date_in => { '<=', \'NOW()' },
			date_out => { '>=', \'NOW()' },
		},
		{ result_class => 'DBIx::Class::ResultClass::HashRefInflator' })->first;
	unless ($fp) {
		$fp = $self->add()
	}

	return $fp
}

sub add {
	my $self = shift;
	my $last_dt = $schema->resultset('Fp')->search({
			date_out => { '<', \'NOW()' }
		})->get_column('date_out')->first;
	say ">>>> date_out: ".dumper($last_dt);
	$last_dt = join '-', Add_Delta_Days(split(/-/=>$last_dt), 1);
	say ">>>> date_out: ".dumper($last_dt);
	my $fp = $schema->resultset('Fp')->create({ date_in => $last_dt, sum_total => 0 },{ result_class => 'DBIx::Class::ResultClass::HashRefInflator' });
	return $fp
}

1;
