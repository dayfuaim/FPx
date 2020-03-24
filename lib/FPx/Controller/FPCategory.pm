package FPx::Controller::Fpcategory;
use Mojo::Base 'Mojolicious::Controller';

use FPx::Schema;
use FPx::Model::FP;
use FPx::Model::Category;
use uni::perl ':dumper';
use utf8;

use DDP;

my $schema = FPx::Schema->connect(
	'dbi:Pg:dbname=fpx', 'dayfuaim', '',
	{ AutoCommit => 1, RaiseError => 1, }
);

# GET
sub get {
    my $self    = shift;
    my $fp_id   = $self->param('fpid');
    my $cat_id  = $self->param('catid');

    my @fpcat = $schema->resultset('FpCategory')->search(
        {
            fp_id => $fp_id,
            category_id => $cat_id,
        },
        {
            columns  => ['category_id', {sum => \['SUM(sum)'],},],
            group_by => [qw/category_id/],
        }
    )->all();

    my $sum = $fpcat[0]->sum;

    $self->render(json => { sum => sprintf("%.2f", $sum) });

}


# POST
sub add {
    my $self    = shift;
    my $fp_id   = $self->param('fp_id');
    my $cat_id  = $self->param('cat_id');
    my $sum     = $self->param('sum');
    my $comment = $self->param('comment');

    my $result = {};

    if ($fp_id && $cat_id && $sum) {
        my $fpc_ref = $schema->resultset('FpCategory')->create({fp_id => $fp_id, category_id => $cat_id, sum => $sum, comment => $comment});
        $result = {
            cat_id => $cat_id,
            fpc_id => $fpc_ref->id,
        };
    }

    $self->render(json => $result);
}

1;
