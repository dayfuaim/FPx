package FPx::Model::FP;
use Mojo::Base 'MojoX::Model';
use uni::perl qw(:dumper);
use Date::Calc qw(:all);

use DDP;

use FPx::Schema;

my $schema = FPx::Schema->connect('dbi:Pg:dbname=fpx', 'dayfuaim', '', {AutoCommit => 1, RaiseError => 1});

sub current {
    my $self = shift;
    # say ">> current";
    my $fp = $schema->resultset('Fp')->search(
        {
            date_out => {'>=', \'NOW() - interval \'24 hours\''},
            date_in  => {'<=', \'NOW()'},
        },
        {
            order_by => {-desc => 'date_out'},

            # result_class => 'DBIx::Class::ResultClass::HashRefInflator'
        }
    )->first;
    unless ($fp) {
        say "[FP::current] Adding new FP.";
        $fp = $self->add();
    }

    return $fp;
}

sub add {
    my $self = shift;
    my $fp;
    my $last_last_dt;

    # Пытаемся найти последний день последнего ФП
    my $last_dt = $schema->resultset('Fp')->search(
        {
            date_out => {'<', \'NOW()'}
        },
        {
            order_by => {-desc => 'date_out'}
        }
    )->get_column('date_out')->first;
    say ">>>> WAS date_out: " . dumper($last_dt);
    if ($last_dt) {
        $last_dt = join '-', Add_Delta_Days(split(/-/ => $last_dt), 1);
        say ">>>> date_in: " . dumper($last_dt);
        $last_last_dt = join '-', Add_Delta_Days(split(/-/ => $last_dt), 13);
        say ">>>> date_out: " . dumper($last_last_dt);
    }
    else {
        # Если таких нет, то откатимся до ближайшего четверга и создадим ФП от него.
        my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime;

        # NB: wday = 0(7) в воскресенье, т.е. воскресенье = (четверг(3) + 4) % 7
        # [ 3,  4,  5,  6,  0,  1,  2 ]
        # [ 0, -1, -2, -3, -4, -5, -6 ]
        my $back_days = $wday - 3;
        $last_dt = join '-', Add_Delta_Days(($year + 1900, $mon + 1, $mday), $back_days);
        $last_last_dt = join '-', Add_Delta_Days(split(/-/ => $last_dt), 13);
    }
    $last_dt = $self->_normalize_date($last_dt);
    say ">>>> date_in: " . dumper($last_dt);
    $last_last_dt = $self->_normalize_date($last_last_dt);
    say ">>>> date_out: " . dumper($last_last_dt);
    $fp = $schema->resultset('Fp')->create({date_in => $last_dt, date_out => $last_last_dt, sum_total => 0}, {result_class => 'DBIx::Class::ResultClass::HashRefInflator'});
    return $fp;
}

sub _normalize_date {
    my $self = shift;
    my $d = shift;
    my @d = split $d => /-/;
    $d = sprintf "%4d-%02d-%02d", @d
}

sub all {
    my $self = shift;
    my @fp   = $schema->resultset('Fp')->search(undef, {result_class => 'DBIx::Class::ResultClass::HashRefInflator'})->all();
    return \@fp;
}

sub all_planned {
    my $self       = shift;
    my $fp_current = $self->current();

    # $schema->storage->debug(1);
    my @cats = $schema->resultset('Category')->search(undef, {})->all();
    my @fpc;
    foreach my $c (@cats) {
        next if $c->sort_order == -1;
        my $fpc = $schema->resultset('FpCategory')->search(
            {
                fp_id => $fp_current->id,
                category_id => $c->id,
            },
            {
                columns => [ { sum => \['SUM(sum)'] } ],
                group_by => [qw/category_id/],
            }
        )->first();
        my $sum = $fpc ? $fpc->sum : 0;
        push @fpc => {
            fp_id       => $fp_current,
            category_id => $c->id,
            name        => $c->name,
            sum         => $sum, # $fpc->sum,
            sort_order  => $c->sort_order,
        };
    }
    # $schema->storage->debug(0);

    @fpc = sort { $a->{sort_order} <=> $b->{sort_order} } @fpc;
    return \@fpc;
}

1;
