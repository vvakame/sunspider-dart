/*
 * Copyright (C) Rich Moore.  All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY CONTRIBUTORS ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL APPLE COMPUTER, INC. OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
 */

/////. Start CORDIC

final num AG_CONST = 0.6072529350;

num FIXED(num X) => X * 65536.0;

num FLOAT(num X) => X / 65536.0;

num DEG2RAD(num X) => 0.017453 * (X);

List<num> Angles;

var Target = 28.027;

num cordicsincos(num _Target) {
  num X;
  int Y;
  num TargetAngle;
  num CurrAngle;
  int Step;
  
  X = FIXED(AG_CONST);         /* AG_CONST * cos(0) */
  Y = 0;                       /* AG_CONST * sin(0) */

  TargetAngle = FIXED(Target);
  CurrAngle = 0;
  for (Step = 0; Step < 12; Step++) {
      num NewX;
      if (TargetAngle > CurrAngle) {
          NewX = X - (Y >> Step);
          Y = (X.round().toInt() >> Step) + Y;
          X = NewX;
          CurrAngle += Angles[Step];
      } else {
          NewX = X + (Y >> Step);
          Y = -(X.round().toInt() >> Step) + Y;
          X = NewX;
          CurrAngle -= Angles[Step];
      }
  }

  return FLOAT(X) * FLOAT(Y);
}

///// End CORDIC

num total = 0;
  
int cordic(num runs) {
  var start = new Date.now();
  
  for (int i = 0 ; i < runs ; i++ ) {
    total += cordicsincos(Target);
  }

  var end = new Date.now();

  return end.difference(start).inMilliseconds;
}

void main(){
  Angles = [
            FIXED(45.0), FIXED(26.565), FIXED(14.0362), FIXED(7.12502),
            FIXED(3.57633), FIXED(1.78991), FIXED(0.895174), FIXED(0.447614),
            FIXED(0.223811), FIXED(0.111906), FIXED(0.055953),
            FIXED(0.027977)
            ];

  cordic(25000);
}