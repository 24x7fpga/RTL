`include "parameters.v"

`timescale 1ns/1ns
module fifo_sync(/*AUTOARG*/
   // Outputs
   sync_out,
   // Inputs
   sync_clk, sync_rst, sync_in
   );

   // outputs
   output [`ADDR_WIDTH:0] sync_out;
   // inputs
   input 		  sync_clk;
   input 		  sync_rst;
   input [`ADDR_WIDTH:0]  sync_in;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [`ADDR_WIDTH:0]	sync_out;
   // End of automatics

   /*AUTOWIRE*/

   
   reg [`ADDR_WIDTH:0] 	  sync_temp;

   always@(posedge sync_clk)
     begin
	if(!sync_rst)
	  {sync_out, sync_temp} <= 'h0;
	else
	  {sync_out, sync_temp} <= {sync_temp, sync_in};
     end

endmodule // fifo_sync
// Local Variables:
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
