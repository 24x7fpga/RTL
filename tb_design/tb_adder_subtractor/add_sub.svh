function int add_sub (input [31:0] a, b, input ci);

   logic [31:0] sum;

   if(ci)
     sum = a - b;
   else
     sum = a + b;

   return sum;

endfunction // add_sub
