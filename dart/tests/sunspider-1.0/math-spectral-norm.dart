// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
//
// contributed by Ian Osgood

num A(num i, num j) {
  return 1/((i+j)*(i+j+1)/2+i+1);
}

void Au(List<num> u, List<num> v) {
  for (var i=0; i<u.length; ++i) {
    var t = 0;
    for (var j=0; j<u.length; ++j)
      t += A(i,j) * u[j];
    v[i] = t;
  }
}

void Atu(List<num> u, List<num> v) {
  for (var i=0; i<u.length; ++i) {
    var t = 0;
    for (var j=0; j<u.length; ++j)
      t += A(j,i) * u[j];
    v[i] = t;
  }
}

void AtAu(List<num> u, List<num> v, List<num> w) {
  Au(u,w);
  Atu(w,v);
}

num spectralnorm(num n) {
  var i, u=[], v=[], w=[], vv=0, vBv=0;
  for (i=0; i<n; ++i) {
    u[i] = 1; v[i] = w[i] = 0;
  }
  for (i=0; i<10; ++i) {
    AtAu(u,v,w);
    AtAu(v,u,w);
  }
  for (i=0; i<n; ++i) {
    vBv += u[i]*v[i];
    vv  += v[i]*v[i];
  }
  return Math.sqrt(vBv/vv);
}

void main() {
  for (var i = 6; i <= 48; i *= 2) {
    spectralnorm(i);
  }
}
