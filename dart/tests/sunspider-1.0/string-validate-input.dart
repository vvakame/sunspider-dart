List<String> letters;
List<int> numbers;
List<String> colors;

var endResult;

void doTest()
{
   endResult = "";

   // make up email address
   for (var k=0;k<4000;k++)
   {
      var username = makeName(6);
      var email = "";
      (k%2 != 0)?email="${username}@mac.com":email="${username}(at)mac.com";

      // validate the email address
      var pattern = new RegExp("^[a-zA-Z0-9\-\._]+@[a-zA-Z0-9\-_]+(\.?[a-zA-Z0-9\-_]*)\.[a-zA-Z]{2,3}\$/");

      if(pattern.hasMatch(email))
      {
         var r = "${email} appears to be a valid email address.";
         addResult(r);
      }
      else
      {
         var r = "${email} does NOT appear to be a valid email address.";
         addResult(r);
      }
   }

   // make up ZIP codes
   for (var s=0;s<4000;s++)
   {
      var zipGood = true;
      var zip = makeNumber(4);
      (s%2 != 0)?zip="${zip}xyz":zip=zip.concat("7");

      // validate the zip code
      for (var i = 0; i < zip.length; i++) {
          var ch = zip.charCodeAt(i);
          if (ch < "0".charCodes()[0] || ch > "9".charCodes()[0]) {
              zipGood = false;
              var r = "${zip} contains letters.";
              addResult(r);
          }
      }
      if (zipGood && zip.length>5)
      {
         zipGood = false;
         var r = "${zip} is longer than five characters.";
         addResult(r);
      }
      if (zipGood)
      {
         var r = "${zip} appears to be a valid ZIP code.";
         addResult(r);
      }
   }
}

String makeName(n)
{
   var tmp = "";
   for (var i=0;i<n;i++)
   {
      var l = (26*Math.random()).floor().toInt();
      tmp = "${tmp}${letters[l]}";
   }
   return tmp;
}

String makeNumber(n)
{
   var tmp = "";
   for (var i=0;i<n;i++)
   {
      var l = (9*Math.random()).floor().toInt();
      tmp = tmp.concat(l);
   }
   return tmp;
}

void addResult(r)
{
   endResult = "${endResult}\n${r}";
}

void main() {
  letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
  numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26];
  colors  = ["FF","CC","99","66","33","00"];
  doTest();
}