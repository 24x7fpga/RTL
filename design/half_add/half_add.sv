`timescale 1ns/1ns 
module half_add(/*AUTOARG*/
   // Outputs
   s, co,
   // Inputs
   a, b
   ); 
  input a, b; 
  output s, co; 
 
  /*AUTOREG*/ 
  /*AUTOWIRE*/ 
 

  assign s  = a ^ b;
  assign co = a & b;
 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
