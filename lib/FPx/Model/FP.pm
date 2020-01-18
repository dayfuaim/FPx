package FPx::Model::FP;
use Mojo::Base 'MojoX::Model';
use uni::perl qw(:dumper);
use Date::Calc qw(:all);

use FPx::Schema;

my $schema = FPx::Schema->connect(
	'dbi:Pg:dbname=fpx', 'dayfuaim', '',
	{ AutoCommit => 1, RaiseError => 1 }
);

sub current {
	my $self = shift;
	my $fp = $schema->resultset('Fp')->search({
			date_out => { '>=', \'NOW() - interval \'24 hours\'' },
			date_in => { '<=', \'NOW()' },
		},{
			order_by => { -desc => 'date_out' },
			# result_class => 'DBIx::Class::ResultClass::HashRefInflator'
		})->first;
	unless ($fp) {
		$fp = $self->add()
	}

	return $fp
}

sub add {
	my $self = shift;
	my $fp;
	my $last_dt = $schema->resultset('Fp')->search({
			date_out => { '<', \'NOW()' }
		},
		{
			order_by => { -desc => 'date_out' }
		})->get_column('date_out')->first;
	say ">>>> WAS date_out: ".dumper($last_dt);
	if ($last_dt) {
		$last_dt = join '-', Add_Delta_Days(split(/-/=>$last_dt), 1);
		say ">>>> date_in: ".dumper($last_dt);
		my $last_last_dt = join '-', Add_Delta_Days(split(/-/=>$last_dt), 13);
		say ">>>> date_out: ".dumper($last_last_dt);
		$fp = $schema->resultset('Fp')->create({ date_in => $last_dt, date_out => $last_last_dt, sum_total => 0 },{ result_class => 'DBIx::Class::ResultClass::HashRefInflator' });
	}
	return $fp
}

sub all {
	my $self = shift;
	my @fp = $schema->resultset('Fp')->search(undef, { result_class => 'DBIx::Class::ResultClass::HashRefInflator' })->all();
	return \@fp
}

sub all_planned {
	my $self = shift;
	my $fp_current = $self->current();
	my @fp = $schema->resultset('FpCategory')->search(
		{
			fp_id => $fp_current->{id},
		},
		{
			columns => [
				'category_id', { sum => \[ 'SUM(sum)' ], },
			],
			group_by => [qw/category_id/],
			# result_class => 'DBIx::Class::ResultClass::HashRefInflator',
		})->all();
	my @fpc;
	foreach my $f (@fp) {
		push @fpc => {
			fp_id => $fp_current,
			category_id => $f->category_id,
			name => $f->related_resultset('category')->find($f->category_id)->get_column('name'),
			sum => $f->sum,
		};
	}
	return \@fpc
}

1;
