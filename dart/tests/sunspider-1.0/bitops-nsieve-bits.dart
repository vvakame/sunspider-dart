// The Great Computer Language Shootout
//  http://shootout.alioth.debian.org
//
//  Contributed by Ian Osgood

String pad(num n, num width) {
  var s = n.toString();
  while (s.length < width) s = ' ${s}';
  return s;
}

void primes(List<num> isPrime, num n) {
  var i, count = 0, m = 10000<<n, size = m+31>>5;

  for (i=0; i<size; i++) isPrime[i] = 0xffffffff;

  for (i=2; i<m; i++)
    if ((isPrime[i>>5] & 1<<(i&31)) != 0) {
      for (var j=i+i; j<m; j+=i)
        isPrime[j>>5] &= ~(1<<(j&31));
      count++;
    }
}

List<num> sieve() {
  List<num> isPrime;
  for (var i = 4; i <= 4; i++) {
    isPrime = new List((10000<<i)+31>>5);
    primes(isPrime, i);
  }
  return isPrime;
}

void main() {
  var result = sieve();
}