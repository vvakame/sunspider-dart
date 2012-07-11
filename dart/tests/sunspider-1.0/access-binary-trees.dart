/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy */

class TreeNode {
  num item;
  TreeNode left;
  TreeNode right;
  
  TreeNode(this.left, this.right, this.item);
  
  num itemCheck() {
    if (this.left==null) return this.item;
    else return this.item + this.left.itemCheck() - this.right.itemCheck();
  }
}

TreeNode bottomUpTree(num item, int depth){
   if (depth>0){
      return new TreeNode(
          bottomUpTree(2*item-1, depth-1)
         ,bottomUpTree(2*item, depth-1)
         ,item
      );
   }
   else {
      return new TreeNode(null,null,item);
   }
}

void main() {
  num ret;
  
  for ( int n = 4; n <= 7; n += 1 ) {
      var minDepth = 4;
      var maxDepth = Math.max(minDepth + 2, n);
      var stretchDepth = maxDepth + 1;
      
      var check = bottomUpTree(0,stretchDepth).itemCheck();
      
      var longLivedTree = bottomUpTree(0,maxDepth);
      for (var depth=minDepth; depth<=maxDepth; depth+=2){
          var iterations = 1 << (maxDepth - depth + minDepth);
  
          check = 0;
          for (var i=1; i<=iterations; i++){
              check += bottomUpTree(i,depth).itemCheck();
              check += bottomUpTree(-i,depth).itemCheck();
          }
      }
  
      ret = longLivedTree.itemCheck();
  }
}