`timescale 1ns/1ns
module tmds(/*AUTOARG*/
   // Outputs
   tmds_out1, tmds_out2,
   // Inputs
   clk, rst, de, ctl, d_in
   );
   
   // Outputs
   output [9:0] tmds_out1, tmds_out2;
   // Input
   input	clk;
   input	rst;
   
   input	de;
   input [1:0]	ctl;
   input [7:0]	d_in;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [9:0]		tmds_out1;
   reg [9:0]		tmds_out2;
   // End of automatics
   /*AUTOWIRE*/

   my_tmds MY_ENCODE (
		      // Outputs
		      .tmds_out		(tmds_out1[9:0]),
		      // Inputs
		      .clk		(clk),
		      .de		(de),
		      .ctl		(ctl[1:0]),
		      .d_in		(d_in[7:0]));
   tmds_encoder TEST (
		      // Outputs
		      .tmds_out		(tmds_out2[9:0]),
		      // Inputs
		      .clk		(clk),
		      .d_in		(d_in[7:0]),
		      .ctl		(ctl[1:0]),
		      .de		(de));
     

endmodule // tmds_top
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
       



