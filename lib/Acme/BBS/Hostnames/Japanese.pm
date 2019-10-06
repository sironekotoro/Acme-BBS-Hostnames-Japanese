package Acme::BBS::Hostnames::Japanese;
use 5.008001;
use strict;
use warnings;

use Carp qw/croak/;
use File::Spec;
use File::Basename 'dirname';
use HTTP::Tiny qw/get/;
use lib (
    File::Spec->catdir( dirname(__FILE__), qw/.. lib/ ),
    File::Spec->catdir( dirname(__FILE__), qw/.. local lib perl5/ ),
);
use List::Util qw/uniq/;
use Regexp::Assemble qw/new add re/;
use URI qw/new/;

our $VERSION = '0.01';
use Data::Dumper;

sub new {
    my $class    = shift;
    my $bbs_name = shift;
    my $self     = bless { bbs_name => $bbs_name }, $class;

    return $self;
}

sub bbs_name {
    my $self = shift;

    return $self->{bbs_name};
}

sub hostnames {
    my $self = shift;
    if ( $self->bbs_name eq '2ch' ) {
        return $self->_2ch_sc();
    }
    elsif ( $self->bbs_name eq '5ch' ) {
        return $self->_5ch_net();
    }
    elsif ( $self->bbs_name eq 'open2ch' ) {
        return $self->_open2ch_net();
    }
}

sub regex_str {
    my $self = shift;

    my $ra = Regexp::Assemble->new;

    for my $hostname ( $self->hostnames ) {
        $ra->add($hostname);
    }

    return $ra->re;

}

sub _2ch_sc {
    my $self = shift;

    my $url = URI->new('https://www.2ch.sc/bbsmenu.html');
    my $res = HTTP::Tiny->new()->get($url);

    croak "Failed!\n" unless $res->{success};

    my %hash = ();
    while ( $res->{content} =~ m|https?://(?<url>.+?\.2ch\.sc)|g ) {
        $hash{ $+{url} }++;
    }

    # Eliminate duplicate host names
    my @array = sort keys %hash;

    return wantarray ? @array : \@array;

}

sub _5ch_net {
    my $self = shift;

    # 5ch.net
    my $url = URI->new('https://menu.5ch.net/bbstable.html');
    my $res = HTTP::Tiny->new()->get($url);

    croak "Failed!\n" unless $res->{success};

    my %hash = ();
    while ( $res->{content} =~ m|https?://(?<url>.+?\.5ch\.net)|g ) {
        $hash{ $+{url} }++;
    }

    # Eliminate duplicate host names
    my @array = sort keys %hash;

    return wantarray ? @array : \@array;
}

sub _open2ch_net {
    my $self = shift;

    # open2ch.net
    my $url = URI->new('https://open2ch.net/menu/pc_menu.html');
    my $res = HTTP::Tiny->new()->get($url);

    croak "Failed!\n" unless $res->{success};

    my %hash = ();
    while ( $res->{content} =~ m|https?://(?<url>.+?\.open2ch\.net)|g ) {
        $hash{ $+{url} }++;
    }

    # Eliminate duplicate host names
    my @array = sort keys %hash;

    return wantarray ? @array : \@array;
}

1;
__END__

=encoding utf-8

=head1 NAME

Acme::BBS::Hostnames::Japanese - hogeList the host names of famous Japanese bulletin boards

=head1 SYNOPSIS

    use Acme::BBS::Hostnames::Japanese;

    # Create an instance
    # Input one of the following three arguments
    #   2ch
    #   5ch
    #   open2ch
    my $obj = Acme::BBS::Hostnames::Japanese->new('2ch');

    my @array = $obj->hostnames;
    print "@array";         # Returns hostname
                            # ai.2ch.sc anago.2ch.sc awabi.2ch.sc ...

    print $obj->regex_str;  # Returns regular expression
                            # (?^:(?:t(?:o(?:mcat|ro)|arte)|a(?:(? ...

=head1 DESCRIPTION

Acme::BBS::Hostnames::Japanese  was created for practice and my work.

Corresponds to three famous bulletin boards in Japan.

=over

=item L<2ch|https://www.2ch.sc>

=item L<5ch|https://5ch.net>

=item L<open2ch|https://open2ch.net>

=back

=head1 LICENSE

Copyright (C) sironekotoro.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

sironekotoro E<lt>develop@sironekotoro.comE<gt>

=cut

