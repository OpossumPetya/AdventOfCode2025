use strict;
use warnings;
use feature 'say';

sub slurp_file {
    return do { local(@ARGV, $/) = shift; <> }
}

sub slurp_data {
    return do { local $/; <DATA> }
}

# - invalid ID is made only of some sequence of digits repeated twice
# - none of the numbers have leading zeroes; 0101 isn't an ID at all
sub has_pattern {
    my $id = shift;
    return 0 if $id =~ /^0/;
    return 0 if length($id) % 2 != 0; # an odd number can't be "a sequence repeated twice"

    my $len = length($id) / 2;

    # my @halfs = unpack "(a$len)*", $id;
    # return $halfs[0] == $halfs[1];

    return $id =~ m/^(.{$len})(\1)$/;
}


my $input = slurp_file $ARGV[0];
# my $input = <DATA>;
chomp $input;

my @id_ranges = split ',', $input;
my $invalids_sum = 0;

for my $range (@id_ranges) {
    my ($from, $to) = split '-', $range;

    for my $id ($from .. $to) {
        # say "- $id" if has_pattern($id);
        $invalids_sum += $id if has_pattern($id);
    }
}

say $invalids_sum;

__DATA__
11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
