function [2:0] comp (input [31:0] a, b);
   
   logic [2:0] res;
   logic       et, gt, lt;
   
   et = (a==b) ? 1'b1 : 1'b0;
   gt = (a>b)  ? 1'b1 : 1'b0;
   lt = (a<b)  ? 1'b1 : 1'b0;
   
   
   res = {et,gt,lt};
   
   return res;

endfunction // comp
