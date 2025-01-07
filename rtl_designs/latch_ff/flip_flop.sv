`include "package.svh"
module flip_flop (/*AUTOARG*/
   // Outputs
   d_r_out, d_f_out,
   // Inputs
   clk, rst, en, in
   );
   // Outputs
   output [3:0] d_r_out;
   output [3:0]	d_f_out;
   // Inputs
   input	clk;
   input	rst;
   input	en;
   input [3:0]	in;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [3:0]		d_f_out;
   reg [3:0]		d_r_out;
   // End of automatics
   /*AUTOWIRE*/
   
   // rising edge
   always@(posedge clk)begin
      if(rst)
	d_r_out <= 1'b0;
      else
	if(en)
	  d_r_out <= in;
   end

   // falling edge
   always@(negedge clk)begin
      if(rst)
	d_f_out <= 1'b0;
      else
	if(en)
	  d_f_out <= in;
   end

endmodule // flip_flop
// Local Variables:
// Verilog-Library-Directories: (".")
// End:

