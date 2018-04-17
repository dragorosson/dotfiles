#!/usr/bin/perl

=head1 NAME

vipe - edit pipe

=head1 SYNOPSIS

command1 | B<vipe> [...] | command2

=head1 DESCRIPTION

vipe allows you to run your editor in the middle of a unix pipeline and
edit the data that is being piped between programs. Your editor will
have the full data being piped from command1 loaded into it, and when you
save, that data will be piped into command2.

Any extra arguments are passed as arguments to the editor.

=head1 ENVIRONMENT VARIABLES

=over 4

=item EDITOR

Editor to use.

=item VISUAL

Also supported to determine what editor to use.

=back

=head1 AUTHOR

Copyright 2006 by Joey Hess <joey@kitenet.net>

Licensed under the GNU GPL.

=cut

use warnings;
use strict;
use File::Temp q{tempfile};

$/=undef;

my ($fh, $tmp)=tempfile();
die "cannot create tempfile" unless $fh;
print ($fh <STDIN>) || die "write temp: $!";
close $fh;
close STDIN;
open(STDIN, "</dev/tty") || die "reopen stdin: $!";
open(OUT, ">&STDOUT") || die "save stdout: $!";
close STDOUT;
open(STDOUT, ">/dev/tty") || die "reopen stdout: $!";

my @editor="vi";
if (-x "/usr/bin/editor") {
        @editor="/usr/bin/editor";
}
if (exists $ENV{EDITOR}) {
        @editor=split(' ', $ENV{EDITOR});
}
if (exists $ENV{VISUAL}) {
        @editor=split(' ', $ENV{VISUAL});
}
my $ret=system(@editor, @ARGV, $tmp);
if ($ret != 0) {
        die "@editor exited nonzero, aborting\n";
}

open (IN, $tmp) || die "$0: cannot read $tmp: $!\n";
print (OUT <IN>) || die "write failure: $!";
close IN;
unlink($tmp);
