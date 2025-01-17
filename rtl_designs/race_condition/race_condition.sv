`include "package.svh"
module race_condition #(parameter N = 4) (/*AUTOARG*/
   // Outputs
   res, res_vld,
   // Inputs
   a, b, arg_vld, clk, rst
   );
   // Outputs
   output [N:0] res;
   output	res_vld;
   // Inputs
   input [N-1:0] a, b;
   input	 arg_vld;
   input	 clk;
   input	 rst;
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [N:0]		res;
   reg			res_vld;
   // End of automatics
   /*AUTOWIRE*/

   always_ff@(posedge clk)begin
      if(rst)begin
	 res_vld <= 1'b0;
	 res     <= '0;
      end else begin
	 if(arg_vld)begin
	    res_vld <= 1'b1;
	    res     <= a + b;
	 end else
	   res_vld  <= 1'b0;
      end
   end // always_ff@ (posedge clk)

endmodule // race_condition
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
