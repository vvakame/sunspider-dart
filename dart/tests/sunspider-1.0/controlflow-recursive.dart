// The Computer Language Shootout
// http://shootout.alioth.debian.org/
// contributed by Isaac Gouy

num ack(num m, num n){
   if (m==0) { return n+1; }
   if (n==0) { return ack(m-1,1); }
   return ack(m-1, ack(m,n-1) );
}

num fib(num n) {
    if (n < 2){ return 1; }
    return fib(n-2) + fib(n-1);
}

num tak(num x, num y, num z) {
    if (y >= x) return z;
    return tak(tak(x-1,y,z), tak(y-1,z,x), tak(z-1,x,y));
}

void main() {
  for ( var i = 3; i <= 5; i++ ) {
    ack(3,i);
    fib(17.0+i);
    tak(3*i+3,2*i+2,i+1);
  }
}