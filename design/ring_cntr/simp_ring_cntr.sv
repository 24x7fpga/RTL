`timescale 1ns/1ns
module simp_ring_cntr #(parameter N = 4)(/*AUTOARG*/
   // Outputs
   sr_cntr,
   // Inputs
   clk, rst
   );
   // outputs
   output [N-1:0] sr_cntr;
   // inputs
   input	  clk;
   input	  rst;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [N-1:0]		sr_cntr;
   // End of automatics
   /*AUTOWIRE*/

   always_ff@(posedge clk)
     if(rst)
       sr_cntr <= 1;
     else
       sr_cntr <= {sr_cntr[0],sr_cntr[N-1:1]};

endmodule // simp_ring_cntr
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
   
