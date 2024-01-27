`timescale 1ns/1ns
module manchester_encoder (/*AUTOARG*/
   // Outputs
   d_out,
   // Inputs
   clk, d_in
   );

   input clk;
   input d_in;

   output d_out;

   assign d_out = d_in ^ clk;

endmodule // machester_encoder
// Local Variables: 
//verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
