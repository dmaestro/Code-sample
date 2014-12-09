#!/usr/bin/perl
use strict;
use warnings;

my $gen = Prime->new(1000);
my $count = 333;
my $digits = 1;

my $last_prime = "not found";
my $n = $count;
while ($n) {
  my $first = '3' . ('0' x ($digits - 1));
  my $last = "3" . ("9" x ($digits - 1));
  for my $candidate ($first+0 .. $last+0) {
    if ($candidate =~ /^3(\d*3)?$/ && $gen->is_prime($candidate)) {
      $last_prime = $candidate;
    # print "$candidate\n";
      --$n or last;
    }
  }
  $digits++;
}
print "The ${count}rd qualifying prime is: $last_prime\n";


=begin comment

$ time perl primetest.pl
The 333rd qualifying prime is: 302443

real    0m0.099s
user    0m0.069s
sys     0m0.005s

=cut

{
  package Prime;

=head1 TITLE

Prime

=head2 DESCRIPTION

This module was created by me, Douglas Schrag, to provide a way to quickly test
for the primality of a natural number. The tester object is primed with all of
the prime numbers up to the C<$init> value passed to the constructor. The
C<is_prime()> method uses a simple search for prime factors to determine
primality. (2011)

This method is reasonably efficient for primes less than 1,000,000,000.

=cut

  use strict;
  use warnings;
  use POSIX qw(floor);

  sub new {
    my ($this, $init) = @_;
    my $class = ref($this) || $this;

    return if ! (defined $init && $init+0 > 1);
    my @primes = (2,3);
    my $self = {
      _primes => \@primes,
    };
    bless $self, $class;
    while ($primes[-1] < $init) {
      $self->_next_prime;
    }
    return $self;
  }

  sub _next_prime {
    my ($self) = @_;
    my $try = $self->{_primes}->[-1];
    while (! $self->is_prime($try += 2)) { }
    push @{$self->{_primes}}, $try;
    return $try;
  }

  sub is_prime {
    my ($self, $test) = @_;

    return if ($test+0) < 2;
    my $limit = 1;
    for my $prime (@{$self->{_primes}}) {
      return 1 if $test == $prime;
      $limit = $prime * $prime;
      return 1 if $test < $limit;
      my $quot = $test / $prime;
      return if floor($quot) == $quot;
    }
    die "Unable to test prime greater than $limit";
  }

  1;

}
