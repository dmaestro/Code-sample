<?php

/**
 *
 *  This is a program I originally wrote in Perl, as an answer to a job
 *  application test. The class comes from a perl module I had previously
 *  written (in 2011) to solve some puzzle or other.
 *
 *  The problem is to print out the 333rd prime that has '3' as both its
 *  first and last digit.
 *
 *  In translating to PHP, I did not use the _next_prime method that I
 *  had written for the original class. Instead I used PHP's GMP extension,
 *  which is presumably more suitable for production work.
 *
 */

function prime_333() {
  $prime_test = new Prime(1000);
  $count = 333;
  $digits = 1;

  $last_prime = 'not found';
  $n = $count;
  while ($n > 0) {
    $range_first = '3' . str_repeat('0', $digits - 1);
    $range_last  = '3' . str_repeat('9', $digits - 1);
    $candidate = $range_first;
    while ($candidate+0 <= $range_last+0) {
      if (preg_match('/^3(\d*3)?$/', $candidate)) {
        if ($prime_test->is_prime($candidate)) {
          $last_prime = $candidate;
          if (--$n == 0)
            break;
        }
      }
      $candidate = ($candidate + 1) . '';
    }

    $digits += 1;
  }
  echo "The ${count}rd qualifying prime is: $last_prime";
}

class Prime
{
  private $_primes;
  private $_init;
  function __construct($init) {
    $this->_init = gmp_init($init);
    $this->_primes = array(gmp_init(2), gmp_init(3));
    while (gmp_cmp(end($this->_primes), $this->_init) < 0) {
      $this->_primes[] = gmp_nextprime(end($this->_primes));
    }
  }

  public function prime_list() {
    $results = array();
    foreach ($this->_primes as $prime) {
      $results[] = gmp_strval($prime);
    }
    return $results;
  }

  public function is_prime($test) {
    if (gmp_cmp($test, 2) < 0)
      return false;
    $limit = 1;
    foreach ($this->_primes as $prime) {
      if (gmp_cmp($test, $prime) == 0)
        return true;
      $limit = gmp_mul($prime, $prime);
      if (gmp_cmp($test, $limit) < 0)
        return true;
      if (gmp_sign(gmp_div_r($test, $prime)) == 0)
        return false;
    }
    throw new ErrorException('Prime Test Failed!');
  }
}

if (php_sapi_name() == 'cli') {
  prime_333();
  echo PHP_EOL;
}
else { ?>
  <p><?php prime_333(); ?></p>
<?php }
