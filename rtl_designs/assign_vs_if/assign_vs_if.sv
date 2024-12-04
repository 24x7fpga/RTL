`timescale 1ns/1ns 
module assign_vs_if(/*AUTOARG*/
   // Outputs
   d, c,
   // Inputs
   a, b, sel
   ); 

   // outputs
   output logic [1:0] d;
   output [1:0]	      c;
   // inputs
   input [1:0]	      a, b;
   input	      sel;
   
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 

   // assign statement
   assign c = sel ? a : b;

   // if statement
   always_comb
     if(sel)
       d = a;
     else
       d = b; 

endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
