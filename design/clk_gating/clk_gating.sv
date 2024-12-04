`timescale 1ns/1ns 
module clk_gating(/*AUTOARG*/
   // Outputs
   g_clk_glitch, g_clk,
   // Inputs
   clk, en
   );
   // outputs
   output g_clk_glitch;
   output g_clk;
   // input
   input clk;
   input en;
  
   logic latch_en;
   
   assign g_clk_glitch = en & clk;
   
   always_comb
     if(!clk)
       latch_en <= en;

   assign g_clk = latch_en & clk;
   
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/clk_gating" ".")
// End:
