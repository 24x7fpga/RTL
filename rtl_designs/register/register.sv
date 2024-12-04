`timescale 1ns/1ns 
module register(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   clk, rst, d
   ); 
   // Outputs
   output q;
   // Inputs
   input clk; 
   input rst;
   input d;
   
 
  /*AUTOREG*/ 
  // Beginning of automatic regs (for this module's undeclared outputs)
  reg			q;
  // End of automatics
  /*AUTOWIRE*/ 
 
always_ff@(posedge clk)
  if(rst)
    q <= 1'b0;
  else
    q <= d;
   
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
