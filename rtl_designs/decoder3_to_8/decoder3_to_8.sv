`timescale 1ns/1ns 
module decoder3_to_8 #(parameter width = 3)(/*AUTOARG*/
   // Outputs
   out,
   // Inputs
   in
   ); 
   //outputs
   output [2**width-1:0] out;
   //inputs
   input [width-1:0] in;
   
   /*AUTOREG*/ 
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [2**width-1:0]	out;
   // End of automatics
   /*AUTOWIRE*/ 
 

   always_comb begin
      out = 1 << in;
   end
   
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End: 
