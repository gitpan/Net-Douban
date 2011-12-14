
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Perl client wrapper for Chinese website douban.com API",
  "AUTHOR" => "woosley.xu",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Net-Douban",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Net::Douban",
  "PREREQ_PM" => {
    "HTTP::Request" => 0,
    "HTTP::Request::Common" => 0,
    "JSON::Any" => "1.29",
    "LWP::UserAgent" => 0,
    "Moose" => "2.0007",
    "MooseX::StrictConstructor" => "0.16",
    "MooseX::Traits" => 0,
    "Net::OAuth" => 0,
    "Scalar::Util" => 0,
    "Test::More" => 0,
    "URI" => 0
  },
  "VERSION" => "1.14",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



