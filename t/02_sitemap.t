use Test::More tests => 10, import => ['!pass'];
use Dancer ':syntax';
use Dancer::Test;

use_ok 'Dancer::Plugin::SiteMap';

setting views => path('t', 'views');

ok(
    get '/route-1' => sub {
        template 'index', { };
    });
ok(
    get '/route-2' => sub {
        #flash(error => 'plop');
        template 'index', { foo => 'bar' };
    });


# we have added two routes
my @routes = ('/sitemap', '/sitemap.xml', '/route-1', '/route-2');
foreach my $route (@routes) {
	route_exists [ GET => '/sitemap' ], "route $route exist";	
}

## empty route
#route_exists [ GET => '/nothing' ];
#response_content_like( [ GET => '/nothing' ], qr/foo :\s*, message :\s*$/ );
#
## first time we get the error message
#route_exists [ GET => '/' ];
#response_content_like( [ GET => '/' ], qr/foo : bar, message : plop$/ );
## second time the error has disappeared
#route_exists [ GET => '/different' ];
#response_content_like( [ GET => '/different' ], qr/foo : bar, message : \s*$/ );

