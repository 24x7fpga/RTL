`timescale 1ns/1ns
module twist_ring_cntr #(parameter N = 4) (/*AUTOARG*/
   // Outputs
   tr_cntr,
   // Inputs
   clk, rst
   );
   // outputs
   output [N-1:0] tr_cntr;
   // input
   input	  clk;
   input	  rst;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [N-1:0]		tr_cntr;
   // End of automatics
   /*AUTOWIRE*/

   always_ff@(posedge clk)
     if(rst)
       tr_cntr <= 0;
     else 
       tr_cntr <={~tr_cntr[0], tr_cntr[N-1:1]};

endmodule // twist_ring_cntr
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
