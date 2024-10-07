`timescale 1ns/1ns 
module mod_cntr #(parameter N = 4)(/*AUTOARG*/
   // Outputs
   mod_cntr,
   // Inputs
   clk, rst
   );
   // Outputs
   output [N-1:0] mod_cntr;
   // Inputs
   input	  clk;
   input	  rst;
   
   logic [$clog2(N)-1:0] cntr_reg, cntr_nxt;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 

   always_ff@(posedge clk)
     if(rst)
       cntr_reg <= 0;
     else
       cntr_reg <= cntr_nxt;

   always_comb
     cntr_nxt = (cntr_reg == N-1) ? 0 : cntr_reg + 1;

   assign mod_cntr = cntr_reg;
 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
