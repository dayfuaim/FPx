package FPx;
use uni::perl ':dumper';
use Mojo::Base 'Mojolicious';

# use FPx::Model;    # <-- подключаем модуль с моделью
use FPx::Controller::FP;


# This method will run once at server start
sub startup {
	my $self = shift;

	# >>>>>> PLUGINS
	$self->plugin('Model'
	# 	, {
	# 	params => {
	# 		DBI => { dsn => 'dbi:mysql:mydb', username => 'root', password => '', options => { AutoCommit => 1, quote_names => 1, mysql_enable_utf8 => 1 } }
	# 	}
	# }
	);
	# TODO: Сделать здесь настройки БД.
	$self->plugin('TemplateToolkit');
	$self->plugin('Renderer::WithoutCache');
	$self->renderer->default_handler('tt2');

	# Load configuration from hash returned by "my_app.conf"
	my $config = $self->plugin('Config', {file => 'fpx.conf'});

	# <<<<<< //PLUGINS

	# >>>>> HELPERS
    # $self->helper(fp => sub { FPx::Controller::FP->new() });

    # <<<<<< //HELPERS

	# Router
	my $r = $self->routes;

	# Normal routes to controller
	$r->get('/')->to('example#welcome');
	$r->get('/new')->to('payment#form');
	$r->post('/payment/add')->to('payment#add');
    $r->get('/category/fpcat/:cat')->to('category#fpcat');
	$r->get('/category/:id')->to('category#item');
}

1;
