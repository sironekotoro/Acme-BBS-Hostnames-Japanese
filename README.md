# NAME

Acme::BBS::Hostnames::Japanese - hogeList the host names of famous Japanese bulletin boards

# SYNOPSIS

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

# DESCRIPTION

Acme::BBS::Hostnames::Japanese  was created for practice and my work.

Corresponds to three famous bulletin boards in Japan.

- [2ch](https://www.2ch.sc)
- [5ch](https://5ch.net)
- [open2ch](https://open2ch.net)

# LICENSE

Copyright (C) sironekotoro.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

sironekotoro <develop@sironekotoro.com>

# POD ERRORS

Hey! **The above document had some coding errors, which are explained below:**

- Around line 154:

    &#x3d;over should be: '=over' or '=over positive\_number'
