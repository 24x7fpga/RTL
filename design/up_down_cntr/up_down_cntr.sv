`timescale 1ns/1ns 
module up_down_cntr #(parameter N = 4)(/*AUTOARG*/
   // Outputs
   dout,
   // Inputs
   up, clk, rst
   );
   // Outputs
   output [N-1:0] dout;
   // Inputs
   input	  up;
   input	  clk;   
   input	  rst;
 

   logic [N-1:0] cntr;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 

   always_ff@(posedge clk) begin
      if(rst)
	cntr <= 0;
      else
	if(up)
	  cntr <= cntr + 1;
	else
	  cntr <= cntr - 1;
   end
   
   assign dout = cntr;
   
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
