package Net::Douban::User;
{
    $Net::Douban::User::VERSION = '1.14';
}

use Moose::Role;
use Carp qw/carp croak/;
use Net::Douban::Utils;
use namespace::autoclean;

douban_method 'get_user' => {
    has_url_param => 'userID',
    path          => '/people/{userID}',
    method        => 'GET'
};

douban_method 'get_user_contacts' => {
    has_url_param   => 'userID',
    path            => '/people/{userID}/contacts',
    optional_params => [qw/start-index max-results/],
    method          => 'GET',
};

douban_method 'get_user_friends' => {
    has_url_param   => 'userID',
    path            => '/people/{userID}/friends',
    optional_params => [qw/start-index max-results/],
    method          => 'GET',
};

douban_method 'search_user' => {
    params          => 'q',
    path            => '/people',
    method          => 'GET',
    optional_params => [qw/start-index max-results/],
};

douban_method 'me' => {path => '/people/%40me', method => 'GET'};

1;

__END__

=pod

=head1 NAME

Net::Douban::User

=head1 VERSION

version 1.14

=head1 SYNOPSIS

    my $c = Net::Douban->new('Roles' => 'User');
    
=head1 DESCRIPTION

Interface to douban.com API User section

=head1 METHODS

=over

=item B<get_user>

argument:   userID
=item B<get_user_contacts>

argument:   userID

=item B<get_user_friends>

argument:   userID

=item B<search_user>

argument:   userID

=item B<me>

=back

=head1 SEE ALSO

L<Net::Douban> L<Moose> B<http://www.douban.com/service/apidoc/reference/user>

=head1 AUTHOR

woosley.xu <woosley.xu@gmail.com>

=head1 COPYRIGHT
	
Copyright (C) 2010 - 2011 by Woosley.Xu

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.

=cut
