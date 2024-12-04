`timescale 1ns/1ns
module manchester_encoder (/*AUTOARG*/
   // Outputs
   d_encod,
   // Inputs
   clk, d_in
   );

   input clk;
   input d_in;

   output d_encod;

   assign d_encod = d_in ^ clk;

endmodule // machester_encoder
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/manchester_scheme" ".")
// End:
