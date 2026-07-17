#!/usr/bin/perl

use strict;
use warnings;
use feature 'signatures';

my $mode;

sub usage() {
    print "mk-sound-vars.pl <bash|fish> : generate appropriate variable declarations holding base64 cue sounds\n";
}

sub file2base64($path) {
    my $r;
    $r = qx(base64 $path);
    $r =~ s/\n//g;
    return $r;
}

if (scalar @ARGV != 1) {
    usage;
    exit 1;
}

if ($ARGV[0] eq 'bash'
or  $ARGV[0] eq 'fish') {
    $mode = $ARGV[0];
} else {
    usage;
    exit 2;
}

my $hit_sound   = file2base64("data/tf2-hit-cue-compressed.mp3");
my $error_sound = file2base64("data/windows-7-error-cue.mp3");

if ($mode eq 'bash') {
    print ""
        . "__THM_HIT_SOUND='$hit_sound'\n"
        . "__THM_ERROR_SOUND='$error_sound'\n"
    ;
} elsif ($mode eq 'fish') {
    print ""
        . "set -g __thm_hit_sound   '$hit_sound'\n"
        . "set -g __thm_ERROR_SOUND '$error_sound'\n"
    ;
}
