use lib './t/lib';
use Test::Douban;
use Test::More 'tests' => 6;
use Test::Exception;

BEGIN {
    use_ok("Net::Douban");
}

my $saying = Net::Douban->init(Roles => 'Miniblog');
isa_ok($saying, 'Net::Douban');

can_ok($saying, 'get_user_miniblog');

SKIP: {
    skip 'set $ENV{NETWORK_TEST} to enable network tests', 3
      unless $ENV{NETWORK_TEST};
    $saying->res_callback(sub {shift});
    $saying->load_token(%{pdakeys()});

    is($saying->get_user_miniblog(userID => 'Net-Douban')->is_success,
        1, "get saying");

    is( $saying->post_miniblog(
            content => "test net-douban at " . scalar localtime(time),
          )->is_success,
        1,
        'post saying',
    );
    is( $saying->delete_miniblog(miniblogID => 1)->status_line,
        '401 Unauthorized',
        "bad request delete miniblog",
    );
}
