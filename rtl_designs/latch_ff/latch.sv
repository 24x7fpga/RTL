`include "package.svh"
module latch (/*AUTOARG*/
   // Outputs
   l_out,
   // Inputs
   clk, rst, en, in
   );
   // Outputs
   output [3:0] l_out;
   // Inputs
   input	clk;
   input	rst;
   input	en;
   input [3:0]	in;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [3:0]		l_out;
   // End of automatics
   /*AUTOWIRE*/
   
   always@(en, rst, in)begin
      if(rst)
	l_out <= 1'b0;
      else
	if(en)
	  l_out <= in;
   end

endmodule // latch
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
