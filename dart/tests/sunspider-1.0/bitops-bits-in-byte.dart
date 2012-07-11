// Copyright (c) 2004 by Arthur Langereis (arthur_ext at domain xfinitegames, tld com)


var result = 0;

// 1 op = 2 assigns, 16 compare/branches, 8 ANDs, (0-8) ADDs, 8 SHLs
// O(n)
num bitsinbyte(num b) {
  var m = 1, c = 0;
  while(m<0x100) {
    if((b & m) != 0) c++;
    m <<= 1;
  }
  return c;
}

num TimeFunc(num func(num)) {
  var x, y, t;
  var sum = 0;
  for(x=0; x<350; x++)
  for(y=0; y<256; y++) sum += func(y);
  return sum;
}

void main() {
  result = TimeFunc(bitsinbyte);
}
