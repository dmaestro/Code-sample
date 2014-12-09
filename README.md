Code-sample
===========

This is a program I originally wrote in Perl, as an answer to a job
application test. The class comes from a perl module I had previously
written (in 2011) to solve some puzzle or other.

The problem is to print out the 333rd prime that has '3' as both its
first and last digit.

Note that the original module, Prime.pm, is included here, but is
actually inlined in the scripts primetest.pl and primetestmore.pl,
so is not necessary for those. (That is not an example of best
practice ;-)

I also needed a sample of PHP, so I rewrote it.

In translating to PHP, I did not use the _next_prime method that I
had written for the original class. Instead I used PHP's GMP extension,
which is presumably more suitable for production work.
