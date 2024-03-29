package Net::Douban::Tag;
{
    $Net::Douban::Tag::VERSION = '1.14';
}

use Carp qw/carp croak/;
use Moose::Role;
use Net::Douban::Utils;
use namespace::autoclean;

douban_method get_tags => {
    path            => '/{cat}/subject/{subjectID}/tags',
    optional_params => [qw/start-index max-results/],
    method          => 'GET',
    has_url_param   => 1,
};

douban_method get_user_tags => {
    path            => '/people/{userID}/tags?cat={cat}',
    optional_params => [qw/start-index max-results/],
    method          => 'GET',
    has_url_param   => 1,
};

1;
__END__

=pod

=head1 NAME

Net::Douban::Tag

=head1 VERSION

version 1.14

=head1 SYNOPSIS

	my $c = Net::Douban->init(Roles => 'Tag');

=head1 DESCRIPTION

Interface to douban.com API Tag section

=head1 METHODS

=over

=item B<get_tags>

arguments: cat, subjectID

=item B<get_user_tags>

arguments: cat, userID

=back

=head1 SEE ALSO

L<Net::Douban> L<Net::Douban::Traits::Gift> L<Moose> 
B<http://www.douban.com/service/apidoc/reference/tag>

=head1 AUTHOR

woosley.xu <woosley.xu@gmail.com>

=head1 COPYRIGHT
	
Copyright (C) 2010 - 2011 by Woosley.Xu

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.

=cut
