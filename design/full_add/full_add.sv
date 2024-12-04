`timescale 1ns/1ns 
module full_add(/*AUTOARG*/
   // Outputs
   s, co,
   // Inputs
   a, b, c
   ); 
  //outputs 
  output s, co; 
  //inputs
  input a, b, c; 
  /*AUTOREG*/ 
  /*AUTOWIRE*/ 

   assign s  = a ^ b ^ c;
   assign co = (a & b) | (b & c) | (c & a);
 
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/full_add" ".")
// End:
