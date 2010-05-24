package Net::Douban::DBSubject;
BEGIN {
  $Net::Douban::DBSubject::VERSION = '1.06_1';
}

use Moose;
extends 'Net::Douban::Entry';

sub BUILD {
    my $self = shift;
    print "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
    $self->ns($self->namesapce->{main});
}

1;
