package Net::Douban;
our $VERSION = '1.06';

use Moose;
use Carp qw/carp croak/;

with 'Net::Douban::Roles';

#my $oauth;    ## magic global variable
## use this to enable globle value
#sub oauth {
#    my $self = shift;
#    if (@_) {
#        $oauth = shift;
#        return \$oauth;
#    } else {
#        return \$oauth;
#    }
#}

#around 'oauth' => sub {
#    my $orig = shift;
#    my $self = shift;
#    if(@_){
#        $oauth = shift;
#        return \$oauth;
#    }else{
#        return \$oauth;
#    }
#};

our $AUTOLOAD;

sub AUTOLOAD {

#    my $self = shift;     ### shift @_ is terribly wrong
    (my $name = $AUTOLOAD) =~ s/.*:://g;
    return if $name eq 'DESTORY';
    if (grep {/^$name$/}
        qw/User Note Tag Collection Recommendation Event Review Subject Doumail Miniblog OAuth/
      )
    {
        my $sub = <<"SUB";
        sub $name {
            my \$self = shift;

              if (\$self->{$name}) {
                return \$self->{$name};
            } else {
                my \$class = "Net::Douban::$name";
                eval "require \$class";
                my \$obj = "Net::Douban::$name"->new(\$self->args, \@_,);
                \$self->{$name} = \$obj;
                return \$obj;
            }
          }
SUB
        eval($sub);
        goto &$name;
    }
    croak "Unknow Method!";
}

sub DESTORY { }

#deprecated in order to keep it simple
#around 'BUILDARGS' => sub {
#    my $orig = shift;
#    my $self = shift;
#    my %args = @_;
#    my $auth = delete $args{oauth} if exists $args{oauth};
#    $oauth = $auth;
#    $self->$orig(%args);
#};
#
no Moose;
__PACKAGE__->meta->make_immutable;

1;
__END__

=pod

=head1 NAME

Net::Douban - Perl client for douban.com

=head1 VERSION

version 1.06

=head1 SYNOPSIS
    
    use Net::Douban;
    use Net::Douban::OAuth;
    my $consumer = Net::Douban::OAuth->new(...);
    # do authenticate 
    $consumer->request_token;
    $consumer->access_token;

    my $client = Net::Douban->new( oauth =>$consumer);

    my $atom = $client->User(userID => 'Net-Douban')->get_user;
    print $atom->id;
    ....

=head1 DESCRIPTION

Net::Douban is a perl client wrapper on the Chinese website 'Douban.com' API.

=head1 METHODS

=over

=item B<new>

    $client = Net::Douban->new(oauth => $consumer, apikey => $key);

=item B<Auto-Generated Objects>
    
    #Net::Douba::User object
    $client->User;

    #Net::Douban::Event object
    $client->Event;
    ...

Auto-generated objects include: B<User Note Tag Collection Recommendation Event Review Subject Doumail Miniblog OAuth>

=back

=head1 Website data Access

Generally an apikey is required for you to access the douban.com service. Goto L<http://www.douban.com/service/apikey/> for an apikey

If you want to access some private or so called protected data, you have to use a authenticated oauth object, which has basic implements on the HTTP methods just like "GET POST PUT DELETE", to access the protected data,  L<Net::Douban::OAuth> can do this for you. Goto L<http://www.douban.com/service/apidoc/auth> for more douban.com OAuth document.

=head2 We don't generate XML for you
    
If you want to post data to some page. Net::Douban::* can do the basic POST/DELETE/PUT works, but it won't generate any XML for you, so you have to call those methods with a (xml => $XML) argument;

=head1 SEE ALSO
    
L<Net::Douban> L<Net::Douban::Atom> L<Net::Douban::OAuth> L<Moose> L<XML::Atom> L<http://douban.com/service/apidoc>

=head1 AUTHOR

woosley.xu<redicaps@gmail.com>

=head1 COPYRIGHT & LICENSE

This software is copyright (c) 2010 by woosley.xu.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
