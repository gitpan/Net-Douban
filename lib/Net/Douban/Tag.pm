package Net::Douban::Tag;

BEGIN {
    $Net::Douban::Tag::VERSION = '1.07';
}

use Moose;
use MooseX::StrictConstructor;
use Net::Douban::Atom;
use Carp qw/carp croak/;
with 'Net::Douban::Roles::More';

sub get_movie_tag {
    my ($self, %args) = @_;
    croak "subjectID needed" unless exists $args{subjectID};
    return Net::Douban::Atom->new(
        $self->get($self->base_url . "/movie/subject/$args{subjectID}/tags"));
}

sub get_book_tag {
    my ($self, %args) = @_;
    croak "subjectID needed" unless exists $args{subjectID};
    return Net::Douban::Atom->new(
        $self->get($self->base_url . "/book/subject/$args{subjectID}/tags"));
}

sub get_music_tag {
    my ($self, %args) = @_;
    croak "subjectID needed" unless exists $args{subjectID};
    return Net::Douban::Atom->new(
        $self->get($self->base_url . "/music/subject/$args{subjectID}/tags"));
}

sub get_tag {
    my ($self, %args) = @_;
    my $uid = delete $args{userID} or croak "userID needed";
    croak "cat needed" unless exists $args{cat};
    return Net::Douban::Atom->new(
        $self->get($self->user_url . "/$args{userID}/tags", %args));
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
__END__
