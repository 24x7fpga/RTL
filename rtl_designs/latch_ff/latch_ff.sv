`include "package.svh"
module latch_ff (/*AUTOARG*/
   // Outputs
   l_out, d_r_out, d_f_out,
   // Inputs
   clk, rst, en, in
   );
   // Outputs
   output [3:0] l_out;
   output [3:0]	d_r_out;
   output [3:0]	d_f_out;
   // Inputs
   input	clk;
   input	rst;
   input	en;
   input [3:0]	in;
   
   /*AUTOREG*/
   /*AUTOWIRE*/

   latch LAT (/*AUTOINST*/
	      // Outputs
	      .l_out			(l_out[3:0]),
	      // Inputs
	      .clk			(clk),
	      .rst			(rst),
	      .en			(en),
	      .in			(in[3:0]));

   flip_flop FF (/*AUTOINST*/
		 // Outputs
		 .d_r_out		(d_r_out[3:0]),
		 .d_f_out		(d_f_out[3:0]),
		 // Inputs
		 .clk			(clk),
		 .rst			(rst),
		 .en			(en),
		 .in			(in[3:0]));
   

endmodule // latch_ff
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
