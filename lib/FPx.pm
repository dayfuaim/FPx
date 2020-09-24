package FPx;
use uni::perl ':dumper';
use Mojo::Base 'Mojolicious';

use Mojo::Message::Request;

# use FPx::Model;    # <-- подключаем модуль с моделью
use FPx::Controller::FP;

use DDP;

# This method will run once at server start
sub startup {
	my $self = shift;

    my $app = $self->app;
    my $log = $app->log;

    $log->debug("================ START ================");
    # my $log = Mojo::Log->new(path => './mojo.log', level => 'warn');

    # >>>>>> PLUGINS
    $self->plugin('BasicAuthPlus');
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

    # <<<<<< //HELPERS

    # Log messages
    # $log->debug('Not sure what is happening here');
    # $log->info('FYI: it happened again');
    # $log->warn('This might be a problem');
    # $log->error('Garden variety error');
    # $log->fatal('Boom');

    $app->hook(before_routes => sub {
        my $c = shift;
        $log->info("BEFORE ROUTES");
    });

	# Router
	my $r = $self->routes;

    $r->add_condition(
        isAuth => sub {
            my ($route, $c, $captures, $pattern) = @_;
            my ($hash_ref, $auth_ok) = $c->basic_auth(
                "My Realm" => {
                    username => 'dayfuaim',
                    password => 'tGP$qa.+At'
                }
            );
            return $auth_ok;
        }
    );

    $r = $r->over(isAuth => 1);

	# Normal routes to controller
	$r->get('/')->to('example#welcome');
	$r->get('/new')->to('payment#form');

    $r->post('/payment/add')->to('payment#add');

    $r->get('/category/fpcat/:cat')->to('category#fpcat');
	$r->get('/category/:id')->to('category#item');

    $r->get('/fpcategory/:fpid/:catid')->to('fpcategory#get');
    $r->post('/fpcategory/add')->to('fpcategory#add');

    # TODO: REST part (MAYBE)... Probably not. :(
}

1;
