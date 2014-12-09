package Prime;

use strict;
use warnings;
use POSIX;
use Carp;

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
  confess "Unable to test prime greater than $limit";
}

1;
