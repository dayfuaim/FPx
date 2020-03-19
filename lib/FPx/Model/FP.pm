package FPx::Model::FP;
use Mojo::Base 'MojoX::Model';
use uni::perl qw(:dumper);
use Date::Calc qw(:all);

use DDP;

use FPx::Schema;

my $schema = FPx::Schema->connect(
	'dbi:Pg:dbname=fpx', 'dayfuaim', '',
	{ AutoCommit => 1, RaiseError => 1 }
);

sub current {
	my $self = shift;
	say ">> current";
	my $fp = $schema->resultset('Fp')->search({
			date_out => { '>=', \'NOW() - interval \'24 hours\'' },
			date_in => { '<=', \'NOW()' },
		},{
			order_by => { -desc => 'date_out' },
			# result_class => 'DBIx::Class::ResultClass::HashRefInflator'
		})->first;
	unless ($fp) {
		say "[FP::current] Adding new FP.";
		$fp = $self->add()
	}
    # my @cats = $schema->resultset('Category')->all;
    # p @cats;
    say "[FP::Current] ".$fp->id;
    say "... REF: ". ref $fp->date_in;
    say "current >>";
	return $fp
}

sub add {
	my $self = shift;
	my $fp;
	my $last_last_dt;
	# Пытаемся найти последний день последнего ФП
	my $last_dt = $schema->resultset('Fp')->search({
			date_out => { '<', \'NOW()' }
		},
		{
			order_by => { -desc => 'date_out' }
		})->get_column('date_out')->first;
	say ">>>> WAS date_out: ".dumper($last_dt);
	if ($last_dt) {
		$last_dt = join '-', Add_Delta_Days(split(/-/ => $last_dt), 1);
		say ">>>> date_in: ".dumper($last_dt);
		$last_last_dt = join '-', Add_Delta_Days(split(/-/ => $last_dt), 13);
		say ">>>> date_out: ".dumper($last_last_dt);
	} else {
		# Если таких нет, то откатимся до ближайшего четверга и создадим ФП от него.
		my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime;
		# NB: wday = 0(7) в воскресенье, т.е. воскресенье = (четверг(3) + 4) % 7
		# [ 3,  4,  5,  6,  0,  1,  2 ]
		# [ 0, -1, -2, -3, -4, -5, -6 ]
		my $back_days = $wday - 3;
		$last_dt = join '-', Add_Delta_Days(($year + 1900, $mon + 1, $mday), $back_days);
		say ">>>> date_in: ".dumper($last_dt);
		$last_last_dt = join '-', Add_Delta_Days(split(/-/ => $last_dt), 13);
		say ">>>> date_out: ".dumper($last_last_dt);
	}
	$fp = $schema->resultset('Fp')->create({ date_in => $last_dt, date_out => $last_last_dt, sum_total => 0 },{ result_class => 'DBIx::Class::ResultClass::HashRefInflator' });
    $schema->storage->debug(1);
    my @cats = $schema->resultset('Category')->search(undef, { result_class => 'DBIx::Class::ResultClass::HashRefInflator' })->all();
    foreach my $cat (@cats) {
        $schema->resultset('FpCategory')->create({fp_id => $fp->id, category_id => $cat->id, sum => 0});
    }
    $schema->storage->debug(0);
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
    # $schema->storage->debug(1);
	my @fp = $schema->resultset('FpCategory')->search(
		{
			fp_id => $fp_current->id,
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
        my $cat = $f->related_resultset('category')->find($f->category_id);
        my $sort = $cat->get_column('sort_order');
        next if $sort == -1;
		push @fpc => {
			fp_id => $fp_current,
			category_id => $f->category_id,
			name => $cat->get_column('name'),
			sum => $f->sum,
            sort_order => $sort,
		};
	}
    @fpc = sort { $a->{sort_order} <=> $b->{sort_order} } @fpc;
	return \@fpc
}

1;
